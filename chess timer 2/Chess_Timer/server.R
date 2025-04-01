
library(shiny)
library(tidyverse)
library(magick)
library(grid)
library(glue)
library(shinythemes)

# Define server logic required to draw a histogram
function(input, output) {
  
  output$downloadData <- downloadHandler(
    
    filename = glue("chess_photos_", 
                    as.integer(as.Date(Sys.Date())) - 20178, 
                    ".zip"),
    
    content = function(file){
      temp_directory <- file.path(tempdir(), as.integer(Sys.time()))
      dir.create(temp_directory) #Courtesy of Kyle Weise and Andy Baxter - creates temp dir
      
      vis <- NA #Create vis as an empty object for later storage
      
      data <- read.csv(input$file1$datapath,
                       header = T,
                       sep = ",",
                       quote = '"')
      chr_deselect <- function (quote_text){
        if (length(quote_text) > 40) {
          final_output <<- quote_text}
        else {
          if (str_sub(temp_select, chr_end, chr_end) == " "){
            final_output <<- glue(final_output, "\n", temp_select)
          } else {
            chr_end <<- chr_end - 1
            temp_select <<- str_sub(quote_text, chr_start, chr_end)
            chr_deselect(quote_text)
          }
        }
      }
      
      line_break <- function (quote_text) {
        temp_select <<- str_sub(quote_text, chr_start, chr_end)
        chr_deselect(quote_text)
        end_select <<- str_sub(quote_text, (chr_end + 1), -1)
        if (str_length(end_select) >= 40) {
          line_break(end_select)
        } else {
          final_output <<- glue(final_output, "\n", end_select)
        }
      }
      
      run_line_break <- function (input_text) {
        final_output <<- ""
        chr_start <<- 1
        chr_end <<- 40
        line_break(input_text)
      }
      
      generate_images <- function (quote_num) {
        vis <- image_annotate(image_blank(1000,1000, input$back_color), 
                                    run_line_break(data[quote_num, 1]), 
                                    gravity = "Center", 
                                    font = "Times New Roman", 
                                    size = 40, 
                                    color = input$text_color)
        image_write(vis, file.path(temp_directory, glue("image_", quote_num, ".jpg")), quality = 90)
      }
      
      for (x in 1:10) {
        generate_images(x)
      }
      zip::zip(
        zipfile = file,
        files = dir(temp_directory),
        root = temp_directory) #same courtesy
    },
    
    contentType = "application/zip"

  )
  
}