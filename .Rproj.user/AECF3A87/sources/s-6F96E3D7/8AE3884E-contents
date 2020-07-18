
library(shiny)
library(bs4Dash)
blu <- 'rgb(100, 140, 240)'
dblu <- 'rgb(0, 0, 102)'
red <- 'rgb(200, 30, 30)'
dred <- 'rgb(100, 30, 30)'
f1 <- list(family = "Arial", size = 10, color = "rgb(30, 30, 30)")
size_card = c(8,4)
ui <-bs4DashPage(
  navbar = bs4DashNavbar(rightUi = HTML('<a href="https://github.com/mleal93/projeto_dengue_git"> 
                                          <i class="fa fa-github" style="font-size:20px; margin: 0px 20px"></i>
                                          <h5>GitHub</h5>
                                          </a>'),
                         style = "
                         background-image: url(http://www.unespar.edu.br/APUCARANA/noticias/dengue-mata-mude-sua-atitude/logo-dengue.png);
               background-repeat: norepeat;"
                         # fluidRow(
                         #     tags$a(
                         #       #href = "http://est.ufmg.br/covidlp/home/pt/",
                         #       tags$img(class="logo",src = "http://www.unespar.edu.br/APUCARANA/noticias/dengue-mata-mude-sua-atitude/logo-dengue.png", title = "DASHBOARD DENGUE ",
                         #                height="100",width="760", style = "margin-top: 0px; margin-left: 0px")
                         #     )
                         #   )
                         ),
                         
  sidebar = bs4DashSidebar(disable = F,
                           inputId = "main_sidebar",
                           title = strong("DASHBOARD",style = "color:#000000;font-size:22px"),
                           src = "https://github.com/mleal93/projeto_dengue_git/blob/master/www/dash_logo.png",
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
  
  
  footer = bs4DashFooter(HTML('<div class="footer">
  <div style="width: 100%;">
    <center>
       <div style="display:inline-flex">
        <a href="http://www.saude.pr.gov.br/">
        <img src="http://www.saude.pr.gov.br/sites/default/arquivos_restritos/files/imagem/2020-02/LogoSaude2019_Horizontal.png" style="height:100px">
      </a>
      <a href="http://www.uem.br/">
        <img src="https://s3-sa-east-1.amazonaws.com/casadenoticias/article_shots/images/27939/header/uem-modelo-01.png?1580416312" style="width:210px;padding-left:15px;">
      </a>
       <a href="http://www.des.uem.br/">
        <img src="http://www.pcs.uem.br/des/graduacao-2/Documentos/logo-des/" style="width:125px;padding-left:15px;">
      </a>
       
      </div>
    </center>
  </div>
</div>')),
  title = "Dashboard Dengue",
  enable_preloader = F,
  loading_background = dblu,
  controlbar = dashboardControlbar(),
  
  body = bs4DashBody(
               #        style = "
               #           background-image: url(http://www.unespar.edu.br/APUCARANA/noticias/dengue-mata-mude-sua-atitude/logo-dengue.png);
               # background-repeat: norepeat;",
                     tabItems(
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

