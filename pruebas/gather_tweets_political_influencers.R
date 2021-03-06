


```{r, include = FALSE}

library(twitteR)
library(tidyverse)
library(rtweet)

# API authorization 
rtweet::create_token(app = "aletheia_hertie", 
                     consumer_key = "XXX",
                     access_secret = "XXX",
                     access_token = "XXX",
                     consumer_secret = "XXX")

```

```{r, echo=FALSE}

# Accounts most read by Cifras y Conceptos opinion leaders panel 
names <- c(
  "Daniel Samper",
  "Daniel Coronell", 
  "Gustavo Petro", 
  "Felix de Bedout",
  "Alvaro Uribe",
  "Vicky Davila", 
  "La Pulla",
  "Alejandro Gaviria",
  "Claudia Lopez",
  "Ivan Cepeda", 
  "Gustavo Bolivar",
  "Carolina Sanin", 
  "Ariel Avila",
  "Ivan Duque",
  "Manuel Rodriguez", 
  "Daniel Quintero", 
  "Jorgue Enrique Robledo",
  "Maria Jimena Duzan", 
  "Matador", 
  "Gustavo Gomez", 
  "Moises Wasserman", 
  "Catherine Juvinao") 

usernames <- c(
  "@DanielSamperO",
  "@DCoronell",
  "@petrogustavo",
  "@fdbedout",
  "@AlvaroUribeVel",
  "@VickyDavilaH",
  "@LaPullaOficial", 
  "@agaviriau",
  "@ClaudiaLopez", 
  "@IvanCepedaCast",
  "@GustavoBolivar", 
  "@SaninPazC", 
  "@ArielAnaliza",
  "@IvanDuque",
  "@manuel_rodb",
  "@QuinteroCalle", 
  "@JERobledo",
  "@MJDuzan",
  "@Matador000",
  "@gusgomez1701", 
  "@mwassermannl", 
  "@CathyJuvinao")

influencers <- data.frame()

for (i in usernames) {
  influencers <- rbind(influencers, 
                       twitteR::userTimeline(user = i, n = 3200, includeRts = TRUE) %>%
                         twListToDF())
}

save(influencers, file = "data/tweets_influencers.RData")

```

