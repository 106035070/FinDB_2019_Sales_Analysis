rm(list=ls())
library(tidyquant)
library(timetk)

stock_day_2_year<-read_tsv("D:/gittest/gittest01/0617/data_wrangle_practice/tej_day_price_2017_2018.txt")
glimpse(stock_day_2_year)

price_day_2_year <- stock_day_2_year %>% 
                    rename(id    = 證券代碼, 
                           name  = 簡稱, 
                           date  = 年月日, 
                           price = `收盤價(元)`,
                           cap   = `市值(百萬元)`
                    )
  
  dim(price_day_2_year)


price_day_2_year_1 <- stock_day_2_year %>% 
  rename(id    = 證券代碼, 
         name  = 簡稱, 
         date  = 年月日, 
         price = `收盤價(元)`,
         cap   = `市值(百萬元)`
  ) %>% 
  mutate(id = as.character(id)) %>%
  mutate(date = as.Date(as.character(date), '%Y%m%d')) %>%
  select(id, date, price) %>% 
  spread(key = id, value = price) 

 dim(price_day_2_year_1) 

price_day_2_year_na <- price_day_2_year_1 %>% 
  map_df(~sum(is.na(.))) %>% 
  gather() %>% 
  filter(value!=0)
price_day_2_year_na

price_day_2_year_na.1 <- price_day_2_year %>% 
  # last observation carried forward
  map_df(~sum(is.na(.))) %>% 
  gather() %>% 
  filter(value!=0)
price_day_2_year_na.1


price_day_2_year_clear <-  price_day_2_year_1 %>% 
                         na.locf(fromLast = TRUE, na.rm=FALSE) %>%
                         select(-c("2025", "6131"))
dim(price_day_2_year_clear)


dim(price_day_2_year_clear)


ret_day_2_year <- price_day_2_year_clear %>%
                 select(1:6) %>%
                 tk_xts(select = -date, date_var = date) %>% 
                 Return.calculate(method = "log") %>%
                 na.omit()

dim(ret_day_2_year)

head(ret_day_2_year,5)


price_day_2_year.xts <- price_day_2_year_clear %>%
  select(1:6) %>%
  tk_xts(select = -date, date_var = date)  

ret_mon_2_year.xts <- price_day_2_year.xts %>% 
  to.period(period = "months", 
            indexAt = "lastof", 
            OHLC= FALSE) %>% 
  Return.calculate(method = "log") %>%
na.omit()

dim(ret_mon_2_year.xts)

head(ret_mon_2_year.xts, 5)  


#9
tej <- read_tsv("D:/gittest/gittest01/0617/data_wrangle_practice/tej_day_price_2017_2018.txt", col_names = TRUE)
tej1<-tej %>% select('證券代碼', '年月日', '收盤價(元)') %>% 
  rename(ID = '證券代碼', date = '年月日', close = '收盤價(元)') %>%      
  mutate(date = date %>% as.character %>% as.Date('%Y%m%d')) %>% 
  mutate(ID = ID %>% as.character) %>% 
  arrange(ID)  
tej1

#10 



