#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(stringr)
library(RSQLite)
library(DT)
library(markdown)


# Define UI for application that draws a histogram
shinyUI(navbarPage(id = "navBar", 
                   title = img(src="logo_no_background.png", height= "30px"),
                   tabPanel("Home",
                            img(src="app_wordcloud.png", width = "100%"),
                            br(),
                            br(),
                            h2("Let me find your next words...", align = "center"),
                            fluidRow(
                              align="center", 
                              actionButton('onStart', 'Start')
                              ),
                            br(),
                            br()
                            ),
                   
                   tabPanel("Text Predictor",
                            sidebarPanel(
                              h2("Instructions"),
                              "Enter your text and select the number of predicted words you would like to see. Press",
                              code('Submit'),
                              "to get the most likely next word the algorithm is predicting. ",
                              br(),
                              br(),
                              "---------------------------------",
                              br(),
                              radioButtons("number_predictions", h3("Number of predictions:"),
                                           choices = list("5 words" = 5, "10 words" = 10,
                                                          "20 words" = 20), selected = 5),
                              
                              textInput("input_ngram", h3("Enter your text here:"), 
                                        value = ""),
                              actionButton('onSubmit', 'Submit')
                            ),
                            
                            mainPanel(
                              DTOutput('table'),
                              br(),
                              textOutput("out_text")
                            )
                            ),
                   
                   tabPanel("About",
                            includeMarkdown("about.md")
                            )
))
