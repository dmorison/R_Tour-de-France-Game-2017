updated <- Sys.Date()
df_rider_code_results <- read.csv()
df_rider_name_results <- read.csv()
### SECTION TO UPDATE - FOLLOW STEPS
### update stage with which the results are going to be for
stage <- "Stage - 1"
### update stage rider code results: win, yellow, green, polka, white, red, team
st_rider_code_results <- c("num_117", "num_001", "num_143", "num_028", "num_123", "num_086", "AST")
### update stage rider name results: win, yellow, green, polka, white, red, team
st_rider_name_results <- c("Chris Froome", "Nairo Quantana", "Richie Port", "Alberto Contador", "Tony Martin",
                           "Peter Sagan", "Astana")

row_rider_code_results <- c(stage, st_rider_code_results)
update_df_rider_code_results <- rbind(df_rider_code_results, row_rider_code_results)
write.csv(update_df_rider_code_results, file = "", row.names = FALSE)
row_rider_name_results <- c(stage, st_rider_name_results)
update_df_rider_name_results <- rbind(df_rider_name_results, row_rider_name_results)
write.csv(update_df_rider_name_results, file = "", row.names = FALSE)

scores <- c(3, 2, 1, 1, 1, 1, 1)

player_1 <- c("dave", "MVS", "num_001",	"num_002", "num_117",	"num_045", "num_123",	"num_074")
player_2 <- c("jayde", "AST", "num_001", "num_006", "num_099", "num_023", "num_056", "num_143")
player_3 <- c("storm", "AST", "num_117", "num_009", "num_098", "num_086", "num_057", "num_143")

players <- data.frame(rbind(player_1, player_2, player_3))

st_01_results <- mapply()

sum(scores[which(st_01 %in% player_3)])
