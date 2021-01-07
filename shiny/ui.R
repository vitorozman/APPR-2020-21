# shiny UI


shinyUI(
  fluidPage(
    navbarPage("200 najbogatejši ljudje na svetu",
            tabPanel("Panoge",
                     titlePanel(title = h2("Prikaz premoženj", align="center")),
                        sidebarLayout(
                        sidebarPanel(
                          selectInput(inputId = "Spol",
                                      label = "Spol",
                                      choices = c( "-", "M", "F")),
                          selectInput(inputId = "ext",
                                      label = "Ekstrem premoženja",
                                      choices = c("Max", "Min", "Mean"),),
                          sliderInput(inputId = "age",
                                      label = "Dolžina intervala starosti",
                                      min = 20, 
                                      max = 100,
                                      value = c(20, 100))
                          #checkboxGroupInput("variable", "Variables to show:",
                          #                   c("C1" = "c1",
                          #                     "C2" = "c2",
                          #                     "C2" = "c2")),
                          #checkboxInput("somevalue", "Some value", FALSE)
                        ), #konec 1. sidebar Panel
                        
                        mainPanel(
                          plotOutput(outputId = "tocke"))
                        
                      )
                    ), #konec 1. tab Panel
            tabPanel("Sprememba premoženja",
                     titlePanel(title = h2("Graf rasti premoženja", align="center")),
                     sidebarLayout(
                       sidebarPanel(
                         selectInput(inputId = "bogatas",
                                     label = "Izbera osebe",
                                     choices = c(filter(TabelaTOP, Leto == 2020) %>% .[1:40,] %>% .$ImePriimek))
                       ), #konec 2. sidebar Panel
                       mainPanel(
                         plotOutput(outputId = "graf"))
                       
                     )
                    ) #konec 2. tab Panel
    ), #konec navbarPage
    theme = shinytheme("slate")
  ) #konec fluid page
) #konec shinyUI

