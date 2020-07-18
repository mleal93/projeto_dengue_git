
library(shiny)


ui <-navbarPage("App Title",
                   tabPanel("Plot"),
                   navbarMenu("More",
                              tabPanel("Summary"),
                              "----",
                              "Section header",
                              tabPanel("Table")
                   )
)

