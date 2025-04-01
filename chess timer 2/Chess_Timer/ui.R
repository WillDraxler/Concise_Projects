

library(shiny)
library(shinythemes)


fluidPage(
    theme = shinytheme("slate"), 
    titlePanel("Chess Timer"), # Application title
    textInput("text_color", "Text Color", placeholder = "white"),
    textInput("back_color", "Background Color", placeholder = "#8c0450"),
    #textInput("font_type", "Font", placeholder = "#Georgia"),
    fileInput("file1", "Choose CSV File"),
    downloadButton("downloadData", "Download"),
    )

