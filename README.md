![CellQuant](../assets/assets/images/original/logo3.png) 

## Overview

CellQuant was created for the O'Donnell Lab at the University of Pittsburgh to quantify plasma membrane and vacuolar fluorescence in yeast cells.  

## Features

* Two membrane detection algorithms for cases with low/high fluorescence at the cell membrane
* Supplemental visual output
* Applet to demonstrate the program at different application settings
* Applet to sort and graph results

## How to Run

1.  Install [Docker](https://www.docker.com/products/docker-desktop)

2.  Make sure Docker is running and pull the cellquant image from Docker Hub.  **You only need to do this once!**

`docker pull odonnelllab/cellquant`

3.  Run the following command to create a container and run on port 3838.  The -v flag maps the container directories with the local file system.

`docker run --rm -p 3838:3838 -v $HOME:/srv/shiny-server/home odonnelllab/cellquant`

CellQuant will be running on localhost:3838.

A detailed installation tutorial is available [here](Tutorial/CellQuant-Installation-Instructions.pdf).

## Dependencies
* Docker

CellQuant was built with R 3.6.3 with the following package dependencies: 
```
Bioconductor::EBImage
stringr
shiny
shinyFiles
shinyjs
shinythemes
tidyr
```

## Upcoming Features

- [x] Mac OS compatibility
