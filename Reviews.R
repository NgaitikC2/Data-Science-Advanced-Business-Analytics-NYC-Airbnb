df <- read.csv('Reviews2020.csv')
df <- subset(df, date >"2020-01-01" & date <"2020-06-30")

str(df)

df$listing_id <- factor(df$listing_id)
df$id <- factor(df$id)
df$reviewer_name <- factor(df$reviewer_name)
df$comments <- as.character(df$comments)
df$date <- as.Date(df$date,format="%Y-%m-%d")

str(df)
library(dplyr)

paper1 <- df
paper1 = subset(paper1,select = -c(1,2,4,5))
paper1$date <- as.Date(paper1$date)

##aggregate(paper1$comments, list(paper1$date), paste, collapse="")

paper1 <- subset(paper1, date >"2020-01-01" & date <"2020-02-01")

dim(paper1)
str(paper1)

library(lubridate)
library(quanteda)

#paper1 <- gsub('[[:punct:]]','',paper1)

myCorpus <- corpus(paper1$comments)

#library(tm)
#library(textclean)
#myCorpus <- tm_map(myCorpus, removePunctuation)
#myCorpus <- tm_map(myCorpus, removeNumbers)

summary(myCorpus)
myDfm <- dfm(myCorpus)

# Simple frequency analyses
tstat_freq <- textstat_frequency(myDfm)
head(tstat_freq, 20)

# Visulize the most frequent terms
library(ggplot2)
myDfm %>% 
  textstat_frequency(n = 20) %>% 
  ggplot(aes(x = reorder(feature, frequency), y = frequency)) +
  geom_point() +
  labs(x = NULL, y = "Frequency") +
  theme_minimal()

# Remove stop words and perform stemming
library(stopwords)
myDfm <- dfm(myCorpus,
             remove_punc = T,
             remove = c(stopwords("english")),
             stem = T)
dim(myDfm)
topfeatures(myDfm,30)

stopwords2 <- c('???','T','s',
                'ã','ð','©','ì','ë','us','19')

myDfm <- dfm_remove(myDfm,stopwords2)
topfeatures(myDfm,30)

textplot_wordcloud(myDfm,max_words=200)

myDfm<- dfm_trim(myDfm,min_termfreq=5, min_docfreq=2)
dim(myDfm)

comments_sim <- textstat_simil(myDfm, 
                                selection="covid",
                                margin="feature",
                                method="correlation")
as.list(comments_sim,n=30)

library(topicmodels)
library(tidytext)

# Explore the option with 10 topics
# You can explore with varying k numbers
paper1 <- paper1[-c(146:25936),]

myDfm <- as.matrix(myDfm)
myDfm <-myDfm[which(rowSums(myDfm)>0),]
myDfm <- as.dfm(myDfm)

myLda <- LDA(myDfm,k=3,control=list(seed=101))
myLda

# Term-topic probabilities
myLda_td <- tidy(myLda)
myLda_td

# Visulize most common terms in each topic
library(ggplot2)
library(dplyr)

top_terms <- myLda_td %>%
  group_by(topic) %>%
  top_n(8, beta) %>%
  ungroup() %>%
  arrange(topic, -beta)

top_terms %>%
  mutate(term = reorder(term, beta)) %>%
  ggplot(aes(term, beta, fill = factor(topic))) +
  geom_bar(stat = "identity", show.legend = FALSE) +
  facet_wrap(~ topic, scales = "free") +
  coord_flip()

# View topic 8 terms in each topic
Lda_term<-as.matrix(terms(myLda,8))
View(Lda_term)

# Document-topic probabilities
ap_documents <- tidy(myLda, matrix = "gamma")
ap_documents

# View document-topic probabilities in a table
Lda_document<-as.data.frame(myLda@gamma)
View(Lda_document)
