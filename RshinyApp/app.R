library(shiny)
library(ggplot2)
library(tidyverse)

# load data
data <- read_csv("CaseStudy2-data.csv")


# Define the user interface
ui <- fluidPage(
  titlePanel("Employee Data Visualizations"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("variable", "Choose a variable for boxplot:",
                  choices = c("MonthlyIncome", "Age", "TotalWorkingYears")),
      selectInput("category", "Choose a category:",
                  choices = c("Department", "MaritalStatus", "Attrition", "JobRole"))
    ),
    
    mainPanel("Boxplot", plotOutput("boxplot")),
  )
)


# Define the server logic
server <- function(input, output) {
  output$boxplot <- renderPlot({
    ggplot(data, aes_string(x = input$category, y = input$variable)) +
      geom_boxplot() +
      labs(title = paste("Distribution of", input$variable, "by", input$category),
           y = input$variable, x = input$category)
  })
  
  
}

# Run the application
shinyApp(ui = ui, server = server)