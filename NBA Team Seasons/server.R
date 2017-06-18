library(shiny)
shinyServer(function(input, output) {
    require(ggplot2)
    require(dplyr)
    t_s <- read.csv("team_season.csv",sep=",")
    colnames(t_s)[1] <- "team"
    t_s<-t_s[1:((dim(t_s)[1])-5),]
    
    
    output$g <- renderPlot({
        a <- input$teamA
        b <- input$teamB
        y1 <- input$sliderY[1]
        y2 <- input$sliderY[2]
        
        ggplot(subset(t_s,(team %in% c(a, b)) & year < y2 & year >y1),aes(x=year,y=won,color=team))+geom_line()+geom_point()
    })
    
    output$text <- renderText({
        a<-filter(t_s,(team==input$teamA & year < input$sliderY[2] & year >input$sliderY[1]))
        teamAavg <- mean(a$won)
        b<-filter(t_s,(team==input$teamB & year < input$sliderY[2] & year >input$sliderY[1]))
        teamBavg <- mean(b$won)
        astr <- paste("Average Number of Wins for", input$teamA,":", teamAavg)
        bstr <- paste("Average Number of Wins for", input$teamB,":", teamBavg)
        if (!is.nan(teamAavg) && !is.nan(teamBavg)){paste(astr, bstr, sep="\n")}
        else{}
    })
    
    output$winsbyteam <- renderTable({
        t_s %>% filter(year < input$sliderY[2], year >input$sliderY[1]) %>% group_by(team) %>% summarize(total = sum(won)) %>% arrange(desc(total))
    })
})
