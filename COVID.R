library(tidyverse) 

date <- "03-09-2020"

case_dat <-  read.csv((paste0("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/", date,".csv"))) %>% 
  select(-Province.State,-Latitude ,-Longitude,-Last.Update) %>% 
  group_by(Country.Region) %>% 
  summarise_all(tibble::lst(sum)) %>% 
  transmute(country=Country.Region,
            cases = Confirmed_sum,
            deaths = Deaths_sum)


final_dat <- left_join(case_dat, read.csv("data/GHSI.csv")) %>% 
  left_join(read.csv("data/IRC.csv",na.strings="n/a")) %>% 
  select(region,
         country,
         IRC_site,
         GHSI,
         cases,
         deaths) %>% 
  arrange(desc(cases))
