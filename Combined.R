library(caret)
library(car)
library(pROC)
library(Hmisc)
library(dplyr)
library(rpart)
library(rpart.plot)

df <- read.csv("listings5.csv",na.strings=c('NA',''))
df1 <- read.csv("listings4.csv",na.strings=c('NA',''))
df2 <- read.csv("listings3.csv",na.strings=c('NA',''))
df3 <- read.csv("listings2.csv",na.strings=c('NA',''))
df4 <- read.csv("listings1.csv",na.strings=c('NA',''))
df5 <- read.csv("listings0.csv",na.strings=c('NA',''))

sum1 <- merge(df,df1, all=TRUE)
sum2 <- merge(sum1,df2, all=TRUE)
sum3 <- merge(sum2,df3, all=TRUE)
sum4 <- merge(sum3,df4, all=TRUE)
sum <- merge(sum4,df5, all=TRUE)

sum

summary(sum)
str(sum)

write.csv(sum,"~/DSBA 6211 project\\listingdata.csv", row.names = FALSE)
