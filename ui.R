library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Interstellar Baby Fest"),

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
      p(actionButton('rerun', "Re-run simulation", icon("random")))
    ),
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
))
