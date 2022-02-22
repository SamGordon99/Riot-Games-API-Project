--Summary of champion winrates for my account (most played)
SELECT 
	p.championName, 
	COUNT(p.championName) AS "Games",
	ROUND(w.Wins*100.0/COUNT(p.championName),1)  || '%' AS "Win Rate"
FROM participants p
JOIN (SELECT championName, COUNT(championName) AS "Wins"
	  FROM participants 
	  WHERE win = "TRUE" AND summonerName = "LordWalrusLlama" 
	  GROUP BY championName) w ON p.championName = w.championName
WHERE summonerName == "LordWalrusLlama" 
GROUP BY p.championName
ORDER BY "Games" DESC;

--Summary of champion winrates for all other accounts recorded (most games played)
SELECT 
	p.championName, 
	ROUND(AVG(kills), 1) AS "Average Kills",
	ROUND(AVG(deaths),1) AS "Average Deaths", 
	ROUND(AVG(assists),1) AS "Average Assists", 
	ROUND((AVG(kills) + AVG(assists)) / AVG(deaths),1) AS "KDA",
	COUNT(p.championName) AS "Games",
	ROUND(w.Wins*100.0/COUNT(p.championName),1) || '%' AS "Win Rate"
FROM participants p
JOIN (SELECT championName, COUNT(championName) AS "Wins"
	  FROM participants 
	  WHERE win = "TRUE" AND summonerName <> "LordWalrusLlama" 
	  GROUP BY championName) w ON p.championName = w.championName
WHERE summonerName <> "LordWalrusLlama" 
GROUP BY p.championName
HAVING "Games" > 3
ORDER BY "Games" DESC;

--Summary of champion statistics for my account (highest winrate)
SELECT 
	p.championName, 
	ROUND(AVG(kills), 1) AS "Average Kills",
	ROUND(AVG(deaths),1) AS "Average Deaths", 
	ROUND(AVG(assists),1) AS "Average Assists", 
	ROUND((AVG(kills) + AVG(assists)) / AVG(deaths),1) AS "KDA",
	COUNT(p.championName) AS "Games",
	ROUND(w.Wins*100.0/COUNT(p.championName),1)  || '%' AS "Win Rate"
FROM participants p
JOIN (SELECT championName, COUNT(championName) AS "Wins"
	  FROM participants 
	  WHERE win = "TRUE" AND summonerName = "LordWalrusLlama" 
	  GROUP BY championName) w ON p.championName = w.championName
WHERE summonerName == "LordWalrusLlama" 
GROUP BY p.championName
ORDER BY w.Wins*100.0/COUNT(p.championName) DESC;

--Summary of champion statistics for all other accounts recorded (highest winrate)
SELECT 
	p.championName, 
	ROUND(AVG(kills), 1) AS "Average Kills",
	ROUND(AVG(deaths),1) AS "Average Deaths", 
	ROUND(AVG(assists),1) AS "Average Assists", 
	ROUND((AVG(kills) + AVG(assists)) / AVG(deaths),1) AS "KDA",
	COUNT(p.championName) AS "Games",
	ROUND(w.Wins*100.0/COUNT(p.championName),1) || '%' AS "Win Rate"
FROM participants p
JOIN (SELECT championName, COUNT(championName) AS "Wins"
	  FROM participants 
	  WHERE win = "TRUE" AND summonerName <> "LordWalrusLlama" 
	  GROUP BY championName) w ON p.championName = w.championName
WHERE summonerName <> "LordWalrusLlama" 
GROUP BY p.championName
HAVING "Games" > 3
ORDER BY w.Wins*100.0/COUNT(p.championName) DESC;

--Summary of champion statistics for my account (lowest winrate)
SELECT 
	p.championName, 
	ROUND(AVG(kills), 1) AS "Average Kills",
	ROUND(AVG(deaths),1) AS "Average Deaths", 
	ROUND(AVG(assists),1) AS "Average Assists", 
	ROUND((AVG(kills) + AVG(assists)) / AVG(deaths),1) AS "KDA",
	COUNT(p.championName) AS "Games",
	ROUND(w.Wins*100.0/COUNT(p.championName),1)  || '%' AS "Win Rate"
FROM participants p
JOIN (SELECT championName, COUNT(championName) AS "Wins"
	  FROM participants 
	  WHERE win = "TRUE" AND summonerName = "LordWalrusLlama" 
	  GROUP BY championName) w ON p.championName = w.championName
WHERE summonerName == "LordWalrusLlama" 
GROUP BY p.championName
ORDER BY w.Wins*100.0/COUNT(p.championName) ASC;

--Summary of champion statistics for all other accounts recorded (lowest winrate)
SELECT 
	p.championName, 
	ROUND(AVG(kills), 1) AS "Average Kills",
	ROUND(AVG(deaths),1) AS "Average Deaths", 
	ROUND(AVG(assists),1) AS "Average Assists", 
	ROUND((AVG(kills) + AVG(assists)) / AVG(deaths),1) AS "KDA",
	COUNT(p.championName) AS "Games",
	ROUND(w.Wins*100.0/COUNT(p.championName),1) || '%' AS "Win Rate"
FROM participants p
JOIN (SELECT championName, COUNT(championName) AS "Wins"
	  FROM participants 
	  WHERE win = "TRUE" AND summonerName <> "LordWalrusLlama" 
	  GROUP BY championName) w ON p.championName = w.championName
WHERE summonerName <> "LordWalrusLlama" 
GROUP BY p.championName
HAVING "Games" > 3
ORDER BY w.Wins*100.0/COUNT(p.championName) ASC;

--highest KDA (me)
SELECT championName,
	   count(championName) AS "Games Played",
	   ROUND(AVG(kills), 1) AS "Average Kills",
	   ROUND(AVG(deaths),1) AS "Average Deaths", 
	   ROUND(AVG(assists),1) AS "Average Assists", 
	   ROUND((AVG(kills) + AVG(assists)) / AVG(deaths),1) AS "KDA"
FROM participants
WHERE summonerName = "LordWalrusLlama"
GROUP BY championName
ORDER BY "KDA" DESC;

--highest KDA
SELECT championName,
	   count(championName) AS "Games Played",
	   ROUND(AVG(kills), 1) AS "Average Kills",
	   ROUND(AVG(deaths),1) AS "Average Deaths", 
	   ROUND(AVG(assists),1) AS "Average Assists", 
	   ROUND((AVG(kills) + AVG(assists)) / AVG(deaths),1) AS "KDA"
FROM participants
WHERE summonerName <> "LordWalrusLlama"
GROUP BY championName
ORDER BY "KDA" DESC;

--lowest KDA (me)
SELECT championName,
	   count(championName) AS "Games Played",
	   ROUND(AVG(kills), 1) AS "Average Kills",
	   ROUND(AVG(deaths),1) AS "Average Deaths", 
	   ROUND(AVG(assists),1) AS "Average Assists", 
	   ROUND((AVG(kills) + AVG(assists)) / AVG(deaths),1) AS "KDA"
FROM participants
WHERE summonerName = "LordWalrusLlama"
GROUP BY championName
ORDER BY "KDA" ASC;

--lowest KDA
SELECT championName,
	   count(championName) AS "Games Played",
	   ROUND(AVG(kills), 1) AS "Average Kills",
	   ROUND(AVG(deaths),1) AS "Average Deaths", 
	   ROUND(AVG(assists),1) AS "Average Assists", 
	   ROUND((AVG(kills) + AVG(assists)) / AVG(deaths),1) AS "KDA"
FROM participants
WHERE summonerName <> "LordWalrusLlama"
GROUP BY championName
HAVING "Games Played" >=3
ORDER BY "KDA" ASC;

--Lane positions statistics
SELECT 
	teamPosition, 
	ROUND(AVG(kills), 1) AS "Average Kills",
	ROUND(AVG(deaths),1) AS "Average Deaths", 
	ROUND(AVG(assists),1) AS "Average Assists", 
	ROUND((AVG(kills) + AVG(assists)) / AVG(deaths),2) AS "KDA"
FROM participants 
GROUP BY teamPosition
ORDER BY "KDA" DESC;

--What champions get first blood most often?
SELECT championName, teamPosition, COUNT(firstBloodKill) AS "First Bloods"
FROM participants
WHERE firstBloodKill = "TRUE"
GROUP BY championName
ORDER BY "First Bloods" DESC;

--Average Damage taken and mitigated
SELECT championName, 
	   ROUND(AVG(damageSelfMitigated) + AVG(totalDamageTaken)) AS "Damage Taken and Mitigated", 
	   COUNT(championName) AS "Games Played"
FROM participants
GROUP BY championName
ORDER BY "Damage Taken and Mitigated" DESC;

--Average Damage taken and mitigated
SELECT championName, 
	   ROUND(AVG(totalDamageDealtToChampions)) AS "Average Damage against Champions",
	   COUNT(championName) AS "Games Played"
FROM participants
GROUP BY championName
ORDER BY "Average Damage against Champions" DESC;

--most banned champions
SELECT c.championName, COUNT(t.bannedChampi) AS "Number of Times Banned"
FROM teams_db t
JOIN champions c ON c.champId = t.bannedChampi
GROUP BY c.championName
ORDER BY COUNT(t.bannedChampi) DESC;

--game times (excluding surrender)
SELECT ROUND(AVG(timePlayed)/60,1) AS "Average Game Time (mins)", 
	   ROUND(MAX(timePlayed)/60,1) AS "Highest Game Time (mins)", 
	   ROUND(MIN(timePlayed)/60,1) AS "Lowest Game Time (mins)"
FROM participants
WHERE gameEndedInEarlySurrender = "FALSE"
AND gameEndedInSurrender = "FALSE";

--game time raw
SELECT timePlayed / 60 AS "Game Time", championName
FROM participants
WHERE summonerName = "LordWalrusLlama"
