library(dplyr)
library(readr)
library(tidyr)
library(ggplot2)
library(data.table)

# funkcija ki pretvori datum rojstva v starost osebe
datum_v_starost <- function(datum_rojstva, trenutni_datum){
  starost <- year(trenutni_datum) - year(datum_rojstva) - 1
  docakal_rd <- 0
  if (month(trenutni_datum) > month(datum_rojstva))
    docakal_rd <- 1
  if (month(trenutni_datum) == month(datum_rojstva) & mday(trenutni_datum) >= mday(datum_rojstva))
    docakal_rd <- 1
  starost <- starost + docakal_rd
  return(starost)
}

Tabela20 <- read_csv2("podatki/Tabela20.csv", locale=locale(encoding="Windows-1250"))
TabelaTOP <- read_csv2("podatki/Tabela.csv", locale=locale(encoding="Windows-1250"))

tabelaBIO <- Tabela20 %>% select(ImePriimek, Rojstvo, Spol, Premozenje) %>%
  mutate(Starost =  datum_v_starost(Rojstvo, Sys.Date()))
  

# BIO

# izris povprecnega premozenja za dolocneo starost
povprecje <- tabelaBIO %>% group_by(Starost) %>%
  summarise(PovprecnoPremozenje = median(Premozenje, na.rm = FALSE))

ggBio1 <- ggplot(data=povprecje, aes(x=Starost, y=PovprecnoPremozenje)) + 
  geom_bar(stat = "identity", color="green") +
  geom_point(color="red")
ggBio1

# delez moskih in zensk
delez <- tabelaBIO %>% count(Spol)

ggBio2 <- ggplot(data=tabelaBIO, aes(x="", y=Spol, fill=Spol)) + 
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y", start=0) + 
  scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"), 
                    breaks=c("F", "M", "NA"),
                    labels=c("Ženske", "Moški", "Drugo")) +
  labs(title="Delež moških in žensk") + 
  xlab("") + 
  ylab("")
ggBio2


# tabela odstopanj
M_max_premozenje <- tabelaBIO[tabelaBIO$Spol == "M",] %>% slice_max(Premozenje)
M_max_starost <- tabelaBIO[tabelaBIO$Spol == "M",] %>% slice_max(Starost)
M_min_starost <- tabelaBIO[tabelaBIO$Spol == "M",] %>% slice_min(Starost)
M_mean <- tabelaBIO[tabelaBIO$Spol == "M",] %>% summarise(PvprecnaStarost = mean(Starost, na.rm = TRUE))

F_max_premozenje <- tabelaBIO[tabelaBIO$Spol == "F",] %>% slice_max(Premozenje)
F_max_starost <- tabelaBIO[tabelaBIO$Spol == "F",] %>% slice_max(Starost)
F_min_starost <- tabelaBIO[tabelaBIO$Spol == "F",] %>% slice_min(Starost)
F_mean <- tabelaBIO[tabelaBIO$Spol == "F",] %>% summarise(PvprecnaStarost = mean(Starost, na.rm = TRUE))

#moski
Odstopanja_M <- rbind(M_max_premozenje,
                           M_max_starost,
                           M_min_starost) %>% mutate(M_mean)
Odstopanja_M

#zenske
Odstopanja_F <- rbind(F_max_premozenje,
                      F_max_starost,
                      F_min_starost) %>% mutate(F_mean)
Odstopanja_F
### potrebno je se zdruziti tabele...

# PANG

tabelaPANG <- Tabela20 %>% select(ImePriimek, Kategorija, Premozenje)













