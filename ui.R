library(shiny)
library(DT)

fluidPage(
  
  mainPanel(
    DT::dataTableOutput('riderNameResults'),
    #DT::dataTableOutput('finalOverallResults'),
    DT::dataTableOutput('playerStWinners'),
    DT::dataTableOutput('playersStScores'),
    DT::dataTableOutput('leaderboard'),
    
    plotOutput('wormChart'),
    
    DT::dataTableOutput('playersTeams')
  )
  
)
