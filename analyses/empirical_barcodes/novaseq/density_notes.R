library(plyr)
library(ggplot2)
library(plotly)
library(viridis)
library(MASS)

a = c()
for (i in 1:125){
  b = sample(1:5, 1)
  a = c(a,b)
}
a <- count(a)
a


#TURN COUNT DATA TO A BAR PLOT, THEN DENSITY
a<-as.data.frame(matrix( c(1:10,sample(c(200:300),size=10)), ncol=2,nrow=10))
ggplot(a,aes(x=V1,y=V2))+geom_bar(stat="identity")

a$V2<-a$V2/sum(a$V2)
ggplot(a,aes(x=V1,weight=V2)) + geom_density(size=1)


#HISTOGRAM OF NON-COUNT DATA
set.seed(123)
df <- data.frame(x = rbeta(10000, shape1 = 2, shape2 = 4))
ggplot(df, aes(x = x)) +
  geom_histogram(colour = "black", fill = "white", binwidth = 0.01) 

ggplot(df, aes(x = x)) +
  geom_density(size=1)
