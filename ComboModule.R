DropDownComboGroup <- function(id, label="ConnectedDropDown"){
  ns <- NS(id)
  tagList(
    h4("Select vessel type"),
    uiOutput(ns("select_var1")), 
    h4("Select vessel"),
    uiOutput(ns("select_var2"))
  )
}

DropDownComboGroupServer <- function(input, output, session, t2Var,lb1,lb2){
  ns <- session$ns
  
  
  output$select_var1 <- renderUI({
    ns <- session$ns
    dropdown_input(input_id = ns("select_var1"),  choices =  unique(t2Var[,2]))
    
  })
  vt <- reactive({input$select_var1})
  
  cnames <- colnames(t2Var)
  c <- "ship_type"
  c1 <- "SHIPNAME"
  
  
  output$select_var2 <- renderUI({
    ns <- session$ns
    choice_var2 <- reactive({
      
      t <- t2Var[t2Var[[c]]== vt(),]
      as.character(t[[c1]])
    })
    
    dropdown_input(input_id = ns("select_var2"), choices = c("select" = "", choice_var2())) 
    
  })
  
  return(list(var1 = reactive({input$select_var1}), 
              var2   = reactive({input$select_var2})))
}

