library(data.table)
setwd("~/gittest/")
day.price = read.table("./data/price_2010_2018_daily.txt",fileEncoding = 'UTF-8')
day.price<-day.price[,-2]
colnames(day.price)<-c("id","date","close")


dayprice.reorder = dcast(day.price,data~id)
dim(daycap.reorder)
write_rds(daycap.reorder, "day_price.rds")
