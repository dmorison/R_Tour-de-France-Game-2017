setwd("C:/Users/davem/coding_2017/tourdefrance_game")
### SECTION TO UPDATE - FOLLOW STEPS
### update stage with which the results are going to be for
stage <- "Stage_1"
### update stage rider code results: win, yellow, green, polka, white, red, team
st_rider_code_results <- c("num_117", "num_001", "num_143", "num_028", "num_123", "num_086", "AST")
### update stage rider name results: win, yellow, green, polka, white, red, team
st_rider_name_results <- c("SINKELDAM Ramon", "Chris Froome", "HALLER Marco", "SANCHEZ GIL Luis-Leon",
                           "LADAGNOUS Matthieu", "LANGEVELD Sebastian", "Astana")
####################################
df_rider_code_results <- read.csv()
df_rider_name_results <- read.csv()

row_rider_code_results <- c(stage, st_rider_code_results)
update_df_rider_code_results <- rbind(df_rider_code_results, row_rider_code_results)
write.csv(update_df_rider_code_results, file = "", row.names = FALSE)
row_rider_name_results <- c(stage, st_rider_name_results)
update_df_rider_name_results <- rbind(df_rider_name_results, row_rider_name_results)
write.csv(update_df_rider_name_results, file = "", row.names = FALSE)

### CALCULATION
df_players <- read.csv("players.csv")
df_players_results <- read.csv("players-stage-results.csv")
df_player_st_winners <- read.csv("")

scores <- c(3, 2, 1, 1, 1, 1, 1)
st_results <- apply(df_players[, 2:8], 1, function(x){ sum(scores[which(st_rider_code_results %in% x)]) })
st_results_df <- cbind(df_players_results, st_results)

st_player_topscore <- max(st_results)
st_player_winner <- as.character(st_results_df[which(st_results_df$st_results == st_player_topscore), "Players"])
if (length(st_player_winner) > 1) {
  st_player_winner <- paste(st_player_winner, collapse = ', ')
}
row_st_player_winner <- c(stage, st_player_winner, st_player_topscore)
update_df_player_st_winners <- rbind(row_st_player_winner, df_player_st_winners)
write.csv(update_df_player_st_winners, file = "", row.names = FALSE)

colnames(st_results_df)[ncol(st_results_df)] <- stage
write.csv(st_results_df, file = "players-stage-results.csv")

if(ncol(st_results_df) > 2) {
  player_totals <- apply(st_results_df[, 2:ncol(st_results_df)], 1, function(x){ sum(x) })
} else {
  player_totals <- st_results
}
player_totals_df <- data.frame(Players = st_results_df$Players, Total_score = player_totals)
player_totals_df <- player_totals_df[order(-player_totals_df$Total_score), ]
write.csv(player_totals_df, file = "", row.names = FALSE)

### CONSTANTS - NO NEED TO TOUCH THIS CODE
scoring <- c("Stage_win", "Yellow", "Green", "Polka_dot", "White", "Agressive", "Team")

player_1 <- c("dave", "MVS", "num_001",	"num_002", "num_117",	"num_045", "num_123",	"num_074")
player_2 <- c("jayde", "AST", "num_001", "num_006", "num_099", "num_023", "num_056", "num_143")
player_3 <- c("storm", "AST", "num_117", "num_009", "num_098", "num_086", "num_057", "num_143")

players <- data.frame(rbind(player_1, player_2, player_3))
colnames(players) <- c("Player", "Team", "Rider_1", "Rider_2", "Rider_3", "Rider_4", "Rider_5", "Rider_6")
write.csv(players, file = "players.csv", row.names = FALSE)

players_stage_results <- data.frame(players$Player)
colnames(players_stage_results) <- "Players"
write.csv(players_stage_results, file = "players-stage-results.csv", row.names = FALSE)
#########################################



