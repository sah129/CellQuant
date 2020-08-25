source("src/functions.R")

fluidPage( theme = shinytheme("slate"),
         shinyjs::useShinyjs(),
         titlePanel(h1("Automated Cell Quant - O'Donnell Lab", align = "center"), windowTitle = "Automated Cell Quant - O'Donnell Lab"),
         wellPanel(
           fluidRow(
             column(1, strong("1.")),
             column(3, shinyDirButton('input_dir', 'Input Folder', 'Please select a folder', style = "width: 100%")),
             column(6, textOutput("input_dir_text")),  
             column(2, actionButton("inputdir_help", "?"))),
           fluidRow(
             column(1, strong("2.")),
             column(3, shinyDirButton('output_dir', 'Output Folder', 'Please select a folder', style = "width: 100%")),
             column(6, textOutput("output_dir_text")), 
             column(2, actionButton("outputdir_help", "?"))),
           fluidRow(
             column(1, strong("3.")),
             column(3, textInput("cmac_chan", "CMAC", value = "", placeholder = "1")),
             column(3, textInput("gfp_chan", "GFP", value = "", placeholder = "2")),
             column(3, textInput("dic_chan", "DIC", value = "", placeholder = "3")),
             column(2, br(), actionButton("inputchannels_help", "?"))),
           fluidRow(
             column(1, strong("4.")),
             column(9, textInput("cutoff_value", "Cell size cutoff", placeholder="100")),
             column(2, br(), actionButton("cutoffvalue_help", "?"))),
           fluidRow(
             column(1, strong("5.")),
             column(9, radioButtons("algchoose", "Membrane Detection Algorithm", choices = c("GFP", "DIC"), selected = "GFP", inline = TRUE)),
             column(2, br(), actionButton("algchoose_help", "?"))),
           fluidRow(
             column(1, strong("6.")),
             column(9, radioButtons("factorchoose", "Factor:", choices = c("1", "2", "3", "4", "5"), selected = "5", inline = TRUE)),
             column(2, br(), actionButton("factorchoose_help", "?"))),
           fluidRow(column(9, offset = 1, actionButton("run", "Run Pipeline", width = "100%")))
           
         ),
         fluidRow(column(12, h5("Created by Sarah Hawbaker for the O'Donnell Lab at University of Pittsburgh, 2020"), align = "center"))
)