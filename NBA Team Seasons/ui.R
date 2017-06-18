shinyUI(fluidPage(
    titlePanel("NBA Team Seasons"),
    sidebarLayout(
        sidebarPanel(
            h3("Explanation"),
            p("Select two team abbreviations to compare their wins in a graph and their average wins below. Use the slider to change the time frame. Go to the total wins by team tab to see a ranking by total wins for the selected time frame."),
            h3("Input"),
            selectInput("teamA", "Team One", t_s$team,selected="BOS",multiple=FALSE),
            selectInput("teamB", "Team Two", t_s$team,selected="LAL",multiple=FALSE),
            sliderInput("sliderY", "Pick two years",1946, 2010, value = c(1946, 2010))
            
        ),
        mainPanel(tabsetPanel(type="tabs",
            tabPanel("Wins by Season",
                h3("Plot"),
                plotOutput("g"),
                verbatimTextOutput("text")
                ),
            tabPanel("Total Wins by team",
                h3("Total Wins in the selected period by team"),
                tableOutput("winsbyteam")
                ),
            tabPanel("Source",
                a("Click here to view the source at databasketball.com",href="http://www.databasebasketball.com/stats_download.htm"
                )
            ))
        )
    )
))