path <- "~/Documents/4_Teaching/空間資料教學"
setwd(path)
source("#CheckLibrary.R")

###### Read data 1 ######
# 請讀TOWN_MOI_1081121.shp並選擇臺南市作為圖資使用

###### Read data 2 ######
# 請利用read.csv讀取104台南登革熱.csv
# 並將欄位名稱改為: c("date", "district", "village", "street", "lon", "lat")

###### Read data 3 ######
# 請利用read.csv讀取108TaiwanPopulation.csv
# 並仿照4_demo_population.R中"Read data 2"部分的程式碼刪除不需要之rows及欄位轉換

###### Combine data ######
# 請仿照4_demo_population.R中"Combine data"部分的程式碼結合圖資和人口資料

###### polygon ######
# 請仿照2_demo_pm25.R中"Point"部分的程式碼，以及4_demo_population.R中"polygon"部分的程式碼
# 畫登革熱和臺南鄉鎮人口密度分佈

