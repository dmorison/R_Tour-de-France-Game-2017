library(shiny)
library(DT)
library(ggplot2)
library(reshape2)

df_rider_name_results <- read.csv("rider-name-results.csv")
df_player_st_winners <- read.csv("player-st-winners.csv")
df_players_results <- read.csv("players-stage-results.csv")
player_totals_df <- read.csv("players-leaderboard.csv")
df_players_teams <- read.csv("players-teams.csv")
players_stage_accum <- read.csv("players-accum-stage-results.csv")
#df_rider_name_overall <- read.csv("rider_name_overall.csv") # Final overall results

function(input, output) {
  
  output$riderNameResults <- DT::renderDataTable(
    DT::datatable(df_rider_name_results,
                  rownames = FALSE,
                  options = list(pageLength = 5,
                                 dom = 'ftp'))
  )
  
  #output$finalOverallResults <- DT::renderDataTable(
  #  DT::datatable(df_rider_name_overall,
  #                rownames = FALSE,
  #                options = list(autoWidth = TRUE,
  #                               dom = 't'))
  #)
  
  output$playerStWinners <- DT::renderDataTable(
    DT::datatable(df_player_st_winners,
                  rownames = FALSE,
                  options = list(pageLength = 5,
                                 autoWidth = TRUE,
                                 dom = 'tp'))
  )
  
  output$playersStScores <- DT::renderDataTable(
    DT::datatable(df_players_results,
                  rownames = FALSE,
                  options = list(scrollX = TRUE,
                                 dom = 't'))
  )
  
  output$leaderboard <- DT::renderDataTable(
    DT::datatable(player_totals_df,
                  rownames = FALSE,
                  options = list(autoWidth = TRUE,
                                 dom = 't'))
  )
  
  output$wormChart <- renderPlot({
    
    m_players_accum <- melt(players_stage_accum, id.vars = "Players")
    print(
      ggplot(m_players_accum, aes(x = variable, y = value, group = Players)) +
        geom_line(aes(colour = Players), size = I(1.5)) +
        scale_colour_manual(values = c("#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")) +
        theme(axis.text.x = element_text(angle = 60, hjust = 1)) +
        labs(x = "Stage", y = "Score", title = "Players acumulative scores after each stage")
    )
    
  })
  
  output$playersTeams <- DT::renderDataTable(
    DT::datatable(df_players_teams,
                  rownames = FALSE,
                  options = list(dom = 't'))
  )
  
}
