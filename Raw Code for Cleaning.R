Sep21_tripdata <- read.csv("Data/202109-divvy-tripdata.csv")
Oct21_tripdata <- read.csv("Data/202110-divvy-tripdata.csv")
Nov21_tripdata <- read.csv("Data/202111-divvy-tripdata.csv")
Dec21_tripdata <- read.csv("Data/202112-divvy-tripdata.csv")
Jan22_tripdata <- read.csv("Data/202201-divvy-tripdata.csv")
Feb22_tripdata <- read.csv("Data/202202-divvy-tripdata.csv")
Mar22_tripdata <- read.csv("Data/202203-divvy-tripdata.csv")
Apr22_tripdata <- read.csv("Data/202204-divvy-tripdata.csv")
May22_tripdata <- read.csv("Data/202205-divvy-tripdata.csv")
Jun22_tripdata <- read.csv("Data/202206-divvy-tripdata.csv")
Jul22_tripdata <- read.csv("Data/202207-divvy-tripdata.csv")
Aug22_tripdata <- read.csv("Data/202208-divvy-tripdata.csv")

colnames(Sep21_tripdata)
colnames(Oct21_tripdata)
colnames(Nov21_tripdata)
colnames(Dec21_tripdata)
colnames(Jan22_tripdata)
colnames(Feb22_tripdata)
colnames(Mar22_tripdata)
colnames(Apr22_tripdata)
colnames(May22_tripdata)
colnames(Jun22_tripdata)
colnames(Jul22_tripdata)
colnames(Aug22_tripdata)

compare_df_cols(Sep21_tripdata,Oct21_tripdata,Nov21_tripdata,Dec21_tripdata,Jan22_tripdata,Feb22_tripdata,Mar22_tripdata,Apr22_tripdata,May22_tripdata,Jun22_tripdata,Jul22_tripdata,Aug22_tripdata, return="mismatch")

tripdata_all <- bind_rows(Sep21_tripdata,Oct21_tripdata,Nov21_tripdata,Dec21_tripdata,Jan22_tripdata,Feb22_tripdata,Mar22_tripdata,Apr22_tripdata,May22_tripdata,Jun22_tripdata,Jul22_tripdata,Aug22_tripdata)

tripdata_all <- tripdata_all %>% 
  select(-c(start_lat,start_lng,end_lat,end_lng))

colnames(tripdata_all)
dim(tripdata_all)
head(tripdata_all)
str(tripdata_all)
summary(tripdata_all)

tripdata_all['date'] <- as.Date(tripdata_all$started_at)
tripdata_all$month <- format(as.Date(tripdata_all$date), "%m")
tripdata_all$day <- format(as.Date(tripdata_all$date), "%d")
tripdata_all$weekday <- format(as.Date(tripdata_all$date), "%A")
tripdata_all$length_of_ride <- difftime(tripdata_all$ended_at,tripdata_all$started_at)

tripdata_all$length_of_ride <- as.numeric(as.character(tripdata_all$length_of_ride))

min(tripdata_all$length_of_ride)
summary(tripdata_all)
is.numeric(tripdata_all$length_of_ride)

tripdata_final <- tripdata_all[!(tripdata_all$length_of_ride < 0),]
min(tripdata_final$length_of_ride)

write.csv(tripdata_final, "tripdata_final.csv")