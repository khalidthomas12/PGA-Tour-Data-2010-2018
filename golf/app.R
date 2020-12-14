#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)

# Define UI for application that draws a histogram
ui <- fluidPage(theme = shinytheme("cyborg"),
                navbarPage(strong("Golf Analysis", style = "color:green"),
                           #Information About me and my Dataset
                           tabPanel("About",
                                    titlePanel(h2(strong("Golf is Hard. We're Here to Help"), align = "center", style = "color:green")),
                                    mainPanel(
                                        br(),
                                        
                    #About the utility of the website
                                        h3("Why We Created This Analysis"),
                                     p("Earlier this year, I began playing golf more consistently I had played a few times before, but I was never good enough to really enjoy the game. I had some leisure time, so I started studying what techniques can help you improve your golf game"),
                                     br(),
                                     p("What I began to understand that every shot in golf is different, and that the game is complex."),
                                     br(),
                                     p("This project seeks to give insight into what measurables players should maximize to maximize earnings. There are several unique parts to a golf game, from hitting a driver to putting uphill vs. downhill. Although there is a ton of sports science data that tells players how they should play to bring down their score, statistical data points to several simple trends that could potentially benefit players without adjusting their physical golf 
                                       mechanics. If a small shift in one statistical category can change a professional player's game for the better or earng them more money, it may be worth focusing on that one unique aspect of their game rather than the entirety of the sport."),
                                     br(),
                                    
                                     
                    #A description of how I found the dataset
                                     h3("How This Analysis is Composed"),
                                     p("The data was collected from PGA tour observations from tournaments from 2010-2018. It was aggregated and publicized via Kaggle, a platform that verifies and checks datasets for suitability. I cross referenced the statistics with PGATOUR.com and DATAGOLF.com for accuracy"),
                                     p("The link to the dataset and other PGA refernces can be found here"), 
                                     br(),
                                     a("https://www.kaggle.com/jmpark746/pga-tour-data-2010-2018", style = "color:darkgreen"),
                                     br(),
                                     a("https://www.pgatour.com/stats.html", style = "color:darkgreen"),
                                     br(),
                                     br(),
                                     
                    #About me and my Github Link
                                     h3("About Me"),
                                     p("My name is Khalid Thomas and I am a student at Harvard in the class of 2022. I am very active on campus, participating in Varisty Football as well as a few clubs and organizations. In my free time, I enjoy spending time with my colleagues and golfing."),
                                     br(),
                                     p("Here are the links to my social media profiles"),
                                     p("Instagram:", a("https://www.instagram.com/khalid_thomas/?hl=en", style = "color:green")),
                                     p("LinkedIn:", a("https://www.linkedin.com/in/khalid-thomas-76b9a491/", style = "color:green")),
                                     br(),
                                     br(),
                                     p("My GitHub profile:", a(strong("https://github.com/khalidthomas12"), style = "color:darkgreen"))
                                    )
                           ),
                           
                           
                         #Page comparing golfer's metrics
                           tabPanel("Professional Golfer's Stats",
                                    h2(strong("What Does It Take To Be A Pro?"), align = "center", style = "color:green"),
                                    br(),
                                    h5("Metrics for over 500 PGA tour players from the years 2010-2018"),
                                    fluidPage(
                                        titlePanel(""),
                                        sidebarLayout(
                                            sidebarPanel(
                                                h4(strong( "Select a Pro to See Their Stats Over the Years", align = "center")),
                                                br(),
                                                br(),
                                                selectInput(inputId = "choose_player",
                                                     "Player Name",
                                                     formatted$`Player Name`,
                                                     selected = "Tiger Woods",
                                                     FALSE),
                                                varSelectInput(inputId = "choose_stat",
                                                     "Metric",
                                                     formatted %>% 
                                                         select(-`Player Name`, -Year, -`Average Scrambling`, -`Average SG Putts`, -`Average SG Total`, -`Avg Distance`),
#selected out these cols to avoid redundancy
                                                     selected = formatted$Wins,
                                                     FALSE)),
                                        mainPanel(plotOutput("player_plot"))),
                                    


br(),
br(),
br(),
br(),
br(),


# Explain golf terms 
h2("Glossary of Metrics"),
hr(),
h3("Rounds", style = "color:green"),
p("Number of times a player played a continuous 18 holes of golf. In tournamnets, players will play several rounds."),
h3("Fairway Percentage", style = "color:green"),
p("Number of times a player's first shot is on the Fairway, the middle of the hole, compared to the number of total first shots"),
h3("Average Putts",style = "color:green"),
p("Average number of times a player uses a putter per round"),
h3("Average Score",style = "color:green"),
p("Statistical mean annually of each player's rounds of golf during that year"),
h3("Points",style = "color:green"),
p("The number of points earned on the PGA tour per year. Each player recieves a set number of points per hole, based on the score under par. For example: if a hole is a par 4, meaning the player should finish the hole in 4 shots, and a player takes four shots, then they get a score 1 point. Three shots would earn 2 points, two would be 3 points, etc.. "),
h3("Wins",style = "color:green"),
p("Number of PGA tournaments won in the given year"),
h3("Top 10",style = "color:green"),
p("Number of times a player finished in the top 10 scores for a tournament in a given year"),
h3("Earnings",style = "color:green"),
p("Amount of money won in a given year, in US dollars"),
h3("Average Distance", style = "color:green"),
p("The statistical mean of the distance of a player's first shot for each hole, per year in yards"))),



#Another Data exploration page
tabPanel("How to Get Better at Golf",
        titlePanel(h2(strong( "Which Parts of Your Game Should You Improve?"),align = "center", style = "color:green")),
         br(),
         h4( "To Understand How to Improve Your Golf Game Most Effectively, Evaluate Metrics Against One Another to See Their Relationship", align = "center"),
         br(),
         br(),
         br(),
         h4("Select a Player and Two Metrics to Compare", style = "color:green", align = "center"),
         plotOutput("versus_plot"),
         hr(),
        
        
#Not a huge fan of fluidpage/fluidrow, but I use it to organize my inputs
         fluidRow(
             helpText("**Metrics have been recorder per player and faceted per year**", align = "right"),
             column(3, align = "center",
                    offset = 1,
                    selectInput(inputId = "choose_player2",
                                "Player Name",
                                golfers$player_name,
                                selected = "Tiger Woods",
                                FALSE)),
             column(3, align = "center",
                    offset = 0,
                    varSelectInput(inputId = "choose_stat2",
                                   "Metric",
                                   formatted %>% 
                                       select(-`Player Name`, -`Average Scrambling`, -`Average SG Putts`, -`Average SG Total`),
                                   selected = "Fairway Percentage",
                                   FALSE)),
             column(3, align = "center", 
                    offset = 0,
                    varSelectInput(inputId = "choose_stat3",
                                   "Metric",
                                   formatted %>% 
                                       select(-`Player Name`, -`Average Scrambling`, -`Average SG Putts`, -`Average SG Total`),
                                   selected = "Avg Distance",
                                   FALSE)),
             br(),
             br(),
             br(),
             br(),
    #a Brief explaination of the utility of this page
             h3("What it Means", 
                style = "color:green"),
             h5("In general, trends between metrics can show if professionals got better at aspects of their game at the same time, or if certains aspects of their golf game suffer as others improve"),
             br(),
             h5("A green regression line has been fitted to the data observations in order to more clearly show the relationship between metrics"),
             br(),
             h5("A vertical regression line suggests that there was a strong relationship between the two variables. A horizontal regressionline suggests that there was little to no relationship between the variables. An upward sloping line suggests that the variables increased together, and as one metric improved the other did as well. A downward sloping line suggest the metrics did not increase together, and as one metric improved the other worsened")
         )
),
tabPanel("Model",
         titlePanel(h2(strong("How to Make the Big Bucks"), align = "center")),
         hr(),
         br(),
         
    
)))

    
    
    



server <- function(input, output) {

    
# Define server logic required to draw a bar graph
    output$player_plot <- renderPlot({
        formatted %>% 
            mutate(`Avg Distance` == "Avgerage Distance") %>% 
            select(-`Avg Distance`) %>% 
            filter(`Player Name` == input$choose_player) %>% 
            ggplot(aes_string(x = "Year", y = input$choose_stat))+
            geom_col(fill = "darkgreen")+
            geom_text(aes_string(label = input$choose_stat), vjust = -0.5)+
            theme_light() +
            theme(axis.text.x = element_text(angle = 45, size = 16,  vjust = 0.5),
                  axis.title.x = element_text(size = 24, vjust = 0.5),
                  axis.text.y  = element_text(size = 16),
                  axis.title.y = element_text(size = 24),
                  axis.title = element_text(size = 48))+
            labs(x = "Year",
                 y = input$choose_stat) 
        
    })

    output$versus_plot <- renderPlot({
        formatted %>% 
            ggplot(aes_string(x = input$choose_stat2, y = input$choose_stat3, alpha = .2)) +
            geom_point()+
            facet_wrap(~ formatted$Year, ncol = 9)+
            theme_minimal()+
            geom_smooth(method = "lm", color = "dark green")+
            theme(legend.position = "none")+
            labs(x = input$choose_stat2,
                 y = input$choose_stat3)
            
    })}

# Run the application 
shinyApp(ui = ui, server = server)
