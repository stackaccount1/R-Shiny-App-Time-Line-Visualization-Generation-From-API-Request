library(shiny)
library(httr)
library(jsonlite)
library(lubridate)
library(tools)
library(timevis)
require(shiny)
require(shinyjs)
library(curl)

# Define UI for application 
ui <- fluidPage(
  
  # Application title
  titlePanel("Event Timeline"),
  # Input API INFo
  textInput(inputId = "apikey1", label = h3("API Key"), value = NULL, width = NULL, placeholder = ""),
  textInput(inputId = "userkey1", label = h3("USER EMAIL"), value = NULL, width = NULL, placeholder = ""),
  submitButton("Update View", icon("refresh")),
  hr(),
  timevisOutput("timeline"))
