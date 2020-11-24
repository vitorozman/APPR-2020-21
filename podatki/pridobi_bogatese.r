#library(httr)
#library(dplyr)
#library(jsonlite)


##pridobitev podatkov za leto 2020
#
#link <- "https://www.forbes.com/forbesapi/person/billionaires/2020/position/true.json"
#glava <- add_headers("Cookie"="notice_gdpr_prefs=0,1,2:1a8b5228dd7ff0717196863a5d28ce6c")
#data <- GET(link, glava) %>% content()
#
## pretorba v json in shranitev v json datoteko
#data20json <- toJSON(data)
#write(data20json, "podatki/billionaires20.json")
#
#
##pridobitev podatkov za leto 2019
#
#link19 <-"https://www.forbes.com/forbesapi/person/billionaires/2019/position/true.json"
#glava19 <- add_headers("Cookie"="notice_gdpr_prefs=0,1,2:1a8b5228dd7ff0717196863a5d28ce6c")
#data19 <- GET(link19, glava19) %>% content()
#
#data19json <- toJSON(data19)
#write(data19json, "podatki/billionaires19.json")
#
##18
#link18 <-"https://www.forbes.com/forbesapi/person/billionaires/2018/position/true.json"
#glava18 <- add_headers("Cookie"="notice_gdpr_prefs=0,1,2:1a8b5228dd7ff0717196863a5d28ce6c")
#data18 <- GET(link18, glava18) %>% content()
#
#data18json <- toJSON(data18)
#write(data18json, "podatki/billionaires18.json")
#
#
##17
#link17 <-"https://www.forbes.com/forbesapi/person/billionaires/2017/position/true.json"
#glava17 <- add_headers("Cookie"="notice_gdpr_prefs=0,1,2:1a8b5228dd7ff0717196863a5d28ce6c")
#data17 <- GET(link17, glava17) %>% content()
#
#data17json <- toJSON(data17)
#write(data17json, "podatki/billionaires17.json")
#
##16
#link16 <-"https://www.forbes.com/forbesapi/person/billionaires/2016/position/true.json"
#glava16 <- add_headers("Cookie"="notice_gdpr_prefs=0,1,2:1a8b5228dd7ff0717196863a5d28ce6c")
#data16 <- GET(link16, glava16) %>% content()
#
#data16json <- toJSON(data16)
#write(data16json, "podatki/billionaires16.json")
#
#
##15
#link15 <-"https://www.forbes.com/forbesapi/person/billionaires/2016/position/true.json"
#glava15 <- add_headers("Cookie"="notice_gdpr_prefs=0,1,2:1a8b5228dd7ff0717196863a5d28ce6c")
#data15 <- GET(link15, glava15) %>% content()
#
#data15json <- toJSON(data15)
#write(data15json, "podatki/billionaires15.json")
