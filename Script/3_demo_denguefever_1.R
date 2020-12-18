path <- "~/Documents/4_Teaching/空間資料教學"
setwd(path)
source("#CheckLibrary.R")

###### Read data 1 ######
setwd(paste0(path, "/Data/台灣鄉鎮"))
taiwan <- rgdal::readOGR(dsn = paste0(path, "/Data/台灣鄉鎮"), layer = "TOWN_MOI_1081121")
# View(taiwan@data)
# #chinese code procedure
# B<-as.vector(taiwan@data$COUNTYNAME)
# Encoding(B) <- "UTF-8"
# taiwan@data$COUNTYNAME<-B
# B<-as.vector(taiwan@data$TOWNNAME)
# Encoding(B) <- "UTF-8"
# taiwan@data$TOWNNAME<-B
# View(taiwan@data)
map <- subset(taiwan, taiwan$COUNTYNAME %in% c("臺南市"))

###### Read data 2 ######
setwd(paste0(path, "/Data"))
data_disease <- read.csv(file = "104台南登革熱.csv")
colnames(data_disease) <- c("date", "district", "village", "street", "lon", "lat")

###### points ######
ggplot(data_disease, aes(x=lon, y=lat)) +
    geom_point(size = 1) +
    geom_path(data = map,
              aes(x = long, y = lat, group = group),
              color = 'black', size = .1) +
    theme_void() +
    theme(legend.position = "none") +
    coord_cartesian(xlim = c(119.7, 121), 
                    ylim = c(22.5, 23.5), 
                    expand = FALSE)

