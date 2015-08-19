library(shiny)
library(shinythemes)

shinyUI(fluidPage(theme = shinytheme('spacelab'),

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
                    min = 50,
                    max = 2500,
                    value = 500,
                    step=50)
        ),
        column(6,
          sliderInput("fertile.range",
                      "Fertile Range:",
                      min = 1,
                      max = 80,
                      value = c(20,40),
                      step=1),
          sliderInput("fertility",
                      "Fertility:",
                      min = 0,
                      max = 1,
                      value = 0.2,
                      step=0.01),
          sliderInput("max.age",
                      "Maximum Age:",
                      min = 40,
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
