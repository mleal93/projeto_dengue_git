source(file = "https://raw.githubusercontent.com/mleal93/projeto_dengue_git/master/source.descritivo.R",encoding = "UTF-8",local = F)
library(brazilmaps)
library(sf)
library(maps)
library(mapdata)
library(raster)
library(dplyr)
library(RColorBrewer)
library(shiny)
library(bs4Dash)
library(leaflet)
library(shinyWidgets)
library(shinycssloaders)
library(shinyBS)
library(shinyjs)
library(plotly)
library(RCurl)
library (readr)
library(ggplot2)
library(lubridate)
library(ggrepel)
library(tidyverse)
#library(dygraphs)
   
setview <- data.frame(lng= -51.6391,lat = -24.5401)
blu <- 'rgb(100, 140, 240)'
dblu <- 'rgb(0, 0, 102)'
red <- 'rgb(200, 30, 30)'
dred <- 'rgb(100, 30, 30)'
f1 <- list(family = "Arial", size = 10, color = "rgb(30, 30, 30)")
size_card = c(8,4)
 server <- function(input, output) {

   
  #  col <- reactiveValues(values = cores) 
  #  nzoom <- reactiveValues(values = 6)
  #  setview <- data.frame(lng= -51.6391,lat = -24.5401)
  #  
  # observeEvent(input$map.descritive_zoom,{
  #   
  #   nzoom$values <- input$map.descritive_zoom
  #   setview <- input$input$map.descritive_center
  #   
  # })
  #  
   observeEvent(list(input$toTop6), {
                    # input$toTop2,input$toTop3,input$toTop4,input$toTop5,input$toTop6), {
     shinyjs::runjs("window.scrollTo(0, 0)")
   })
   
   
 
   
   
   output$map.descritive <- renderLeaflet({
     source(file = "https://raw.githubusercontent.com/mleal93/projeto_dengue_git/master/aba_map_server.R",encoding = "UTF-8",local = F)
     leaflet(maps.cities2,
                 options = list(zoomControl = F)
         ) %>% addTiles() %>%
           setView(lng = setview$lng, lat = setview$lat, zoom=7) %>%
           addPolygons(
             fillColor = cores,
             weight = 2,
             opacity = 1,
             color = cores,fill = "black",stroke = T,
             dashArray = "3",
             fillOpacity = .95,
             highlight = highlightOptions(
               weight = 5,
               color = "#666",
               dashArray = "",
               fillOpacity = 0.5,
               bringToFront = TRUE),
             labelOptions = labelOptions(
               style = list("font-weight" = "normal", padding = "3px 8px"),
               textsize = "15px",
               direction = "auto"))  %>%
           addLegend(colors  = unique(cores),labels = unique(maps.cities2$macroregional), opacity = 1, title = "Macroregião",
                     position = "topleft")   
       
     
   })
   
  
   
   observe({
     source(file = "https://raw.githubusercontent.com/mleal93/projeto_dengue_git/master/aba_map_server.R",encoding = "UTF-8",local = F)
     output$map.descritive2 <- renderLeaflet({
       if(is.null(input$map.descritive_shape_click)){return()}
       leaflet(maps.cities2,
               options = list(zoomControl = F)
       ) %>% addTiles() %>%
         setView(lng = setview$lng, lat = setview$lat, zoom=7) %>%
         addPolygons(
           fillColor = cores2,layerId = as.numeric(maps.cities2$macroregional),
           weight = 2,
           opacity = 1,
           color = cores2,fill = "black",stroke = T,
           dashArray = "3",
           fillOpacity = .95,
           highlight = highlightOptions(
             weight = 5,
             color = "#666",
             dashArray = "",
             fillOpacity = 0.5,
             bringToFront = TRUE),
           labelOptions = labelOptions(
             style = list("font-weight" = "normal", padding = "3px 8px"),
             textsize = "15px",
             direction = "auto"))  %>%
         addLegend(colors  = unique(cores2),labels = paste0(unique(maps.cities2$regional),"ª Regional"), opacity = 1, title = "Regionais de Saúde",
                   position = "topleft")
       
     })
     
   })
   
   
   observe({
     
     output$paineis.descritive <- renderUI({
       if(is.null(input$map.descritive_shape_click)){return()}
      
       fluidRow(column(width = 8,
                       bs4Card(
                         title = fluidRow(HTML('<i class="fa fa-th-largestyle = "color:#0072B2;font-size:25px"></i>'),
                                          tags$b(c("MAPA POR REGIONAL")),style="font-size:24px"),
                         status = "transparent", width = 12,
                         closable = FALSE,
                         maximizable = TRUE, 
                         collapsible = TRUE,
                         collapsed = FALSE,
                         labelText = icon("question"),
                         labelTooltip = HTML("Clieque no icone '+' para ver mais informações. Clique no icone [ ] para ampliar para tela cheia."),
                         leafletOutput("map.descritive2")
                       )
                       ),
                column(width = 4,
                       bs4Card(
                         title = fluidRow(HTML('<i class="fa fa-th-largestyle = "color:#0072B2;font-size:25px"></i>'),
                                          tags$b(c("LISTA")),style="font-size:24px"),
                         status = "transparent", width = 12,
                         closable = FALSE,
                         maximizable = TRUE, 
                         collapsible = TRUE,
                         collapsed = FALSE,
                         labelText = icon("question"),
                         labelTooltip = HTML("Clieque no icone '+' para ver mais informações. Clique no icone [ ] para ampliar para tela cheia.")
                         
                       )
                       ),
         
             
         
           )
        
       
     })
     observeEvent(input$map.descritive_shape_click, {
       # input$toTop2,input$toTop3,input$toTop4,input$toTop5,input$toTop6), {
       shinyjs::runjs("window.scrollTo(0, 700)")
     })
     
   })
   
   
   
   output$descritive.sexo <- renderPlotly({plot.sexo })
   output$descritive.idade <- renderPlot({plot.idade })
   output$descritive.escolaridade <- renderPlot({plot.escolaridade })
   output$descritive.gestante <- renderPlot({plot.gestante })
   output$descritive.gestante2 <- renderPlot({plot.gestante2 })
   output$descritive.series <- renderPlotly({plot.series })
   
  #f output$teste <- renderDygraph({plot.serie_dygraph })

}
