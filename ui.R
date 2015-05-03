library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Interstellar journey population simulation"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      fluidRow(column(6,
        sliderInput("trials",
                    "Number of trials:",
                    min = 1,
                    max = 10,
                    value = 3),
        sliderInput("max.pop",
                    "Maximum Population:",
                    min = 2,
                    max = 100,
                    value = 30),
        sliderInput("journey.time",
                    "Journey Time:",
                    min = 100,
                    max = 10000,
                    value = 500,
                    step=50)
        ),
        column(6,
          sliderInput("fertile.range",
                      "Fertile Range:",
                      min = 0,
                      max = 80,
                      value = c(20,40),
                      step=1),
          sliderInput("fertility",
                      "Fertility:",
                      min = 0,
                      max = 1,
                      value = 0.1,
                      step=0.01),
          sliderInput("max.age",
                      "Maximum Age:",
                      min = 20,
                      max = 100,
                      value = 80,
                      step=1)
      )),
      p(actionButton('rerun', "Re-run simulation", icon("random")))
    ),
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
))
