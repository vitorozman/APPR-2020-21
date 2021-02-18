# shiny SERVER

shinyServer(function(input, output) {
  output$tocke <- renderPlot({
    if(input$Spol %in% c("M", "F")){
      podatki <- Tabela20 %>% filter(Spol == input$Spol)
    }
    else {
      podatki <- Tabela20
    }
    podatki <- podatki %>% filter(between(Starost, input$age[1], input$age[2]))
    if (input$ext == "Max"){
      podatki <- podatki %>% group_by(Kategorija) %>% summarise(Odmik = max(Premozenje))
    }
    else if (input$ext == "Min"){
      podatki <- podatki %>% group_by(Kategorija) %>% summarise(Odmik = min(Premozenje))
    }
    else if (input$ext == "Mean"){
      podatki <- podatki %>% group_by(Kategorija) %>% summarise(Odmik = mean(Premozenje))
    }
    print(ggplot(podatki) +
            aes(x = Kategorija, y = Odmik, col = Kategorija)+
            geom_point(size = 3, na.rm = TRUE) +
            xlab("Starost") +
            ylab("Premozenje (mio €)") +
            labs(title="Premoženje oseb ob določeni starosti") +
            scale_y_continuous(breaks = seq(7000, 150000, by=15000), limits = c(0, 150000)) +
            theme(axis.text.x = element_blank(),
                  axis.ticks = element_line(color = "red"), 
                  axis.ticks.length = unit(2, "mm"),
                  axis.line = element_line(colour = "black", 
                                           size = 1, linetype = "solid"))+
            xlab("Panoge") + 
            ylab("Mio €") +
            guides(col=guide_legend("Panoge"))
            
          )
  })
  output$graf <- renderPlot({
    podatki_oseba <- filter(TabelaTOP, ImePriimek %in% input$bogatas)
    print(ggplot(podatki_oseba) +
            aes(x=Leto, y=Premozenje) +
            geom_line(col="red3", size=1) + 
            geom_point() +
            scale_y_continuous(breaks = seq(5000, 155000, by=25000),limits = c(5000, 155000)) +
            scale_x_continuous(breaks = seq(2015, 2020, by=1),limits = c(2015, 2020)) +
            ylab("Mio €") +
            theme(axis.ticks = element_line(color = "red3"),
                  axis.line = element_line(colour = "black", 
                                           size = 1, linetype = "solid"),
                  axis.ticks.length = unit(2, "mm"),
                  legend.position = "none")
          )
    # Prileganje
    if (input$lin){
      podatki <- podatki_oseba %>%
        ungroup %>% 
        select(-Vir, -ImePriimek)
      prileganje <- glm(data=podatki_oseba, Premozenje ~ Leto)
      leta <- data.frame(Leto=seq(2015, 2021, 1))
      napoved <- leta %>% mutate(Premozenje=predict(prileganje, leta))
      print(ggplot(data=podatki %>% rbind(napoved %>% filter(Leto == 2021))) +
              aes(x=Leto, y=Premozenje) +
              geom_line(col="red3", size=1, na.rm=TRUE) +
              geom_point(na.rm = TRUE) +
              geom_point(data = napoved %>% filter(Leto==2021), aes(x=Leto, y=Premozenje, color="red", size=3), na.rm = TRUE) +
              geom_text(aes(label=ifelse(Leto == 2021, round(Premozenje, -3), "")), nudge_y=10000) + # napoved rasti in premoženja
              geom_smooth(data=podatki, method="glm", formula=y ~ x, fullrange=TRUE) +
              scale_y_continuous(breaks = seq(5000, 155000, by=25000),limits = c(5000, 175000)) +
              scale_x_continuous(breaks = seq(2015, 2021, by=1),limits = c(2015, 2021)) +
              labs(title=paste("Prileganje in napoved premoženja za leto 2021", input$bogatas, sep=" - ")) +
              ylab("Premoženje v mio €") +
              theme(axis.ticks = element_line(color = "red3"),
                    axis.line = element_line(colour = "black", 
                                             size = 1, linetype = "solid"),
                    axis.ticks.length = unit(2, "mm"),
                    legend.position = "none")
            )

    }
    
  })
  
})


