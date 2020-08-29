library(shiny)
library(httr)
library(jsonlite)
library(lubridate)
library(tools)
library(timevis)
require(shiny)
require(shinyjs)
library(curl)

# Define server logic required to draw time line
server <- function(input, output) {
  observe({req(input$apikey1, input$userkey1)
    #Prepare Timeline information
    options(stringsAsFactors = FALSE)
    
    apikey2 <- input$apikey1
    
    userkey2 <- input$userkey1
    
    master_url <- sprintf("https://api.iterable.com:443/api/events/%s?api_key=%s",userkey2,apikey2)
    
    my_url <- master_url
    
    my_raw_result <- httr::GET(my_url)
    
    my_raw_result
    
    my_raw_result_text <- content(my_raw_result, "text")
    
    my_raw_result_json <- fromJSON(my_raw_result_text, flatten = TRUE)
    
    my_raw_result_df <- as.data.frame(my_raw_result_json)
    
    #View(my_raw_result_df)
    
    dt <-  my_raw_result_df
    
    # Prepare the data
    #dt[dt==""] <- NA # Replace all blank to NA
    dt$start <- as.Date(as.character(dt$events.createdAt, 1,10)) # reformat the date field to my preferred format
    #dt[,end] <- NA
    dt$content <- as.character(dt$events.eventType) # formate the content as text characters
    
    
    
    output$timeline <- renderTimevis({
      req(input$apikey1, input$userkey1)
      
      if (is.data.frame(dt)) 
        timevis(dt)
    })
  })}
