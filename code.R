setwd("C:/Users/davem/coding_2017/tourdefrance_game")
df_start_list <- read.csv("start-list_2017.csv")
### SECTION TO UPDATE - FOLLOW STEPS ###
### update stage with which the results are going to be for
stage <- "Stage_2"
### Lookup classifications for after the stage
df_start_list[grep("Ger", df_start_list$Rider), ]
### update stage rider name results: win, team, yellow, green, polka, white, red
st_rider_name_results <- c("Mark Cavendish (GBr)", "Dimension Data", "Richie Porte (Aus)", "Tony Martin (Ger)",
                           "Andre Greipel (Ger)", "Simon Yates (GBr)", "Geraint Thomas (GBr)")
### update stage rider code results: win, team, yellow, green, polka, white, red
st_rider_code_results <- c("rd101", "DIM", "rd091", "rd142",
                           "rd161", "rd201", "rd008")

########################################
### DO FIRST STAGE MANUALLY SO SKIP THIS STEP AND GO TO CALCULATION !!!
df_rider_code_results <- read.csv("rider-code-results.csv", header = TRUE)
df_rider_name_results <- read.csv("rider-name-results.csv", header = TRUE)

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
###
scores <- c(3, 1, 2, 1, 1, 1, 1)
st_results <- apply(df_players[, 2:8], 1, function(x){ sum(scores[which(st_rider_code_results %in% x)]) })
st_results_df <- cbind(df_players_results, st_results)

st_player_topscore <- max(st_results)
st_player_winner <- as.character(st_results_df[which(st_results_df$st_results == st_player_topscore), "Players"])
if (length(st_player_winner) > 1) {
  st_player_winner <- paste(st_player_winner, collapse = ', ')
}
row_st_player_winner <- c(stage, st_player_winner, st_player_topscore)
### REMEMBER TO ADD ABOVE MANUALLY FOR FIRST STAGE AND THEN SKIP THE NEXT THREE LINES!!!
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

players_stage_accum <- read.csv("players-accum-stage-results.csv")
st_accum_df <- cbind(players_stage_accum, player_totals)
colnames(st_accum_df)[ncol(st_accum_df)] <- stage
write.csv(st_accum_df, file = "players-accum-stage-results.csv", row.names = FALSE)
########################################
### FINAL STAGE CALCULATIONS
overall_prizes <- c("First", "Second", "Third", "Green jersey", "Polka dot jersey", "White jersey", "Super combative",
                    "Final stage winner", "Overall winning team", "Lanten Rouge")
stage <- "Overall"
### Lookup overall classification
df_start_list[grep("Row", df_start_list$Rider), ]

oa_rider_name_results <- c("Chris Froome (GBr)", "Rigoberto Uran (Col)", "Romain Bardet (Fra)",
                           "Michael Matthews (Aus)", "Warren Barguil (Fra)", "Simon Yates (GBr)",
                           "Warren Barguil (Fra)", "Dylan Groenewegen (Ned)", "Sky", "Luke Rowe (GBr)")
oa_rider_code_results <- c("rd001", "rd088", "rd041",
                           "rd111", "rd113", "rd201",
                           "rd113", "rd054", "SKY", "rd007")

df_rider_name_overall <- data.frame(Award = overall_prizes, Rider = oa_rider_name_results,
                                    Points = scores) # scores come from below
write.csv(df_rider_name_overall, file = "rider_name_overall.csv", row.names = FALSE)
### CALCULATION
df_players <- read.csv("players-codes.csv")
df_players_results <- read.csv("players-stage-results.csv")
### REMEMBER TO SKIP THIS FOR FIRST STAGE!!!
df_player_st_winners <- read.csv("player-st-winners.csv")
###
scores <- c(10, 6, 4, 3, 3, 3, 2, 3, 3, 5)
oa_results <- apply(df_players[, 2:8], 1, function(x){ sum(scores[which(oa_rider_code_results %in% x)]) })
oa_results_df <- cbind(df_players_results, oa_results)

oa_player_topscore <- max(oa_results)
oa_player_winner <- as.character(oa_results_df[which(oa_results_df$oa_results == oa_player_topscore), "Players"])
if (length(oa_player_winner) > 1) {
  oa_player_winner <- paste(oa_player_winner, collapse = ', ')
}
row_oa_player_winner <- c(stage, oa_player_winner, oa_player_topscore)

df_player_st_winners[] <- lapply(df_player_st_winners, as.character)
update_df_player_st_winners <- rbind(row_oa_player_winner, df_player_st_winners)
write.csv(update_df_player_st_winners, file = "player-st-winners.csv", row.names = FALSE)

colnames(oa_results_df)[ncol(oa_results_df)] <- stage
write.csv(oa_results_df, file = "players-stage-results.csv", row.names = FALSE)

if(ncol(oa_results_df) > 2) {
  player_totals <- apply(oa_results_df[, 2:ncol(oa_results_df)], 1, function(x){ sum(x) })
} else {
  player_totals <- oa_results
}
player_totals_df <- data.frame(Players = oa_results_df$Players, Total_score = player_totals)
player_totals_df <- player_totals_df[order(-player_totals_df$Total_score), ]
write.csv(player_totals_df, file = "players-leaderboard.csv", row.names = FALSE)

players_stage_accum <- read.csv("players-accum-stage-results.csv")
oa_accum_df <- cbind(players_stage_accum, player_totals)
colnames(oa_accum_df)[ncol(oa_accum_df)] <- stage
write.csv(oa_accum_df, file = "players-accum-stage-results.csv", row.names = FALSE)
########################################

### CONSTANTS - NO NEED TO TOUCH THIS CODE AFTER INITIALIZING IT IN BEGINNING
# scoring <- c("Stage_win", "Yellow", "Green", "Polka_dot", "White", "Agressive", "Team")
### Players teams and rider names
df_players_teams <- read.csv("players-teams.csv")
### Complete start list of teams and riders
df_start_list <- read.csv("start-list_2017.csv")
### First read in df_players table from above then create players stage results table in beginning
players_stage_results <- data.frame(df_players$Players)
colnames(players_stage_results) <- "Players"
write.csv(players_stage_results, file = "players-stage-results.csv", row.names = FALSE)
### Initialise the players accumulative stage scores table (used for progress line chart)
players_stage_accum <- data.frame(Players = df_players$Players, Stage_0 = rep(0, length(df_players$Players)))
write.csv(players_stage_accum, file = "players-accum-stage-results.csv", row.names = FALSE)
##################
### DO NOT USE ###
### Create initial df_player_st_winners table
player_st_winners <- data.frame(Stage = character(), Winning_player = character(), Points = character())
write.csv(player_st_winners, file = "player-st-winners.csv", row.names = FALSE)

### Create initial df_rider_code_results table
# remove row names after creation
rider_code_results <- data.frame(Stage_win = factor(), Yellow = factor(), Green = factor(), Polka_dot = factor(),
                                 White = factor(), Agressive = factor(), Team = factor())
write.csv(rider_code_results, file = "rider-code-results.csv")

### Create initial df_rider_name_results table
# remove row names after creation
rider_name_results <- data.frame(Stage_win = factor(), Yellow = factor(), Green = factor(), Polka_dot = factor(),
                                 White = factor(), Agressive = factor(), Team = factor())
write.csv(rider_name_results, file = "rider-name-results.csv")
#########################################



