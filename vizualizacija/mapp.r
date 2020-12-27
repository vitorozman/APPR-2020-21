library(tmap)
library(dplyr)
library(readr)
library(tidyr)



GEO <- read_csv2("podatki/Tabela20.csv", locale=locale(encoding="Windows-1250")) %>% 
  select(ImePriimek, Drzava, Premozenje)



geo_vrednosti <- GEO %>% group_by(Drzava) %>% 
  summarise(vsota = sum(Premozenje), stevilo = n_distinct(ImePriimek)) 

naj_bogatas <- GEO %>% group_by(Drzava) %>% slice_max(Premozenje, n=1)

geo_vrednosti <- left_join(geo_vrednosti, naj_bogatas, by="Drzava") 



#osnutek za zemljevid
data("World")
tmap_mode("view")
svet <- tm_shape(merge(World, geo_vrednosti, by.x = "name", by.y = "Drzava" )) + tm_polygons("vsota")
svet

