library(tmap)
library(dplyr)
library(readr)
library(tidyr)



GEO <- read_csv2("podatki/Tabela20.csv", locale=locale(encoding="Windows-1250")) %>% 
  select(ImePriimek, Drzava, Premozenje, -X1)


geo_vrednosti <- GEO %>% group_by(Drzava) %>% 
  summarise(Vsota_premozenja = sum(Premozenje), Stevilo_oseb = n_distinct(ImePriimek)) 

naj_bogatas <- GEO %>% group_by(Drzava) %>% slice_max(Premozenje, n=1)

geo_vrednosti <- left_join(geo_vrednosti, naj_bogatas, by="Drzava") 

#osnutek za zemljevid
data("World")
tmap_mode("view")
svet <- tm_shape(merge(World, geo_vrednosti %>% filter(Drzava != "United States"),
                       by.x = "name", by.y = "Drzava" )) + 
  tm_polygons("Vsota_premozenja") +
  tm_text("ImePriimek", size = 0.8) +
  tm_view(text.size.variable = TRUE) +
  tm_shape(merge(World, geo_vrednosti %>% filter(Drzava == "United States"),
                 by.x = "name", by.y = "Drzava" )) + tm_polygons(col="red3") +
  tm_text("ImePriimek", size = 0.8) 
svet