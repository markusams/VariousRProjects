library(shiny)
shinyUI(fluidPage(
    titlePanel("Basis-school"),
    sidebarLayout(
        sidebarPanel(
            h3("Input"),
            sliderInput("minStudents", "Minimum Number of students", 1, 1200, value = 1),
            sliderInput("minNOAT", "Minimum Number of NOAT pct", 1, 100, value = 0)
        ),
        
        # Show a plot of the generated distribution
        mainPanel(tabsetPanel(type="tabs",
            tabPanel("By number of students",h3("Primary Schools in Amsterdam"),leafletOutput("plot1")),
            tabPanel("By NOAT percentage",h3("Primary Schools in Amsterdam"),leafletOutput("plot2")),
            tabPanel("Source",a("Click here to view the source",href="https://duo.nl/open_onderwijsdata/databestanden/po/leerlingen-po/po-totaal/"))
            )
        )    
    )
))