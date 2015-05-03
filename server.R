library(shiny)
source('functions.R')

shinyServer(
    function(input, output) {
        k=0
        output$distPlot <- renderPlot({
            # Just a hack to make the re-run simulation button work
            k = k + input$rerun
            plot.simulation(
                 trials=input$trials,
                 max.pop=input$max.pop,
                 journey.time=input$journey.time,
                 fertility=input$fertility,
                 min.rep=input$fertile.range[1],
                 max.rep=input$fertile.range[2],
                 max.age=input$max.age
            )
        })
})
