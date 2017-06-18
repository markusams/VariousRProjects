library(shiny)

### Packages
require(leaflet)
require(tidyr)

shinyServer(function(input, output) {
    
    ams_students <- read.table("ams_students.txt",sep=";")
    factpal <- colorNumeric("Reds",ams_students$TOTAAL)
    factpal2 <- colorNumeric("Blues", ams_students$NOATPCT)
    
    timeseries <- read.table("timeseries.txt",sep=";")
    drops <- c("VESTIGINGSNUMMER","ADRES.VESTIGING","POSTCODE.VESTIGING","PLAATSNAAM.VESTIGING","PROVINCIE.VESTIGING","GEMEENTENUMMER.VESTIGING","GEMEENTENAAM.VESTIGING")
    timeseries <- timeseries[ , !(names(timeseries) %in% drops)]
    timeseries <- gather(timeseries,VESTIGINGSNAAM)
    colnames(timeseries) <- c("name","year","value")
    timeseries$year <- as.numeric(timeseries$year)
    
    output$plot1 <- renderLeaflet({
        x <- filter(ams_students,ams_students$TOTAAL>input$minStudents)
        x <- filter(x,x$NOATPCT>input$minNOAT)
        x %>% leaflet() %>% addTiles() %>% addCircleMarkers(popup=~DESC,color=~factpal(TOTAAL)) %>% addLegend("bottomright",pal=factpal,values=ams_students$TOTAAL,title="TOTAAL")})
  
    output$plot2 <- renderLeaflet({
        x <- filter(ams_students,ams_students$TOTAAL>input$minStudents)
        x <- filter(x,x$NOATPCT>input$minNOAT)
        x %>% leaflet() %>% addTiles() %>% addCircleMarkers(popup=~DESC,color=~factpal2(NOATPCT)) %>% addLegend("bottomright",pal=factpal2,values=ams_students$NOATPCT,title="NOATPCT")})  
})