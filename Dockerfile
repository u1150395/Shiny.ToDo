# Base image https://hub.docker.com/u/rocker/
#If there is a specific version you want to use, change the latest to whatever version you want to use that is available
#at the rocker/shiny docker hub website: https://hub.docker.com/r/rocker/shiny/tags
FROM rocker/shiny:latest

# system libraries of general use
## install debian packages
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
  libxml2-dev \
  libcairo2-dev \
  libsqlite3-dev \
  libmariadbd-dev \
  libpq-dev \
  libssh2-1-dev \
  unixodbc-dev \
  libcurl4-openssl-dev \
  libssl-dev

## update system libraries
RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get clean


#Assuming every Shiny App development has a DESCRIPTION file included, 
#copy the DESCRIPTION file to the Docker image you want to build.
COPY DESCRIPTION .

#This will install the remotes package first and then install the packages under the DESCRIPTION file.
#Documentation for install_deps() function can be found here: https://rdrr.io/cran/remotes/man/install_deps.html
RUN R -e 'install.packages("remotes"); remotes::install_deps(dependencies = TRUE)'

#create a folder in Docker to where we will copy our ShinyApp folder
RUN mkdir ./app

#Make sure that you are already in the ShinyApp folder so you do not encounter errors when running the docker build command
#For full context:https://stackoverflow.com/questions/49382636/dockerfile-copy-directory-from-windows-host-to-docker-container
ADD ./ ./app

#Shiny server runs on port 3838 by default. If you wish to use another port, uncomment the EXPOSE command below and 
#change the port number to whatever you want to use
#EXPOSE 3838

#Run the CMD command with ENTRYPOINT
ENTRYPOINT ["sh", "-c"]

#Tell the docker to run the /app folder containing the ShinyApp at localhost with port 3838
CMD ["R -e 'shiny::runApp(\"/app\", host=\"0.0.0.0\", port=3838)'"]
