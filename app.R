#
# Vessel position application
# Aleksandar Matic
# 12.2020
#

library(shiny)
library(shiny.semantic)
library(dplyr)

dfVessel <- read.csv("C:/Users/aleksandar.matic/Documents/R/Vessel/shipstemp.csv")

VesselList <- distinct(dfVessel,ship_type)


# Select Vessel combobox UI

VesselTypeCombo_UI <- function(id){
    ns = NS(id)
    fluidRow(
    column(6,dropdown_input(ns("a"), choices = VesselList$ship_type, type = "selection single")),
    column(6,dropdown_input(ns("b"), choices = NULL, type = "selection single"),
           options = list(onInitialize = I('function() { this.setValue(""); }')
    )
    )
    )
}



VesselTypeCombo <- function( session){
    moduleServer(
         id,
        function(input, output, session) {

            observeEvent(input$a,{

                SelectedVesselType <- filter(VesselList,ship_type == input$SelectedVesselType)
                     update_dropdown_input(
                         session = session,
                         input_id = "b",
                         choices = "A"#SelectedVesselType
                     
                     )
           })
            
       }
    )
}



# Define UI for application
ui <- semanticPage(

    sidebarLayout(
        sidebarPanel(
            # p("Select vessel type: "),
             #VesselTypeComboUI(),

            p("Select vessel: "),
            VesselTypeCombo_UI("first")

        ),
        mainPanel(
            
            )
        )
    )



# Define server logic
server <- function(input, output) {
     VesselTypeCombo(input, output,"first")

}

# Run the application
shinyApp(ui = ui, server = server)

