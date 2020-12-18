path <- "~/Documents/4_Teaching/空間資料教學"
setwd(path)
source("#CheckLibrary.R")

###### Read data ######
setwd(paste0(path, "/Data/台灣縣市"))
taiwan <- rgdal::readOGR(dsn = paste0(path, "/Data/台灣縣市"), layer = "COUNTY_MOI_1090820")
class(taiwan)

# View(taiwan@data)
# B<-as.vector(taiwan@data$COUNTYNAME)
# Encoding(B) <- "UTF-8"
# taiwan@data$COUNTYNAME<-B
# View(taiwan@data)


###### 資料結構 ######
slotNames(taiwan)
taiwan@data
names(taiwan)
taiwan@data$COUNTYNAME
head(fortify(taiwan))

###### 畫邊界圖 ######
ggplot() +
    geom_path(data = taiwan, 
              aes(x = long, y = lat, 
                  group = group))

##### 部分區域 ######
map <- subset(taiwan, taiwan$COUNTYNAME %in% c("臺南市"))
ggplot()+
    geom_path(data = map, 
              aes(x = long, y = lat, group = group))  +
    xlim(119.5, 121) +
    ylim(22, 24) 

