library(shiny)
library(usmap)
library(tidyverse)

df <- read.csv("CourtData - Sheet1.csv", header = TRUE)  


ui <- fluidPage(
  titlePanel("Court Transparency"),
  sidebarLayout(
    sidebarPanel(
      radioButtons("typeInput", "Court Transparency Type",
                   choices = c("State.Judiciary.is.subject.to.FOIA", "State.Judicial.Rule.Provides.Access", "Either.Court.Rule.or.FOIA.Provides.Access", "Probation.and.Pretrial.Data.is.Subject.to.FOIA", "Court.Use.of.Public.Funds.is.Subject.to.FOIA"),
                   selected = "State.Judiciary.is.subject.to.FOIA")
    ),
    mainPanel(
      plotOutput("coolplot"),
      br(), br()
    )
  )
)

server <- function(input, output) {
  output$coolplot <- renderPlot({
    party_colors <- c("#CF5C36", "#003A63") 
    plot_usmap(data = df, 
               values = input$typeInput) +
      scale_fill_manual(values = party_colors)
  })
}

shinyApp(ui = ui, server = server)