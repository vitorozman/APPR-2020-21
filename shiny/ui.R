# shiny UI


shinyUI(
  fluidPage(
    navbarPage("200 najbogatejši ljudje na svetu",
            tabPanel("Panoge",
                     titlePanel(title = h2("Prikaz premoženj glede na panogo", align="center")),
                        sidebarLayout(
                        sidebarPanel(
                          h3("Filtriranje"),
                          p("Točka = kolikšno je ekstrem premoženja za določeno panogo"),
                          selectInput(inputId = "Spol",
                                      label = "Spol",
                                      choices = c( "-", "M", "F")),
                          p(tags$i("[ - ] ne filtrira glede na spol")),
                          selectInput(inputId = "ext",
                                      label = "Ekstrem premoženja",
                                      choices = c("Max", "Min", "Mean"),),
                          p(tags$i("Izbrani ekstrem prikaže ekstrem premoženja za določemo panogo")),
                          sliderInput(inputId = "age",
                                      label = "Dolžina intervala starosti",
                                      min = 20, 
                                      max = 100,
                                      value = c(20, 100)),
                          p(tags$i("Omeji analizerane osebe s starostjo iz zgornjega intervala"))
                        ), #konec 1. sidebar Panel
                        mainPanel(
                          plotOutput(outputId = "tocke"))
                      )
                    ), #konec 1. tab Panel
            tabPanel("Sprememba premoženja",
                     titlePanel(title = h2("Graf premoženja", align="center")),
                     sidebarLayout(
                       sidebarPanel(
                         selectInput(inputId = "bogatas",
                                     label = "Izbera osebe",
                                     choices = c(filter(TabelaTOP, Leto == 2020) %>% .[1:50,] %>% .$ImePriimek)),
                         checkboxInput(inputId = "lin", "Napoved premoženja", FALSE),
                         p(tags$i("S splošnim linearnim modelom ocenimo prileganje točkam in napovemo prihodnje premoženje za leto 2021"))
                       ), #konec 2. sidebar Panel
                       mainPanel(
                         plotOutput(outputId = "graf"))
                     )
                    ) #konec 2. tab Panel
    ), #konec navbarPage
    theme = shinytheme("slate")
  ) #konec fluid page
) #konec shinyUI

