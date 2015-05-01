library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Interstellar journey population simulation"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
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
                  min = 1,
                  max = 2500,
                  value = 250,
                  step=10),
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
                  value = 0.2,
                  step=0.01),
      p(actionButton('rerun', "Re-run simulation", icon("random")))
    ),
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
))
