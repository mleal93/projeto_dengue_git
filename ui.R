
source(file = "librarys.R",encoding = "UTF-8",local = F)
source(file = "https://raw.githubusercontent.com/mleal93/projeto_dengue_git/master/aba_map_server.R",encoding = "UTF-8",local = F)
jscode <- "shinyjs.toTop = function() {document.body.scrollTop = 0;}"
jscode1 <- "shinyjs.toTop = function() {document.body.scrollTo = (0,700);}"
espaco_html <<- function(n=6){
  
  
  return(HTML( rep("<br>",n)))
  
  
}
blu    <- 'rgb(100, 140, 240)'
dblu   <- 'rgb(0, 0, 102)'
red    <- 'rgb(200, 30, 30)'
dred   <- 'rgb(100, 30, 30)'
f1     <- list(family = "Arial", size = 10, color = "rgb(30, 30, 30)")
size_card = c(8,4)
ui <-bs4DashPage(sidebar_collapsed = TRUE,
  navbar = bs4DashNavbar(
                                rightUi = HTML('<a href="https://github.com/mleal93/projeto_dengue_git"> 
                                          <i class="fa fa-github" style="font-size:20px; margin: 0px 20px"></i>
                                          <h5>GitHub</h5>
                                          </a>')
               #           style = "
               #           background-image: url(http://www.unespar.edu.br/APUCARANA/noticias/dengue-mata-mude-sua-atitude/logo-dengue.png);
               # background-repeat: norepeat;"
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
                           src = "https://raw.githubusercontent.com/mleal93/projeto_dengue_git/master/www/dash_logo.png",
                           status = "primary",
                           expand_on_hover = T,
                           elevation = 5,skin = "light",
                           bs4SidebarMenu(id = "main_sidebar_menu",flat = T,compact = T,child_indent = F,
                             bs4SidebarMenuItem(
                                 text = "Panorama",
                                 icon = "home",
                                 startExpanded = F,
                                 tabName = "tab1"),
                             bs4SidebarMenuItem(
                               text = "Descritivo",
                               icon = "map-marked-alt",
                               startExpanded = F,
                               tabName = "tab2"
                               
                             ),
                             bs4SidebarMenuItem(
                               text = "Sobre",
                               icon = "info",
                               startExpanded = F,
                               tabName = "tab3"
                               
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
      <a href="http://www.dma.uem.br/">
        <img src="https://raw.githubusercontent.com/mleal93/projeto_dengue_git/master/www/dma.png" style="width:125px;padding-left:15px;">
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
                                  <b style = "padding-left:15px;color:#000000;font-size:30px;">PANORAMA GERAL - DASHBOARD DENGUE </b>')))
           
            
            ),
    
    tabItem(tabName = "tab2",
            fluidRow(column(width=12,
                            HTML('<i class="fa fa-map-marked-alt"style = "color:#0072B2;font-size:50px;padding-left:0px;"></i>
                                  <b style = "padding-left:15px;color:#000000;font-size:30px;">DESCRITIVO </b>'))),
            
            
            fluidRow(column(width = 8,
                            bs4Card(
                              title = fluidRow(HTML('<i class="fa fa-th-largestyle = "color:#0072B2;font-size:25px"></i>'),
                                               tags$b(c("MAPA POR MACROREGIÃO")),style="font-size:24px"),
                              status = "transparent", width = 12,
                              closable = FALSE,
                              maximizable = TRUE, 
                              collapsible = TRUE,
                              collapsed = FALSE,
                              labelText = icon("question"),
                              labelTooltip = HTML("Clieque no icone '+' para ver mais informações. Clique no icone [ ] para ampliar para tela cheia."),
                              leafletOutput("map.descritive",height = 600)
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
            
            
            
            ),
            
            espaco_html(4),
            
           
            useShinyjs(),
            extendShinyjs(text = jscode),
            extendShinyjs(text = jscode1),
            uiOutput("paineis.descritive"),
            bs4Card(
              title = fluidRow(HTML('<i class="fa fa-th-largestyle = "color:#0072B2;font-size:25px"></i>'),
                               tags$b(c("PAINEL")),style="font-size:24px"),
              status = "transparent", width = 12,
              closable = FALSE,
              maximizable = TRUE, 
              collapsible = TRUE,
              collapsed = FALSE,
              labelText = icon("question"),
              labelTooltip = HTML("Clieque no icone '+' para ver mais informações. Clique no icone [ ] para ampliar para tela cheia."),
              bs4TabSetPanel(id = "tabpanel_descritive",side = "left",
                             bs4TabPanel(tabName = strong("SEXO"),active = TRUE,
                                         plotlyOutput(outputId = "descritive.sexo")
                                         
                             ),
                             bs4TabPanel(tabName = strong("FAIXA ETÁRIA"),active = FALSE,
                                         plotOutput("descritive.idade")
                                         
                             ),
                             bs4TabPanel(tabName = strong("ESCOLARIDADE"),active = FALSE,
                                         plotOutput("descritive.escolaridade")
                                         
                             ),
                             
                             bs4TabPanel(tabName = strong("GESTANTE"),active = FALSE,
                                         plotOutput("descritive.gestante"),
                                         plotOutput("descritive.gestante2")
                                         
                             ),
                             bs4TabPanel(tabName = strong("SÉRIE"),active = FALSE,
                                         plotlyOutput(outputId = "descritive.series")
                                         
                             )
                             )
            ),
           
            
            
    ),
    tabItem(tabName = "tab3",
            fluidRow(column(width=12,
                            HTML('<i class="fa fa-info"style = "color:#0072B2;font-size:50px;padding-left:0px;"></i>
                                  <b style = "padding-left:15px;color:#000000;font-size:30px;">SOBRE </b>')))
            
            )
    
    
  ))
  
  
)

