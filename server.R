setwd(getwd())

data <- read.csv("co2.csv")

shinyServer(function(input,output,session){
  output$slectionBox <- renderUI({ checkbox
    
  })
  output$txt <- renderText({
    icons <- paste(input$slectionBox, collapse = ", ")
    paste("You selected", icons)
    print(input$slectionBox)
  })
  values <- reactiveValues()
  
  
  output$Plantpannel <- renderUI({
    if(length(which(input$slectionBox == "Plant")) > 0){
      plantbox <- selectInput("Plantpannel",label ="Choose Plant",
                              choices = as.list(unique(data[,2])),multiple = TRUE,selected = as.list(unique(data[,2])))
    }else {
      return(NULL)
    }
  })
  output$Typepannel <- renderUI({
    if(length(which(input$slectionBox == "Type")) > 0){
      Typebox <- selectInput("Typepannel",label ="Choose Type  ",
                             choices = as.list(unique(data[,3])),multiple = TRUE,selected = as.list(unique(data[,3])))
    }else {
      return(NULL)
    }
  })
  
  output$Tretpannel <- renderUI({
    if(length(which(input$slectionBox == "Treatment")) > 0){
      TretBox <- selectInput("Tretpannel",label ="Choose Treatment",
                             choices = as.list(unique(data[,4])),multiple = TRUE,selected = as.list(unique(data[,4])))
    }else {
      return(NULL)
    }
  })
  dataset_a <- reactive({
    head(data)
    fin <- data[data$Plant %in% input$Plantpannel & data$Type %in% input$Typepannel & data$Treatment %in% input$Tretpannel,]
    return(fin)
  })
  
  output$plot <- renderPlotly({
    fin <- dataset_a()
    fig <- plot_ly(fin, x = fin[,5]  , y = fin[,6])%>%
      layout(title = paste("Conc Across The Uptake"),xaxis =list(title="Conc"),
             yaxis =  list(title="Uptake"))
    
  })    

}
)
