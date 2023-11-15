df3 <- read.csv("listingdata.csv",na.strings=c('NA',''))
df3

df2 <- read.csv("airbnbNYC.csv",na.strings=c('NA',''))

summary(df)
str(df)

## date
df$last_scraped <- as.Date(df$last_scrape,format="%Y-%m-%d")
df$host_since <- as.Date(df$host_since,format="%Y-%m-%d")
df$first_review <- as.Date(df$first_review,format="%Y-%m-%d")
df$last_review <- as.Date(df$last_review,format="%Y-%m-%d")


library(dplyr)
bind_rows(df, id = NULL)
library(tidyr)
install.packages('data.table')
library(data.table)
setDT(df)[, lapply(.SD, na.omit), by = id]

count(df, "id")

df %>%
  gather(key, value, -id) %>% 
  na.omit() %>% 
  spread(key, value)

## Categorical
df$id <- factor(df$id)
df$name <- factor(df$name)
df$host_id <- factor(df$host_id)
df$host_response_time <- factor(df$host_response_time)
df$host_verifications <- factor(df$host_verifications)
df$neighbourhood <- factor(df$neighbourhood)
df$city <- factor(df$city)
df$zipcode <- factor(df$zipcode)
df$property_type <- factor(df$property_type)
df$room_type <- factor(df$room_type)
df$bed_type <- factor(df$bed_type)
df$amennities <- factor(df$amenities)

## Integer
df$security_deposit <- as.numeric(df$security_deposit)
df$guests_included <- as.numeric(df$guests_included)

str(df)

df$host_acceptance_rate <- as.numeric(df$host_acceptance_rate)
df$host_response_rate <- as.numeric(df$host_response_rate)

df = subset(df,select = -c(2,4,6,13,17))

summary(df)
ncol(df)

write.csv(df,"~/DSBA 6211 project\\listingdatanew.csv", row.names = FALSE)

str(df)
ncol(df)

## export dataset for imputation and transformation in py

1. what types of listing in nyc and what is the most
2. look at average rent from jan - mar, then how covid affect in apr - june
3. find top 10 neihorhood with highest price and perform analysis in the area
4. text mining on comments
5. map with latitude and latitude


