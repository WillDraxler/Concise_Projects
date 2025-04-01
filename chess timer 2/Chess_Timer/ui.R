#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(shinythemes)

# Define UI for application that draws a histogram
fluidPage(
    theme = shinytheme("slate"),
    # Application title
    titlePanel("Chess Timer"),


    
    sidebarLayout(
        sidebarPanel(
          textInput("text_color", "Text Color", placeholder = "white"),
          textInput("back_color", "Background Color", placeholder = "#8c0450"),
          textInput("file_path", "File Path"),
          fileInput("file1", 
                    "Choose CSV File",
                    accept = ".csv")
                   ),
          downloadButton(outputId = "downloadData", label = "Download", icon = icon("file-download")),

        mainPanel(
            )
        )
    )

