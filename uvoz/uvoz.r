library(httr)
library(dplyr)
library(jsonlite)
library(rjson)

#uvoz json datoteke
data20 <- fromJSON(file="podatki/billionaires20.json")
data19 <- fromJSON(file="podatki/billionaires19.json")
data18 <- fromJSON(file="podatki/billionaires18.json")
data17 <- fromJSON(file="podatki/billionaires17.json")
data16 <- fromJSON(file="podatki/billionaires16.json")
data15 <- fromJSON(file="podatki/billionaires15.json")

#Glavna tabela za leto 2020

stolpci_stari <- c("personName", "birthDate", "gender", "country", "finalWorth", "category", "source")
stolpci_novi <- c("ImePriimek", "Rojstvo", "Spol", "Drzava", "Premozenje", "Kategorija",  "Vir")

Tabela20 <- lapply(data20$personList$personsLists,
                 . %>% .[stolpci_stari] %>% setNames(stolpci_novi) %>% # poskrbimo za manjkajoče vrednosti
                   lapply(. %>% { ifelse(is.null(.), NA, .) }) %>% # - te predstavimo z NA
                   as.data.frame()) %>%
                    bind_rows() %>% 
                    mutate(Rojstvo=as.Date.POSIXct(Rojstvo/1000, # pretvorimo datume
                          origin="1970-01-01")) %>%
                    .[1:200,] # prvih 200

# Tabela za vejo BIO
tabelaBio <- Tabela20 %>% select(ImePriimek, Rojstvo, Spol, Premozenje)

# Tabela za vejo GEO
tabelaGeo <- Tabela20 %>% select(ImePriimek, Drzava, Premozenje)

# Tabela za vejo PANG
tabelaPang <- Tabela20 %>% select(ImePriimek, Kategorija, Premozenje)                  

# Tabela za vejo TOP5
tabelaTOP <- Tabela20 %>% select(ImePriimek, Premozenje, Vir)


stolpci_json <- c("personName", "finalWorth", "source")
stolpci_new <- c("ImePriimek", "Premozenje", "Vir")

# 2015
Tabela15 <- lapply(data15$personList$personsLists,
                   . %>% .[stolpci_json] %>% setNames(stolpci_new) %>% # poskrbimo za manjkajoče vrednosti
                     lapply(. %>% { ifelse(is.null(.), NA, .) }) %>% # - te predstavimo z NA
                     as.data.frame()) %>% 
                    bind_rows() %>%
                    .[1:200,]

# 2016
Tabela16 <- lapply(data16$personList$personsLists,
                   . %>% .[stolpci_json] %>% setNames(stolpci_new) %>% # poskrbimo za manjkajoče vrednosti
                     lapply(. %>% { ifelse(is.null(.), NA, .) }) %>% # - te predstavimo z NA
                     as.data.frame()) %>% 
                    bind_rows() %>%
                    .[1:200,]

# 2017
Tabela17 <- lapply(data17$personList$personsLists,
                   . %>% .[stolpci_json] %>% setNames(stolpci_new) %>% # poskrbimo za manjkajoče vrednosti
                     lapply(. %>% { ifelse(is.null(.), NA, .) }) %>% # - te predstavimo z NA
                     as.data.frame()) %>% 
                    bind_rows() %>%
                    .[1:200,]

# 2018
Tabela18 <- lapply(data18$personList$personsLists,
                   . %>% .[stolpci_json] %>% setNames(stolpci_new) %>% # poskrbimo za manjkajoče vrednosti
                     lapply(. %>% { ifelse(is.null(.), NA, .) }) %>% # - te predstavimo z NA
                     as.data.frame()) %>%
                    bind_rows() %>%
                    .[1:200,]

# 2019
Tabela19 <- lapply(data19$personList$personsLists,
                   . %>% .[stolpci_json] %>% setNames(stolpci_new) %>% # poskrbimo za manjkajoče vrednosti
                     lapply(. %>% { ifelse(is.null(.), NA, .) }) %>% # - te predstavimo z NA
                     as.data.frame()) %>% 
                    bind_rows() %>%
                    .[1:200,]


# Shanjevanje v CSV datoteko

tabelaBio %>% write.csv2("podatki/TabelaBIO.csv", fileEncoding = "utf8")
tabelaGeo %>% write.csv2("podatki/TabelaGEO.csv", fileEncoding = "utf8")
tabelaPang %>% write.csv2("podatki/TabelaPANG.csv", fileEncoding = "utf8")
Tabela15 %>% write.csv2("podatki/Tabela_2015.csv", fileEncoding = "utf8")
Tabela16 %>% write.csv2("podatki/Tabela_2016.csv", fileEncoding = "utf8")
Tabela17 %>% write.csv2("podatki/Tabela_2017.csv", fileEncoding = "utf8")
Tabela18 %>% write.csv2("podatki/Tabela_2018.csv", fileEncoding = "utf8")
Tabela19 %>% write.csv2("podatki/Tabela_2019.csv", fileEncoding = "utf8")
tabelaTOP %>% write.csv2("podatki/Tabela_TOP_2020.csv", fileEncoding = "utf8")


