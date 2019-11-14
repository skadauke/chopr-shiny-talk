#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(rocqi)

load("clabsi.rda")

# Define UI for application that draws a histogram
ui <- fluidPage(
    theme = "https://github.research.chop.edu/pages/CQI/chop-bootstrap/bootstrap-3/bootstrap.min.css",
    # Application title
    titlePanel("CLABSI Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # draw the histogram with the specified number of bins
        ggplot(clabsi, aes(x = LINE_DAYS)) + 
            geom_histogram(bins = input$bins,
                           fill = chop_colors("pink")) + 
            theme_chop()
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
