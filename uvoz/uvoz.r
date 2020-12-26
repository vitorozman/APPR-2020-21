library(httr)
library(dplyr)
library(jsonlite)
library(rjson)

#uvoz json datoteke
data20 <- fromJSON(file="podatki/billionaires20.json")

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


stolpci_json <- c("personName", "finalWorth", "source")
stolpci_new <- c("ImePriimek", "Premozenje", "Vir")



leta <- 15:19 # leta, za katere obdelujemo podatke

Tabela <- lapply(leta, function(leto)
  sprintf("podatki/billionaires%d.json", leto) %>% # sestavimo ime datoteke
    fromJSON(file=.) %>%
    .$personList %>% .$personsLists %>%
    lapply(. %>% .[stolpci_json] %>% setNames(stolpci_new) %>%
             lapply(. %>% { ifelse(is.null(.), NA, .) }) %>%
             as.data.frame()) %>% bind_rows() %>% .[1:200, ] %>%
    mutate(Leto=2000+leto)) %>% bind_rows() %>%
  rbind(Tabela20 %>% transmute(ImePriimek, Premozenje, Vir, Leto=2020)) # dodani še ustrezni stolpci za 2020

# zapis tabel v csv datoteko
Tabela20 %>% write.csv2("podatki/Tabela20.csv", fileEncoding = "utf8")
Tabela %>% write.csv2("podatki/Tabela.csv", fileEncoding = "utf8")

