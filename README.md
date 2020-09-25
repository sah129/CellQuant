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

## Membrane Algorithm Demonstration & Configuration Settings

[PMDetectionDemo](https://github.com/sah129/PMDetectionDemo) is a visual tool to help users configure the CellQuant automated pipeline. The applet demonstrates all possible membrane detection algorithms at all possible settings.  Installation instructions and source code can be found on the [GitHub repository](https://github.com/sah129/PMDetectionDemo) but the Docker commands repeated below:

Install:  `docker pull odonnelllab/pm-detection-demo`

Run:  `docker run --rm -p 3838:3838 -v $HOME:/srv/shiny-server/home odonnelllab/pm-detection-demo`

The applet will be running on locahost:3838.

## Grouping and Sorting

[QuantSort](https://github.com/sah129/QuantSort) is an applet designed to help sort, group, and graph the output of CellQuant.  It can be found online at https://odonnelllab.shinyapps.io/QuantSort/  or downloaded as part of the CellQuant [bundled release](https://github.com/sah129/CellQuant/releases/).



## Dependencies
* Docker

## Packages

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
