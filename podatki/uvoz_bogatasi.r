library(httr)
library(dplyr)
library(jsonlite)
library(rjson)

#uvoz json datoteke
data20 <- fromJSON(file="podatki/billionaires20.json")
data19 <- fromJSON(file="podatki/billionaires19.json")

#poskusni model izdelave tabele
stolpci <- c("firstName", "lastName", "birthDate", "gender", "status", "title",
             "country", "state", "city", "finalWorth", "source", "category")

tabela20 <- lapply(data20$personList$personsLists,
                 . %>% .[stolpci] %>% 
                   setNames(stolpci) %>% # poskrbimo za manjkajoče vrednosti
                   lapply(. %>% { ifelse(is.null(.), NA, .) }) %>% # - te predstavimo z NA
                   as.data.frame()) %>%
                    bind_rows() %>%
                    mutate(birthDate=as.Date.POSIXct(birthDate/1000, # pretvorimo datume
                           origin="1970-01-01"))


tabela19 <- lapply(data19$personList$personsLists,
                 . %>% .[stolpci] %>% setNames(stolpci) %>% 
                   lapply(. %>% { ifelse(is.null(.), NA, .) }) %>%
                   as.data.frame()) %>%
                    bind_rows() %>% 
                    mutate(birthDate=as.Date.POSIXct(birthDate/1000,
                          origin="1970-01-01"))




