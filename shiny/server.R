# shiny SERVER



shinyServer(function(input, output) {
  output$tocke <- renderPlot({
    if(input$Spol %in% c("M", "F")){
      podatki <- Tabela20 %>% filter(Spol == input$Spol)
    }
    else {
      podatki <- Tabela20
    }
    if (input$ext == "Max"){
      podatki <- podatki %>% group_by(Kategorija) %>% summarise(Odmik = max(Premozenje))
    }
    else if (input$ext == "Min"){
      podatki <- podatki %>% group_by(Kategorija) %>% summarise(Odmik = min(Premozenje))
    }
    else {
      podatki <- podatki %>% group_by(Kategorija) %>% summarise(Odmik = mean(Premozenje))
    }
    #podatki <- podatki %>% filter((input$age[1] <= podatki$Starost) & (podatki$Starost <= input$age[2]))
    print(ggplot(podatki) +
            aes(x = Kategorija, y = Odmik, col = Kategorija)+
            geom_point(size = 3, na.rm = TRUE) +
            xlab("Starost") +
            ylab("Premozenje (mio €)") +
            labs(title="Premoženje oseb ob določeni starosti") +
            scale_y_continuous(breaks = seq(7000, 150000, by=15000), limits = c(0, 150000)) +
            theme(axis.text.x = element_blank(),
                  axis.title = element_blank())+
            xlab("Panoge") + 
            ylab("mio €") +
            guides(col=guide_legend("Panoge"))
            
          )
  })
  output$graf <- renderPlot({
    podatki_oseba <- filter(TabelaTOP, ImePriimek %in% input$bogatas)
    print(ggplot(podatki_oseba) +
            aes(x=Leto, y=Premozenje) +
            geom_line(col="red3", size=1) + 
            geom_point() +
            scale_y_continuous(breaks = seq(5000, 150000, by=25000),limits = c(5000, 150000)) +
            theme(axis.ticks = element_line(color = "red3"),
                  axis.line = element_line(colour = "black", 
                                           size = 1, linetype = "solid"),
                  axis.ticks.length = unit(2, "mm"),
                  legend.position = "none")
          )
    
  })
  
})



#shinyServer(function(input, output) {
#  output$druzine <- DT::renderDataTable({
#    druzine %>% pivot_wider(names_from="velikost.druzine", values_from="stevilo.druzin") %>%
#      rename(`Občina`=obcina)
#  })
#  
#  output$pokrajine <- renderUI(
#    selectInput("pokrajina", label="Izberi pokrajino",
#                choices=c("Vse", levels(obcine$pokrajina)))
#  )
#  output$naselja <- renderPlot({
#    main <- "Pogostost števila naselij"
#    if (!is.null(input$pokrajina) && input$pokrajina %in% levels(obcine$pokrajina)) {
#      t <- obcine %>% filter(pokrajina == input$pokrajina)
#      main <- paste(main, "v regiji", input$pokrajina)
#    } else {
#      t <- obcine
#    }
#    ggplot(t, aes(x=naselja)) + geom_histogram() +
#      ggtitle(main) + xlab("Število naselij") + ylab("Število občin")
#  })
#})
