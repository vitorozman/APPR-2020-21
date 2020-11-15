library(httr)
library(dplyr)


#pridobitev podatkov za leto 2020
link <- "https://www.forbes.com/forbesapi/person/billionaires/2020/position/true.json"
glava <- add_headers("Cookie"="notice_gdpr_prefs=0,1,2:1a8b5228dd7ff0717196863a5d28ce6c")
data <- GET(link, glava) %>% content()

#pridobitev podatkov za leto 2019
link19 <-"https://www.forbes.com/forbesapi/person/billionaires/2019/position/true.json"
glava19 <- add_headers("Cookie"="notice_gdpr_prefs=0,1,2:1a8b5228dd7ff0717196863a5d28ce6c")
data19 <- GET(link19, glava19) %>% content()


# Izbira polj

stolpci <- c("firstName", "lastName", "birthDate", "gender", "status", "title",
             "country", "state", "city", "finalWorth", "source", "category")

tabela <- lapply(data$personList$personsLists,
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
