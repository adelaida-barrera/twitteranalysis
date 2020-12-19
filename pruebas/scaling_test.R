

library(tidyverse)
library(quanteda)
library(ca) # for scaling
library(kableExtra)
library(knitr)

# Trying out scaling with a random saple from all tweets 


load("data/non_congress_dfm_full")

#Dataframe with tweets and metadata (object name is "non_congres")
load("data/non_congress_fem_jul_nov_2020.RData")

# When trying to run  data.matrix(non_congress_dfm_full) to get a matrix that ca() can use, we get an error because there are too many counts of 'zero' -too many words appear to seldom.  

sparsity(non_congress_dfm_full)
# meaning that 99.9% of the cells are zeros. 

#We can trim the document feature matrix to remove the features with most empty cells
feminists_trimmed <- dfm_trim(non_congress_dfm_full, min_docfreq = 10, min_termfreq = 20, verbose = TRUE)
# Removing features:
# That appear less 20 times: 49,928
# That appear in less than 10 documents: 45,912
# Total features removed: 49,929 (90.4%).

# Document-feature matrix of: 68,441 documents, 5,275 features (99.9%       sparse) and 8 docvars

sample_feminists_dfm <- dfm_sample(x = feminists_trimmed, size = 5000, margin = "documents")

# Remove again features with very low or null counts 
sample_feminists_dfm <- dfm_trim(sample_feminists_dfm,  min_termfreq = 5, verbose = TRUE)

# Turn dfm into matrix to work with ca()
feminists_matrix <- data.matrix(sample_feminists_dfm)

# Remove rows with no counts on any of the remaining features
feminists_matrix <- feminists_matrix[rowSums(feminists_matrix != 0) != 0,] 

model_sample <- ca::ca(feminists_matrix)

# Gather document positions (thetas) and word positions (betas)

theta <- model_random_sample$rowcoor
beta <- model_random_sample$colcoord

theta <- theta %>% 
  as.data.frame() %>% 
  select(Dim1) %>% 
  arrange(desc(Dim1)) %>% 
  rownames_to_column(var = "text_id")

theta <-  theta %>% 
  mutate(screen_name = str_extract(text_id, ".+?(?=_)"),
         tweet_id = str_extract(text_id, "(?<=_).+")) %>% 
  group_by(screen_name) %>% 
  summarise(avg_position = mean(Dim1))

theta <- left_join(theta, select(non_congress,
                                 c(screen_name,
                                   main_occupation)),
                   by = "screen_name")

theta %>% ggplot(aes(x = avg_position, 
                     y = screen_name,
                     color = main_occupation)) +
  geom_point()  +  
  theme_minimal() +
  labs(y = "",
       x = "Position",
       color = "")
# scale_y_continuous(labels = thetas_dim1$party_year,
#               breaks = thetas_dim1$party_order) +
#  labs(x = "Position", y = "", color = "Party") +
#  ggtitle("Estimated Positions from Parties on 'Dimension 1'\n")

#This makes no sense whatsoever. Probably because the scaling analysis i
#presupposes or assumes that the texts are have a series of words chosen to express a certain position. Since these tweets are talking about all sorts of topics, this analysis is flawed. Baed on the topics we identified, We can subet the sample to get only the ones talking about politics and assume that these users are expressing their political position or ideology there. 