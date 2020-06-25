library(shiny)
library(ggplot2)
library(dplyr)
library(rsconnect)

# Selecting the columns to be used in the analysis
diam <- diamonds[,c(1:4,7)]
# Define server logic required to draw a plot
shinyServer(function(input, output) {
    output$Plot1 <- renderPlot({
        # Selecting diamonds using the input
        diam <- filter(diamonds, grepl(input$cut, cut), grepl(input$col, color), grepl(input$clar, clarity))
        # build linear regression model
        fit <- lm( price~carat, diam)
        # predicts the price
        pred <- predict(fit, newdata = data.frame(carat = input$carat,
                                                  cut = input$cut,
                                                  color = input$col,
                                                  clarity = input$clar))
        # Draw the plot using ggplot2
        plot <- ggplot(data=diam, aes(x=carat, y = price))+
            geom_point(aes(color = cut), alpha = 0.4)+
            geom_smooth(method = "lm")+xlab("Carats")+ylab("Price")
        plot
    })
    output$result <- renderText({
        # Renders the text for the prediction below the graph
        diam <- filter(diamonds, grepl(input$cut, cut), grepl(input$col, color), grepl(input$clar, clarity))
        fit <- lm( price~carat, diam)
        pred <- predict(fit, newdata = data.frame(carat = input$carat,
                                                  cut = input$cut,
                                                  color = input$col,
                                                  clarity = input$clar))
        res <- paste(round(pred, digits = 1.5),"$" )
        res
    })
    
})