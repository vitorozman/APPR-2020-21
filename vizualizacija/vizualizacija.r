# Vizualizacija

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

Tabela20 <- read_csv2("podatki/Tabela20.csv", locale=locale(encoding="Windows-1250")) %>%
  select(-X1) %>%
  mutate(Starost =  datum_v_starost(Rojstvo, Sys.Date()))


# BIO
# delez moskih in zensk ####################################################

tabelaBIO <- Tabela20 %>% select(ImePriimek, Spol, Premozenje, Vir, Starost) 

delez <- tabelaBIO %>% count(Spol)


df <- delez %>% mutate(Percent=n/sum(n))
df[is.na(df)] <- "Family" #nastavil NA na vrednost

blank_theme <- theme_minimal()+
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.border = element_blank(),
    panel.grid=element_blank(),
    axis.ticks = element_blank()
  )

pie_spol <- ggplot(df, aes(x="", y=n, fill=Spol)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y", start=0) +
  scale_fill_manual(values=c("#E69F00","#999999", "#56B4E9" )) + 
  blank_theme +
  theme(axis.text.x=element_blank()) +
  geom_text(data = df %>% filter(n >= 10), aes(y = n/2 + c(0, cumsum(n)[-length(n)]), 
                label = percent(Percent)), size=5)+ 
  labs(title="Delež moških in žensk")


# izris povprecnega premozenja za dolocneo starost #############################
povprecje <- tabelaBIO %>% group_by(Starost) %>%
  summarise(PovprecnoPremozenje = median(Premozenje, na.rm = FALSE))

ggBio_leta <- ggplot(data=povprecje, aes(x=Starost, y=PovprecnoPremozenje)) + 
  geom_bar(stat = "identity", color="red") +
  labs(title="Povprečno premoženje za določeno strost") + 
  ylab("Mio €") +
  scale_x_continuous("Starost (leta)", breaks = seq(32, 100, 4), limits = c(32,100)) +
  geom_text(data=povprecje %>% slice_max(PovprecnoPremozenje, n=1),
            aes(label=PovprecnoPremozenje), nudge_y=1000)


# tabela odstopanj ############################################################
M_max_premozenje <- tabelaBIO[tabelaBIO$Spol == "M",] %>% slice_max(Premozenje)
M_max_starost <- tabelaBIO[tabelaBIO$Spol == "M",] %>% slice_max(Starost)
M_min_starost <- tabelaBIO[tabelaBIO$Spol == "M",] %>% slice_min(Starost)
M_mean <- tabelaBIO[tabelaBIO$Spol == "M",] %>% summarise(PvprecnaStarost = round(mean(Starost, na.rm = TRUE)))

F_max_premozenje <- tabelaBIO[tabelaBIO$Spol == "F",] %>% slice_max(Premozenje)
F_max_starost <- tabelaBIO[tabelaBIO$Spol == "F",] %>% slice_max(Starost)
F_min_starost <- tabelaBIO[tabelaBIO$Spol == "F",] %>% slice_min(Starost)
F_mean <- tabelaBIO[tabelaBIO$Spol == "F",] %>% summarise(PvprecnaStarost = round(mean(Starost, na.rm = TRUE)))

#moski
Odstopanja_M <- rbind(M_max_premozenje,
                           M_max_starost,
                           M_min_starost) %>% mutate(M_mean)

#zenske
Odstopanja_F <- rbind(F_max_premozenje,
                      F_max_starost,
                      F_min_starost) %>% mutate(F_mean)

najnaj <- c("Najbogatejši",
            "Najstarejši",
            "Najmlajši",
            "Najbogatejša",
            "Najstarejša",
            "Najmlajša")
Odstopanja <- rbind(Odstopanja_M, Odstopanja_F) %>% mutate(NajNaj=najnaj) 
Odstopanja
Odstopanja <- Odstopanja[c(7, 1, 2, 3, 4, 5, 6)]

tabelaOdstopanj <- kable(Odstopanja, caption = "Tabela odstopanj")


################################################################################
################################################################################


# PANG
tabelaPANG <- Tabela20 %>% select(ImePriimek, Kategorija, Premozenje)

panoge <- tabelaPANG %>% group_by(Kategorija) %>% summarise(Povrecno_premozenje=mean(Premozenje),
                                                            st_oseb=n_distinct(ImePriimek)) 

# Povpreno premozenje na kategorijo ############################################
ggPang <- ggplot(data=panoge, aes(x=Kategorija, y=Povrecno_premozenje, fill=Kategorija)) + 
  geom_bar(stat = "identity", position=position_dodge(), colour="black") +
  scale_y_continuous(breaks = seq(0, 26000, by=2000), limits = c(0, 26000))+
  theme(axis.text.x=element_blank(),
        axis.ticks = element_blank())+
  labs(title="Povprečno premoženje glede na panogo v mio €")+
  xlab("Panoge") + 
  ylab("Mio €") +
  guides(fill=guide_legend("Panoge"))


# St oseb na panogo ############################################################
ggPangPie <- ggplot(data=panoge, aes(x="", y=st_oseb, fill=reorder(Kategorija, st_oseb))) + 
  geom_bar(width = 1, stat = "identity",  colour="black") +
  coord_polar(theta="y") +
  scale_y_continuous(breaks = seq(0, 200, by=40)) +
  labs(title="Število oseb v posamezni panogi") +
  xlab("") + 
  ylab("") +
  guides(fill=guide_legend("Panoge")) +
  blank_theme



###############################################################################
###############################################################################


#TOP
TabelaTOP <- read_csv2("podatki/Tabela.csv", locale=locale(encoding="Windows-1250")) %>%
  select(-X1)

topImena20 <- filter(TabelaTOP, Leto == 2020) %>% .[1:8,] %>% .$ImePriimek

top <- filter(TabelaTOP, ImePriimek %in% topImena20) 

# Prikaz premozenja v obdobju 2015-2020 #######################################
ggTop <- ggplot(data=top, aes(x=Leto, y=Premozenje, color = ImePriimek)) +
  geom_line() + 
  geom_point() +
  labs(title="Spreminjanje premoženja najbogatejših ljudi na svetu")+
  xlab("Leto") + 
  ylab("Mio €") +
  guides(color=guide_legend("TOP 8"))



# Najboljši napredek v obobju 2015-2020 ########################################
max_napredovanje <- top %>% group_by(ImePriimek) %>% mutate(Napredovanje=(Premozenje - lag(Premozenje))) %>%
  group_by(ImePriimek) %>% slice_max(Napredovanje)

napredek <- ggplot(data=max_napredovanje, aes(x=ImePriimek, y=Napredovanje, fill = ImePriimek)) +
  geom_bar(width = 1, stat = "identity", position=position_dodge(), color="black") + 
  geom_text(aes(label=Leto), vjust=3, color="white", size=3.5) +
  geom_text(aes(label=Napredovanje), vjust=1.5, color="white", size=3.5) +
  theme(axis.text.x=element_blank()) +
  labs(title="Najboljiši napredek v obdobju 2015-2020")+
  xlab("Osebe") + 
  ylab("Mio €") +
  guides(fill=guide_legend("TOP 8"))