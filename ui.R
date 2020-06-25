library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Diamonds Price Predictor"),
    
    # Sidebar with options selectors
    sidebarLayout(
        sidebarPanel(
            helpText("This application predicts the price of a diamond based on different properties."),
            h3(helpText("Select:")),
            numericInput("carat", label = h4("Carats"), step = 0.1, value = 0.5),
            selectInput("cut", label = h4("Cut"),
                        choices = list("NA" = "*", "Fair" , "Good","Very Good", "Premium",
                                       "Ideal")),
            selectInput("col", label = h4("Colour"),
                        choices = list("NA" = "*", "D", "E","F", "G","H", "I" ,"J" )),
            selectInput("clar", label = h4("Clarity"),
                        choices = list("NA" = "*", "I1",  "SI2","SI1",  "VS2",  "VS1",
                                       "VVS2" , "VVS1", "IF" ))
        ),
        
        # Show a plot with diamonds and regression line
        mainPanel(
            plotOutput("Plot1"),
            h4("Predicted value of this diamond is:"),
            h3(textOutput("result"))
        )
    )
))