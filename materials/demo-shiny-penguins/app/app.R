library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)

# Load the data
penguins <- palmerpenguins::penguins

# Dashboard body
body <- shinydashboard::dashboardBody(
    fluidRow(
        column(
            6,
            tags$h4("Meeting the penguins!"),
            tags$p("Data were collected and made available by Dr. Kristen Gorman and the Palmer Station, Antarctica LTER, a member of the Long Term Ecological Research Network."),
            tags$p("The penguins live on three different islands:"),
            selectInput(
                "islandInput",
                label = "Island",
                choices = c("All", levels(penguins$island))
            )
        ),
        column(6, tags$img(src = "https://allisonhorst.github.io/palmerpenguins/reference/figures/lter_penguins.png", width = 250))
    ),
    fluidRow(
        box(plotOutput("figBillVsFlipper")),
        box(plotOutput("figFlipperDist"))
    )
)

ui <- shinydashboard::dashboardPage(
    dashboardHeader(
        title = "Palmer's Penguins"
    ),
    dashboardSidebar(disable = TRUE),
    body,
    skin = "yellow"
)

# Server functions
server <- function(input, output) {
    
    selected_island <- reactive({input$islandInput})
    
    filtered_penguins <- reactive({
        if (selected_island() == "All") {
            penguins
        } else {
            penguins %>% 
                filter(island == selected_island())
        }
    })
    
    fig_bill_vs_flipper <- reactive({
        filtered_penguins() %>% 
            ggplot(aes(x = flipper_length_mm, y = bill_length_mm, color = species, shape = species)) +
            geom_point() +
            labs(
                title = "Bill length vs. flipper length by species",
                x = "Flipper length (mm)",
                y = "Bill length (mm)"
            )
        
    })
    
    fig_flipper_dist <- reactive({
        filtered_penguins() %>% 
            ggplot(aes(x = flipper_length_mm, fill = species)) +
            geom_histogram(alpha = 0.7, position = "identity", bins = 30) +
            labs(
                title = "Distribution of Flipper Length",
                x = "Flipper length (mm)",
                y = "Count"
            )
    })
        
    output$figBillVsFlipper <- renderPlot({fig_bill_vs_flipper()})
    output$figFlipperDist <- renderPlot({fig_flipper_dist()}) 
}

# Run the application 
shinyApp(ui = ui, server = server)