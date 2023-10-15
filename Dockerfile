# Base image from Docker hub https://hub.docker.com/r/rocker/shiny
FROM rocker/shiny

#defining working directory
WORKDIR ./app

# Debian packages required for Shiny and R packages
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    libxml2-dev \
    libcairo2-dev \
    libsqlite3-dev \
    libmariadbd-dev \
    libpq-dev \
    libssh2-1-dev \
    unixodbc-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*
# install app dependencies from DESCRIPTION FILE
#using install_deps() functions 

COPY DESCRIPTION .
RUN R -e 'install.packages("remotes"); remotes::install_deps(dependencies = TRUE)'
COPY . .

CMD ["R", "-e", "shiny::runApp('/app', host = '0.0.0.0', port = 3838)"]