rm(list=ls())
source(file = "librarys.R",encoding = "UTF-8",local = F)
rm_accent <- function(str,pattern="all") {
  if(!is.character(str))
    str <- as.character(str)
  pattern <- unique(pattern)
  if(any(pattern=="Ç"))
    pattern[pattern=="Ç"] <- "ç"
  symbols <- c(
    acute = "áéíóúÁÉÍÓÚýÝ",
    grave = "àèìòùÀÈÌÒÙ",
    circunflex = "âêîôûÂÊÎÔÛ",
    tilde = "ãõÃÕñÑ",
    umlaut = "äëïöüÄËÏÖÜÿ",
    cedil = "çÇ"
  )
  nudeSymbols <- c(
    acute = "aeiouAEIOUyY",
    grave = "aeiouAEIOU",
    circunflex = "aeiouAEIOU",
    tilde = "aoAOnN",
    umlaut = "aeiouAEIOUy",
    cedil = "cC"
  )
  accentTypes <- c("´","`","^","~","¨","ç")
  if(any(c("all","al","a","todos","t","to","tod","todo")%in%pattern)) # opcao retirar todos
    return(chartr(paste(symbols, collapse=""), paste(nudeSymbols, collapse=""), str))
  for(i in which(accentTypes%in%pattern))
    str <- chartr(symbols[i],nudeSymbols[i], str)
  return(str)
}
library(RCurl)

library (readr)

urlfile="https://raw.githubusercontent.com/mleal93/projeto_dengue_git/master/www/regionais.csv"

regionais<-read_csv(url(urlfile),col_names = T)


#regionais         <-  read.table(source(file = "https://raw.githubusercontent.com/mleal93/projeto_dengue_git/master/www/regionais.csv"),sep = ",")


maps.cities           <- get_brmap(geo = "City", geo.filter = list(State=41),class= "sf")
maps.cities$nome      <- as.character(maps.cities$nome)
maps.state            <- get_brmap(geo = "State", geo.filter = list(State=41),class      = "sf")
# maps.meso             <- get_brmap(geo = "MesoRegion", geo.filter = list(State=41),class      = "sf")
# maps.micro            <- get_brmap(geo = "Micro", geo.filter = list(State=41),class      = "sf")
# brasil_map            <- get_brmap(geo = "State",class      = "sf")


cities          <- data.frame(nome=maps.cities$nome,City=maps.cities$City)
cities$nome     <-  tolower(rm_accent(cities$nome))
cities.completo <- left_join(x = regionais,y = cities,"nome")
maps.cities2    <-  left_join(x = maps.cities,y = cities.completo,"City")

maps.cities2$macroregional[33] <- "Oeste"
maps.cities2$macroregional[131] <- "Norte"
maps.cities2$regional[33] <- "Oeste"
maps.cities2$regional[131] <-  19
maps.cities2$regional[33] <-  8



col.brew <- brewer.pal(n = 6, name = "Set1")
colors   <- col.brew
getColor <- function(med) {
  cols <- c()
  
  if(med == "Norte") {
    return(colors[1])
  } else if(med == "Oeste") {
    return(colors[2])
  } else if(med == "Leste") {
    return(colors[3])
  }else if(med == "Noroeste") {
    return(colors[4])
  }
  
  
  return(cols)
}


cores <- c()

for(i in 1:length(maps.cities2$macroregional)){
  
  cores[i] <- getColor(maps.cities2$macroregional[i])
  
}
col.brew2 <- c(brewer.pal(n = 9, name = "Set1"),brewer.pal(n = 8, name = "Dark2"),brewer.pal(n = 9, name = "Paired"))

getColor2 <- function(x) {
 switch (x,
    "1" = col.brew2[1],
    "2" = col.brew2[2],
    "3" = col.brew2[3],
    "4" = col.brew2[4],
    "5" = col.brew2[5],
    "6" = col.brew2[6],
    "7" = col.brew2[7],
    "8" = col.brew2[8],
    "9" = col.brew2[9],
    "10" = col.brew2[10],
    "11" = col.brew2[11],
    "12" = col.brew2[12],
    "13" = col.brew2[13],
    "14" = col.brew2[14],
    "15" = col.brew2[15],
    "16" = col.brew2[16],
    "17" = col.brew2[17],
    "18" = col.brew2[18],
    "19" = col.brew2[19],
    "20" = col.brew2[20],
    "21" = col.brew2[21],
    "22" = col.brew2[22],
  )
 
  
  
}

getColor2(22)


cores2 <- c()

for(i in 1:length(maps.cities2$macroregional)){
  
  cores2[i] <- getColor2(maps.cities2$regional[i])
  
}
