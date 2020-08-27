
function(input, output, session) 
{
    
    values <- reactiveValues()
    volumes = c(home = getwd(), root = getVolumes()())
    
    
    shinyDirChoose(input, 'input_dir', roots= volumes, session = session)
    
    dpath <- reactive(return(parseDirPath(volumes, input$input_dir)))
    
    output$input_dir_text <- renderText({dpath()})
    
    shinyDirChoose(input, 'output_dir', roots= volumes, session = session)
    
    opath <- reactive(return(parseDirPath(volumes, input$output_dir)))
    
    output$output_dir_text <- renderText({opath()})
    
    
    # help buttons
    observeEvent(input$inputdir_help, {
    showModal(modalDialog(
    title = "Input Folder",
    "Folder containing .tif images to be processed.",
    easyClose = TRUE,
    footer = NULL
    ))
    })
    observeEvent(input$outputdir_help, {
    showModal(modalDialog(
    title = "Output Folder",
    "Folder where resulting images and spreadsheets should be stored.",
    easyClose = TRUE,
    footer = NULL
    ))
    })
    observeEvent(input$inputchannels_help, {
    showModal(modalDialog(
    title = "Input Channels",
    "Frame numbers for the different channels of the .tif file.  If there is no DIC channel, leave the field blank.",
    easyClose = TRUE,
    footer = NULL
    ))
    })
    observeEvent(input$cutoffvalue_help, {
    showModal(modalDialog(
    title = "Cell Area Cutoff",
    HTML(paste0("This should be obtained in imageJ using the \"Measure\" tool.  See the Automated Quant Tutorial for more details.")),
    easyClose = TRUE,
    footer = NULL
    ))
    })
    observeEvent(input$algchoose_help, {
    showModal(modalDialog(
    title = "PM Detection Algorithm",
    HTML(paste0("If fluorescence is localized at the cell membrane, the GFP algorithm is most suitable.  Use the DIC algorithm only for images with high intracelluar fluorescence.  For a demonstration of both algorithms, use the Pipeline Options Tool or watch the Automated Quant Tutorial for a more in-depth explanation.")),
    easyClose = TRUE,
    footer = NULL
    ))
    })
    observeEvent(input$factorchoose_help, {
    showModal(modalDialog(
    title = "Brightness Level",
    HTML(paste0("For most microscope images, the brightest level (5) is ideal for the GFP algorithm, while (2) is ideal for the DIC algorithm. However you should use the Pipeline Options Tool to demonstrate both algorithms at all brightness settings.  See the Automated Quant Tutorial for a more in-depth explanation.")),
    easyClose = TRUE,
    footer = NULL
    ))
    })
    
    observeEvent(input$run,
    {
     
     if (is.null(dpath()) || is.null(input$factorchoose) || is.null(input$gfp_chan) || is.null(input$cmac_chan) || is.null(input$dic_chan) || is.null(input$algchoose) || is.null(input$cutoff_value))
     {
       print('null')
       return(NULL)
     }
     else if( !(str_trim(input$cmac_chan) %in% c("1", "2", "3")))
     {
       showModal(modalDialog(title = "Invalid Input", "Invalid value for CMAC channel.", easyClose = TRUE, footer = NULL))
     }
     else if( !(str_trim(input$gfp_chan) %in% c("1", "2", "3")))
     {
       showModal(modalDialog(title = "Invalid Input", "Invalid value for GFP channel.", easyClose = TRUE, footer = NULL))
     }
     else if( !(str_trim(input$dic_chan) %in% c("1", "2", "3", "")))
     {
       showModal(modalDialog(title = "Invalid Input", "Invalid value for DIC channel.", easyClose = TRUE, footer = NULL))
     }
     else if(any(duplicated(c(input$cmac_chan, input$dic_chan, input$gfp_chan))))
     {
       showModal(modalDialog(title="Invalid Input", "Different channels cannot have the same value", easyClose = TRUE, footer = NULL))
     }
     else
     {
       progress <- shiny::Progress$new()
       
       on.exit(progress$close())
       
       progress$set(message = "Setting up...", value = 0)
       
       
       withCallingHandlers(
         {
           shinyjs::html("stream_main", "")
           values$res <-pipeline(dpath(),
                                 gui=TRUE, 
                                 progress=progress, 
                                 factor = input$factorchoose, 
                                 gfp_chan = input$gfp_chan,
                                 dic_chan = input$dic_chan,
                                 cmac_chan = input$cmac_chan,
                                 alg = input$algchoose,
                                 cutoff = input$cutoff_value,
                                 outpath = opath()) 
           
         },
         message = function(m) {
           shinyjs::html(id = "stream_main", html = m$message, add = TRUE) #save the logfile somewhere
           values$log <- paste0(values$log, m$message)
         })
       
       showModal(modalDialog(
         title = "Automated quantification complete!",
         HTML(paste0("Want to sort and graph your data?  Go to ",
                     a("https://odonnelllab.shinyapps.io/QuantSort/", href = "https://odonnelllab.shinyapps.io/QuantSort/"),
                     " and upload your spreadsheets.")),
         easyClose = TRUE,
         footer = NULL
       ))
       
       fileConn<-file(paste0(opath(), "/log.txt"))
       writeLines(values$log, fileConn)
       close(fileConn)
       
     }
   })
    
    # Close the app when the session completes
    if(!interactive()) {
      session$onSessionEnded(function() {
        stopApp()
        q("no")
      })
    }

}
    
