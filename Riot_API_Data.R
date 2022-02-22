#loading libraries
library(httr)
library(jsonlite)
library(data.table)
library(plyr)
library(dplyr)
library(rjson)
library(tidyr)
library(readxl)
library(magrittr)
library(stringr)

#general parameters
apiKey = "MY-API-KEY"
puuid = "MY-PUUID"

#match parameters
start = "0"
match_count = "99"
match_type = "ranked"

#retrieves match IDs
match_ids = GET(paste("https://americas.api.riotgames.com/lol/match/v5/matches/by-puuid/",puuid,"/ids?type=",match_type,"&start=",start,"&count=",match_count,"&api_key=",apiKey, sep=""))
match_ids = fromJSON(rawToChar(match_ids$content))


#retrieve corresponding match information for each match ID
my_list <- list()

for (i in match_ids){
  stats <- GET(paste("https://americas.api.riotgames.com/lol/match/v5/matches/",i,"?api_key=",apiKey, sep=""))
  sdata = fromJSON(rawToChar(stats$content))
  my_list[[i]] = sdata
}

#now time to convert raw lists into data frames

#match information
matches_db <- sapply(my_list, function(v) v[1])
matches_db <- data.frame(matrix(unlist(matches_db), nrow=length(matches_db), byrow=TRUE),stringsAsFactors=TRUE)
colnames(matches_db) <- c("data_version", "match_id", paste0("P", 1:10))
matches_db <- pivot_longer(matches_db, P1:P10, names_to = "participant_num", values_to = "participant_puuid")


#participants information
participants <- my_list %>% 
  sapply(function(v) v[2]) %>%
  sapply(function(v) v[11])
participants <- unlist(participants, recursive = F)
participants <- lapply(participants, rapply, f=c)
participants_db <- data.frame(matrix(unlist(participants), nrow=length(participants), byrow=TRUE),stringsAsFactors=TRUE)
colnames(participants_db) <- names(participants[[1]])

#moving runes data to its own table
runes_db <- participants_db[, c(107, 91, 56:86) ] 
participants_db <- subset(participants_db, select = -c(56:86))

#teams information
teams <- sapply(my_list, function(v) v[2])
teams <- sapply(teams, function(v) v[14])
teams <- lapply(teams, rapply, f=c)
teams_db <- data.frame(matrix(unlist(teams), nrow=length(teams), byrow=TRUE),stringsAsFactors=TRUE)
colnames(teams_db) <- names(teams[[1]])
teams_db <- pivot_longer(teams_db, bans.championId, values_to = "bannedChampionId", names_repair = "unique")
teams_db <- teams_db %>% 
  subset(select = -c(1:5, 20:24, 39)) %>%
  select(bannedChampionId, everything())
colnames(teams_db) <- sub("^objectives.", "", colnames(teams_db))
teams_db <- teams_db %>%
  rename_with(~paste0("team1.",.), 2:15) %>%
  rename_with(~paste0("team2.",.), 16:29) 
colnames(teams_db) <- str_sub(colnames(teams_db),1,nchar(colnames(teams_db))-4)

#getting champion ids to match champion names
champions = GET("https://ddragon.leagueoflegends.com/cdn/12.3.1/data/en_US/champion.json")
champions = fromJSON(rawToChar(champions$content)) 
champions <- champions %>% 
  unlist(recursive = F)
champions <-  sapply(champions, function(v) v[3])
names(champions) <- sub("^data.", "", names(champions))
champions <- data.frame(champions)
champions <- pivot_longer(champions, cols= 4:161, names_to ="championName", values_to= "champId")
champions$championName <- gsub(".key","",champions$championName)
champions <- subset(champions, select = -c(1:3))

#writing data into csv format
write.csv(matches_db, "matches_db.csv", row.names = FALSE)
write.csv(participants_db, "participants_db.csv", row.names = FALSE)
write.csv(teams_db, "teams_db.csv", row.names = FALSE)
write.csv(champions, "champions.csv", row.names = FALSE)
