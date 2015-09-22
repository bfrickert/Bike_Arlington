FROM rocker/shiny:latest

RUN sudo apt-get -y update && apt-get -y upgrade
RUN apt-get -y install r-base r-base-dev

RUN sudo apt-get -y install libcurl4-openssl-dev
RUN sudo apt-get -y install libssl-dev/unstable
RUN sudo apt-get -y install libxml2-dev

RUN R -e "install.packages(c('devtools', 'plyr', 'dplyr', 'XML', 'forecast'), repos='http://cran.rstudio.com/')"

RUN R -e "devtools::install_github('rstudio/leaflet')"

