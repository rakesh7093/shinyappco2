library(shiny)
library(shinydashboard)
library(plotly)

setwd(getwd())

ui <- fluidPage(
    dashboardPage(
        dashboardHeader(title = "CO2 Dashboard",titleWidth = 250),
        dashboardSidebar(
            checkboxGroupInput("slectionBox", "Variables to show:",
                               c("Plant","Type","Treatment"),selected=c("Plant")),
            textOutput("txt")
        ),
        dashboardBody(
            column(width=3,uiOutput("Plantpannel")),
            column(width=3,uiOutput("Typepannel")),
            column(width=3,uiOutput("Tretpannel")),
            column(width=9,box(status = "primary", solidHeader = TRUE,
                               collapsible = F,plotlyOutput("plot"),width = 100, height = 470))
            
            
        ),
    )
    
)

