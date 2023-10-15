library(dplyr)
library(shiny)
library(shinydashboard)
library(DT)
library(uuid)

Custom.Style <- \() tags$head(
  tags$link(
    rel = "stylesheet",
    type = "text/css",
    href = "style.css"
  )
)