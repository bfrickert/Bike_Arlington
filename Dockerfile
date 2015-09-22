FROM rocker/shiny:latest

RUN apt-get update && apt-get install -y \
	r-cran-xml

