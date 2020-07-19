library(ISOweek)
library(tidyverse)
library(ggrepel)
library(dplyr)
library(foreign)
library(lubridate)
library(plotly)
library(RColorBrewer)
library("ggplot2")


setwd("C:/Users/Dani Granzotto/Google Drive/DengueEstatistica/Dados")
df1 <- read.dbf("DENGON193152se29.dbf")
df2 <- read.dbf("DENGON200129se29.dbf")

df0 <- rbind(df1,df2)
df <- df0[df0$CLASSI_FIN==10|df0$CLASSI_FIN==11|df0$CLASSI_FIN==12,]
table(df$CLASSI_FIN)
range(df$DT_NOTIFIC,na.rm = T)
    

################################# SEXO #####################################################################
tab.sexo <- paste(round(prop.table(table(df$CS_SEXO))*100,2),"%") #Já multiplicado por 100%, ORDEM: FEM, INDETERMINADO, MASC


################################# IDADE ####################################################################
nascimento  <- df$DT_NASC
notificacao <- df$DT_NOTIFIC
idade<-as.numeric(floor((notificacao-nascimento)/365.25))
id<-data.frame(idade,nascimento,notificacao)

id$clas.idade <- ifelse(id$idade < 11, "0-10",
                        ifelse(id$idade < 21, "11-20",
                               ifelse(id$idade < 31, "21-30",
                                      ifelse(id$idade < 41, "31-40",
                                             ifelse(id$idade < 51, "41-50",
                                                    ifelse(id$idade < 61, "51-60",
                                                           ifelse(id$idade < 71, "61-70",
                                                                  ifelse(id$idade < 81, "71-80","80 ou mais"))))))))

d<-data.frame(prop.table(table(id$clas.idade,sexo=df$CS_SEXO)))
d <- d[d$sexo!="I",]
ggplot(data = d, 
       mapping = aes(
         x = Var1, 
         y = ifelse(test = sexo == "F",  yes = -Freq, no = Freq), 
         fill = sexo,
         label=paste(round(Freq*100, 0), "%", sep="")
       )) +
  geom_bar(stat = "identity") +
  geom_text(hjust=ifelse(test = d$sexo == "F",  yes = 1.1, no = -0.1), size=6, colour="#505050") +
  scale_y_continuous(labels = abs, limits = max(d$Freq) * c(-1,1) * 1.1) +
  scale_fill_manual(values=as.vector(c("#CE1256","#08519C"))) +
  #labs(x = "",y = "",fill="",family=fontsForCharts ) +
  #theme_minimal(base_family=fontsForCharts, base_size=20) +   
  coord_flip() +
  theme(  
    axis.text.x=element_blank(), 
    axis.text.y=element_text(size=18), 
    legend.position="none",
    legend.text=element_text(size=20),
    axis.ticks = element_blank()
  )+ ylab("")+xlab(" ")



################################# ESCOLARIDADE ################################################################
tab.escolaridade <- paste(round(prop.table(table(df$CS_SEXO))*100,2),"%") #Já multiplicado por 100%, 
verde <- brewer.pal(n=9,"Greens")
cores<- c("#CB181D",rep(verde[c(9,8,7,6)],each=2),"#F7FCB9","#F7FCB9")

Escolaridade <- factor(df$CS_ESCOL_N,
                       levels=c(0:10),
                       labels=c("Analfabeto", "Fundamental I incompleto", "Fundamental I completo",
                                "Fundamental II incompleto", "Fundamental II completo",
                                "Médio incompleto", "Médio completo",
                                "Superior incompleto", "Superior completo", "Ignorado","Não se aplica"))
esc.dt <- as.data.frame(table(Escolaridade))
Percentuais <- esc.dt$Freq / sum(esc.dt$Freq)
d <- data.frame(esc.dt,Percentuais,q.val=c(1:11))

ggplot(data = d, 
       mapping = aes(
         x = Escolaridade, 
         y = Percentuais, 
         fill = factor(q.val),
         label=paste(round(Percentuais*100, 0), "%", sep="")
       )) +
  geom_bar(stat = "identity") +
  geom_text(hjust=.001, size=6) +
  scale_fill_manual(name = " ",  values =cores)+
  coord_flip() + ylim(0,max(Percentuais)+.02)+
  theme( 
    axis.text.x=element_blank(), 
    axis.text.y=element_text(size=18), 
    legend.position="none",
    legend.text=element_text(size=20),
    axis.ticks = element_blank()
  )+ ylab("")+xlab(" ")


################################# GESTANTE #####################################################################
tab.gestante <- paste(round(prop.table(table(df$CS_GESTANT))*100,2),"%") #Já multiplicado por 100%, ORDEM: FEM, INDETERMINADO, MASC

Gestante<- ifelse(df$CS_GESTANT==9,"Ignorado",
             ifelse(df$CS_GESTANT==6,"NSA",
                    ifelse(df$CS_GESTANT==5,"Não","Sim")))
esc.dt<-as.data.frame(table(Gestante))

esc.dt$fraction1 <- as.numeric(round(esc.dt$Freq / sum(esc.dt$Freq),4))
esc.dt$ymax = cumsum(esc.dt$fraction)
esc.dt$ymin = c(0, head(esc.dt$ymax, n=-1))
esc.dt$labelPosition <- (esc.dt$ymax + esc.dt$ymin) / 2
esc.dt$fraction <- format(round(esc.dt$fraction1*100, 1), nsmall = 1)
esc.dt$label <- paste0(esc.dt$fraction,"%")

cores <- c("#006D2C","#41AB5D","#F7FCB9","#A50F15")



ggplot(esc.dt, aes(ymax=ymax, ymin=ymin, xmax=4, xmin=3, fill=Gestante)) +
  geom_rect() +
  geom_label_repel( x=3.5, aes(x = " ",y=labelPosition, label=label), data = esc.dt, size=6, show.legend = F, nudge_x = 1)+
  scale_fill_brewer(name = " ", palette = "Paired")+
  coord_polar(theta="y") + # Try to remove that to understand how the chart is built initially
  xlim(c(2, 4))+
  theme_void() +
  theme(legend.position = "bottom",
        legend.text = element_text(size=14))




S_Gestante <- as.numeric(df$CS_GESTANT)[Gestante=="Sim"]
esc.dt <- as.data.frame(table(S_Gestante))
Percentuais <- esc.dt$Freq / sum(esc.dt$Freq)
d <- data.frame(esc.dt,Percentuais,q.val=c(1:4))

ggplot(data = d, 
       mapping = aes(
         x = c("1º Trimestre","2º Trimestre","3º Trimestre","Ignorado"), 
         y = Percentuais, 
         fill = factor(q.val),
         label=paste(round(Percentuais*100, 0), "%", sep="")
       )) +
  geom_bar(stat = "identity") +
  geom_text(hjust=.001, size=6) +
  scale_fill_brewer(name = " ",  palette ="Blues")+
  coord_flip() + ylim(0,max(Percentuais)+.02)+
  theme( 
    axis.text.x=element_blank(), 
    axis.text.y=element_text(size=18), 
    legend.position="none",
    legend.text=element_text(size=20),
    axis.ticks = element_blank()
  )+ ylab("")+xlab(" ")



################################# SERIE CASOS MENSAIS ######################################################
x <- paste0(2000:2017, "-01-01")
x <- as.Date(x)
y <- ISOweek(x)
print(y)
range(notificacao,na.rm = T)

df <- df %>%
  mutate(date = ymd(DT_NOTIFIC),
         dia = day(DT_NOTIFIC),
         mes = month(DT_NOTIFIC),
         ano = year(DT_NOTIFIC),
         semana = week(DT_NOTIFIC))


df1<- df %>% 
  mutate(week = cut.Date(DT_NOTIFIC, breaks = "1 week", labels = FALSE)) %>% 
  mutate(label_serie=paste0(mes,"-",ano,"-","Week",week)) %>%
  arrange(DT_NOTIFIC) 

df2<- df1 %>% group_by(week) %>% 
  summarise(frequencia = n(),
            label = label_serie) 

fig<-plot_ly(x = df2$label, y = df2$frequencia, mode = 'lines+markers', type="scatter")
fig


