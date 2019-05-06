rm(list = ls())

day.price = read.table("C:/gittest/01/0506/price_2010_2018_daily.txt")
day.price<-day.price[,-2]
colnames(day.price)<-c("id","","","date","close")
head(day.price)

library(data.table)
dayprice.reorder = dcast(day.price, date~id)
dim(dayprice.reorder)
head(dayprice.reorder)
write_rds(dayprice.reorder, "day_price.rds")

