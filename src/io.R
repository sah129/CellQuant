
 
# Function to read in tiff files from a single directory.  Tifs must be 
# formatted as CMAC-Frame1, GFP-Frame2.  This is the default output when
# batch converting .nd2s to tiffs in FIJI.
# Returns N x 2 array of structure [[filename] [filepath]] where N=number of 
# files.
read_in_imageset_files <- function(datapath)
{
  
  files <- list.files(path = datapath)
  imagesets <- matrix(NA, length(files), 2)
  colnames(imagesets) <- c("filepath", "filename")
  
  for(file in seq_along(files))
  {
    imagesets[file,"filename"] = str_remove(files[file], ".tif")
    imagesets[file,"filepath"]= files[file]
  }
  return(imagesets)
}


# Function to read and store channels from image.   Also stores unaltered
# pixel intensity matrices to reference when computing features later.
read_in_channels <- function(imageset, datasetpath, cnum)
{
  message("#####################################################")
  message(paste0("Examining image: ", imageset["filename"]))
  
  img <- readImage(file.path(paste0(datasetpath, "/", imageset["filepath"])))
  
  gfp <- img[,,cnum$gfp_channel]
  cmac <- img[,,cnum$cmac_channel]
  dic <- NULL
  
  ref_img <- readImage(file.path(paste0(datasetpath, "/", imageset["filepath"])),  as.is = TRUE)
  
  ref_gfp <- ref_img[,,cnum$gfp_channel]
  ref_cmac <- ref_img[,,cnum$cmac_channel]
  ref_dic <- NULL
  
  if(length(cnum$dic_channel) != 0)
  {
      dic <- img[,,cnum$dic_channel]
      ref_dic <- ref_img[,,cnum$dic_channel]
  }
  
  list(cmac = cmac, 
       gfp = gfp, 
       dic = dic,
       ref_cmac = ref_cmac, 
       ref_gfp = ref_gfp,
       ref_dic = ref_dic)
}


