library(httr)
library(dplyr)
library(jsonlite)


#pridobitev podatkov za leto 2020

link <- "https://www.forbes.com/forbesapi/person/billionaires/2020/position/true.json"
glava <- add_headers("Cookie"="notice_gdpr_prefs=0,1,2:1a8b5228dd7ff0717196863a5d28ce6c")
data <- GET(link, glava) %>% content()

# pretorba v json in shranitev v json datoteko
data20json <- toJSON(data)
write(data20json, "podatki/billionaires20.json")


#pridobitev podatkov za leto 2019

link19 <-"https://www.forbes.com/forbesapi/person/billionaires/2019/position/true.json"
glava19 <- add_headers("Cookie"="notice_gdpr_prefs=0,1,2:1a8b5228dd7ff0717196863a5d28ce6c")
data19 <- GET(link19, glava19) %>% content()


data19json <- toJSON(data19)
write(data19json, "podatki/billionaires19.json")