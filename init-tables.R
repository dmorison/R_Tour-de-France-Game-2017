setwd("C:/Users/davem/coding_2017/tourdefrance_game")

### Create initial df_player_st_winners table
player_st_winners <- data.frame(Stage = character(), Winning_player = character(), Points = character())
write.csv(player_st_winners, file = "player-st-winners.csv", row.names = FALSE)

### Create initial df_rider_code_results table
# MIGHT have to remove row names after creation...?
rider_code_results <- data.frame(Stage = factor(), Stage_win = factor(), Team = factor(), Yellow = factor(),
                                 Green = factor(), Polka_dot = factor(), White = factor(), Agressive = factor())
write.csv(rider_code_results, file = "rider-code-results.csv", row.names = FALSE)

### Create initial df_rider_name_results table
# MIGHT have to remove row names after creation...?
rider_name_results <- data.frame(Stage = factor(), Stage_win = factor(), Team = factor(), Yellow = factor(),
                                 Green = factor(), Polka_dot = factor(), White = factor(), Agressive = factor())
write.csv(rider_name_results, file = "rider-name-results.csv", row.names = FALSE)
###

df_players <- read.csv("players-codes.csv")
players_stage_results <- data.frame(df_players$Players)
colnames(players_stage_results) <- "Players"
write.csv(players_stage_results, file = "players-stage-results.csv", row.names = FALSE)
### Initialise the players accumulative stage scores table (used for progress line chart)
players_stage_accum <- data.frame(Players = df_players$Players, Stage_0 = rep(0, length(df_players$Players)))
write.csv(players_stage_accum, file = "players-accum-stage-results.csv", row.names = FALSE)
