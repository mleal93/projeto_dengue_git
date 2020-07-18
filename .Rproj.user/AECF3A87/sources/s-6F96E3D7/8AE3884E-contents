
library(shiny)
library(bs4Dash)
blu <- 'rgb(100, 140, 240)'
dblu <- 'rgb(0, 0, 102)'
red <- 'rgb(200, 30, 30)'
dred <- 'rgb(100, 30, 30)'
f1 <- list(family = "Arial", size = 10, color = "rgb(30, 30, 30)")
size_card = c(8,4)
ui <-bs4DashPage(
  navbar = bs4DashNavbar(
               #           style = "
               # border-radius: 10px;
               # box-shadow: 0 0 4px 0 rgba(69, 69, 69, 0.2);
               # margin: 0px 10px 30px 10px; padding: 10px;
               # background-image: url(dengue_logo6.jpg);
               # background-repeat: norepeat;
               # background-size: 50px 50px;
               #  background-color:rgba( 19,49,71, 0.95);
               #  background-blend-mode: lighten;"
                         # fluidRow(
                         #     tags$a(
                         #       #href = "http://est.ufmg.br/covidlp/home/pt/", 
                         #       tags$img(class="logo",src = "virus.png", title = "COVID-19 / 15ª REGIONAL DE SAÚDE ", 
                         #                height = "100px", style = "margin-top: 10px; margin-left: 20px")
                         #     )
                         #   )
                         ),
                         
  sidebar = bs4DashSidebar(disable = F,
                           inputId = "main_sidebar",
                           title = strong("Dashboard Dengue",style = "text-align:center;color:#000000;font-size:22px"),
                           src = "dengue_logo5.png",
                           status = "primary",
                           expand_on_hover = T,
                           elevation = 5,skin = "light",
                           bs4SidebarMenu(id = "mais_sidebar_menu",
                             bs4SidebarMenuItem(
                                 text = "Panorama",
                                 icon = "home",
                                 startExpanded = TRUE,
                                 tabName = "tab1"),
                             bs4SidebarMenuItem(
                               text = "Sobre",
                               icon = "info",
                               startExpanded = TRUE,
                               tabName = "tab2"
                               
                             )
                             
                             )),
  
  
  footer = bs4DashFooter(includeHTML("www/footer.html")),
  title = "Dashboard Dengue",
  enable_preloader = T,
  loading_background = dblu,
  controlbar = dashboardControlbar(),
  
  body = bs4DashBody(tabItems(
    tabItem(tabName = "tab1",
            fluidRow(column(width=12,
                            HTML('<i class="fa fa-home"style = "color:#0072B2;font-size:50px;padding-left:0px;"></i>
                                  <b style = "padding-left:15px;color:#000000;font-size:30px;">PANORAMA GERAL - DASHBOARD DENGUE </b>'))),
            fluidRow(
              lapply(1:2, FUN = function(i) {
                bs4Sortable(
                  width = size_card[i],
                  lapply(1:2, FUN = function(j) {
                    bs4Card(
                      title = tags$div(HTML('<i class="fa fa-th-largestyle = "color:#0072B2;font-size:25px"></i>'),
                                       tags$b(" CARDS"),style="font-size:24px"),
                      status = "transparent", width = 12,
                      closable = FALSE,
                      maximizable = TRUE, 
                      collapsible = TRUE,
                      collapsed = FALSE,
                      labelText = icon("question"),
                      labelTooltip = HTML("Clieque no icone '+' para ver mais informações. Clique no icone [ ] para ampliar para tela cheia.")
                    )
                  })
                )
              })
            )
            
            ),
    tabItem(tabName = "tab2",
            fluidRow(column(width=12,
                            HTML('<i class="fa fa-info"style = "color:#0072B2;font-size:50px;padding-left:0px;"></i>
                                  <b style = "padding-left:15px;color:#000000;font-size:30px;">SOBRE </b>')))
            
            )
    
    
  ))
  
  
)

