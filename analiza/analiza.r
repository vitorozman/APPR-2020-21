# 4. faza: Analiza podatkov

# Napoved rasti premozenja najbogatejse osebe na svetu

#top_1 <- top %>% filter(ImePriimek == "Jeff Bezos") %>% select(-Vir)
#
#prileganje <- loess(formula = (Rast ~ Leto), data=top_1)
#leta <- data.frame(Leto=seq(2016, 2021, 1))
#napoved <- mutate(leta, Rast=predict(prileganje, leta))
#
#
#top_1 <- top_1 %>% rbind(napoved %>% filter(Leto==2021))
#
#top_1$ImePriimek[is.na(top_1$ImePriimek)] <- top_1$ImePriimek[1]
#top_1$Premozenje[is.na(top_1$Premozenje)] <- round((top_1$Premozenje[length(top_1$Premozenje)-1]) * (1 + top_1$Rast[length(top_1$Rast)]/100))
#
#ggTop_napoved <- ggplot(data=top_1, aes(x=Leto, y=Rast)) +
#  geom_point(na.rm = TRUE) +
#  geom_point(data = top_1 %>% filter(Leto==2021), aes(x=Leto, y=Rast, color="red", size=2), na.rm = TRUE) +
#  geom_text(data=top_1 %>% slice_tail(),
#            aes(label=Premozenje), nudge_y=5) + # napoved rasti in premoženja
#  labs(y="Rast (%)") +
#  geom_smooth(method="loess", formula =  y ~ x) +
#  ylab("Rast premoženja v %") +
#  labs(title = "Napoved rasti premoženja za leto 2021 - Jeff Bezos") +
#  theme(axis.ticks = element_line(color = "red"), 
#        axis.ticks.length = unit(2, "mm"),
#        legend.position = "none") 
#ggTop_napoved
#



#top_1 <- top %>% filter(ImePriimek == "Jeff Bezos") %>%
#  ungroup %>% select(-Vir, -ImePriimek)
#
#prileganje <- glm(data=top_1, Rast ~ Leto) # morda raje kvadratni model - glej zgoraj
#leta <- data.frame(Leto=seq(2016, 2021, 1))
#napoved <- leta %>% mutate(Rast=predict(prileganje, leta),
#                           Premozenje=c(NA, top_1$Premozenje) * (1+Rast/100))
#
#ggTop_napoved <- ggplot(data=napoved %>% filter(Leto == 2021) %>% rbind(top_1),
#                        aes(x=Leto, y=Rast)) +
#  geom_point(aes(color=(Leto == 2021)), na.rm=TRUE) +
#  geom_text(aes(label=ifelse(Leto == 2021, round(Premozenje, -3), "")), nudge_y=5) + # napoved rasti in premoženja
#  labs(y="Rast (%)") +
#  geom_smooth(data=top_1, method="glm", formula=y ~ x, fullrange=TRUE) +
#  ylab("Rast premoženja v %") +
#  labs(title="Napoved rasti premoženja za leto 2021 - Jeff Bezos") +
#  theme(axis.ticks=element_line(color="red"), 
#        axis.ticks.length=unit(2, "mm"),
#        legend.position="none")
#ggTop_napoved
#

napoved_rast <- function(ime_priimek) {
  top_1 <- top %>% filter(ImePriimek == ime_priimek) %>%
    ungroup %>% select(-Vir, -ImePriimek)
  
  prileganje <- glm(data=top_1, Rast ~ Leto)
  leta <- data.frame(Leto=seq(2016, 2021, 1))
  napoved <- leta %>% mutate(Rast=predict(prileganje, leta),
                             Premozenje=c(NA, top_1$Premozenje) * (1+Rast/100))
  
  ggTop_napoved <- ggplot(data=napoved %>% filter(Leto == 2021) %>% rbind(top_1),
                          aes(x=Leto, y=Rast)) +
    geom_line(size=0.5) +
    geom_point(na.rm = TRUE) +
    geom_point(data = napoved %>% filter(Leto==2021), aes(x=Leto, y=Rast, color="red", size=2), na.rm = TRUE) +
    #geom_point(aes(color=(Leto == 2021)), na.rm=TRUE) +
    geom_text(aes(label=ifelse(Leto == 2021, round(Premozenje, -3), "")), nudge_y=10) + # napoved rasti in premoženja
    labs(y="Rast (%)") +
    geom_smooth(data=top_1, method="glm", formula=y ~ x, fullrange=TRUE) +
    ylab("Rast premoženja v %") +
    labs(title=paste("Napoved rasti premoženja za leto 2021", ime_priimek, sep=" - ")) +
    theme(axis.ticks=element_line(color="red"), 
          axis.ticks.length=unit(2, "mm"),
          legend.position="none")
  print(ggTop_napoved)
}


