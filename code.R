setwd("C:/Users/davem/coding_2017/tourdefrance_game")
### SECTION TO UPDATE - FOLLOW STEPS ###
### update stage with which the results are going to be for
stage <- "Stage_3"
### update stage rider code results: win, yellow, green, polka, white, red, team
st_rider_code_results <- c("num_117", "num_099", "num_057", "num_009", "num_123", "num_111", "BOR")
### update stage rider name results: win, yellow, green, polka, white, red, team
st_rider_name_results <- c("SINKELDAM Ramon", "Chris Froome", "HALLER Marco", "SANCHEZ GIL Luis-Leon",
                           "LADAGNOUS Matthieu", "LANGEVELD Sebastian", "Astana")

########################################
df_rider_code_results <- read.csv("rider-code-results.csv", header = TRUE)
df_rider_name_results <- read.csv("rider-name-results.csv", header = TRUE)
### DO FIRST STAGE MANUALLY SO SKIP THIS STEP AND GO TO CALCULATION !!!
row_rider_code_results <- c(stage, st_rider_code_results)
df_rider_code_results[] <- lapply(df_rider_code_results, as.character)
update_df_rider_code_results <- rbind(row_rider_code_results, df_rider_code_results)
write.csv(update_df_rider_code_results, file = "rider-code-results.csv", row.names = FALSE)

row_rider_name_results <- c(stage, st_rider_name_results)
df_rider_name_results[] <- lapply(df_rider_name_results, as.character)
update_df_rider_name_results <- rbind(row_rider_name_results, df_rider_name_results)
write.csv(update_df_rider_name_results, file = "rider-name-results.csv", row.names = FALSE)

### CALCULATION
df_players <- read.csv("players-codes.csv")
df_players_results <- read.csv("players-stage-results.csv")
### REMEMBER TO SKIP THIS FOR FIRST STAGE!!!
df_player_st_winners <- read.csv("player-st-winners.csv")

scores <- c(3, 2, 1, 1, 1, 1, 1)
st_results <- apply(df_players[, 2:8], 1, function(x){ sum(scores[which(st_rider_code_results %in% x)]) })
st_results_df <- cbind(df_players_results, st_results)

st_player_topscore <- max(st_results)
st_player_winner <- as.character(st_results_df[which(st_results_df$st_results == st_player_topscore), "Players"])
if (length(st_player_winner) > 1) {
  st_player_winner <- paste(st_player_winner, collapse = ', ')
}
row_st_player_winner <- c(stage, st_player_winner, st_player_topscore)
### REMEMBER TO ADD ABOVE MANUALLY FOR FIRST STAGE AND THEN SKIP THE NEXT TWO LINES!!!
df_player_st_winners[] <- lapply(df_player_st_winners, as.character)
update_df_player_st_winners <- rbind(row_st_player_winner, df_player_st_winners)
write.csv(update_df_player_st_winners, file = "player-st-winners.csv", row.names = FALSE)

colnames(st_results_df)[ncol(st_results_df)] <- stage
write.csv(st_results_df, file = "players-stage-results.csv", row.names = FALSE)

if(ncol(st_results_df) > 2) {
  player_totals <- apply(st_results_df[, 2:ncol(st_results_df)], 1, function(x){ sum(x) })
} else {
  player_totals <- st_results
}
player_totals_df <- data.frame(Players = st_results_df$Players, Total_score = player_totals)
player_totals_df <- player_totals_df[order(-player_totals_df$Total_score), ]
write.csv(player_totals_df, file = "players-leaderboard.csv", row.names = FALSE)
########################################

### CONSTANTS - NO NEED TO TOUCH THIS CODE AFTER INITIALIZING IT IN BEGINNING
# scoring <- c("Stage_win", "Yellow", "Green", "Polka_dot", "White", "Agressive", "Team")
### Create players code table in beginning
player_1 <- c("Dave", "MVS", "num_001",	"num_002", "num_117",	"num_045", "num_123",	"num_074")
player_2 <- c("Jayde", "AST", "num_001", "num_006", "num_099", "num_023", "num_056", "num_143")
player_3 <- c("Storm", "AST", "num_117", "num_009", "num_098", "num_086", "num_057", "num_143")

players <- data.frame(rbind(player_1, player_2, player_3))
colnames(players) <- c("Player", "Team", "Rider_1", "Rider_2", "Rider_3", "Rider_4", "Rider_5", "Rider_6")
write.csv(players, file = "players-codes.csv", row.names = FALSE)

### Create players name table in beginning


### Create players stage results table in beginning
players_stage_results <- data.frame(players$Player)
colnames(players_stage_results) <- "Players"
write.csv(players_stage_results, file = "players-stage-results.csv", row.names = FALSE)

##################
### DO NOT USE ###
### Create initial df_player_st_winners table
player_st_winners <- data.frame(Stage = character(), Winning_player = character(), Points = character())
write.csv(player_st_winners, file = "player-st-winners.csv", row.names = FALSE)

### Create initial df_rider_code_results table
rider_code_results <- data.frame(Stage_win = factor(), Yellow = factor(), Green = factor(), Polka_dot = factor(),
                                 White = factor(), Agressive = factor(), Team = factor())
write.csv(rider_code_results, file = "rider-code-results.csv", row.name = FALSE)

### Create initial df_rider_name_results table
rider_name_results <- data.frame(Stage_win = factor(), Yellow = factor(), Green = factor(), Polka_dot = factor(),
                                 White = factor(), Agressive = factor(), Team = factor())
write.csv(rider_name_results, file = "rider-name-results.csv", row.name = FALSE)
#########################################



