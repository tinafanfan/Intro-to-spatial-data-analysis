path <- "~/Documents/4_Teaching/空間資料教學"
setwd(path)
source("#CheckLibrary.R")

###### Read data 1 ######
setwd(paste0(path, "/Data/台灣鄉鎮"))
taiwan <- rgdal::readOGR(dsn = paste0(path, "/Data/台灣鄉鎮"), layer = "TOWN_MOI_1081121")
taiwan <- subset(taiwan, taiwan$COUNTYNAME %in% c("臺南市"))
taiwan_map <- fortify(taiwan)

###### Read data 2 ######
setwd(paste0(path, "/Data"))
data_disease <- read.csv(file = "104台南登革熱.csv") # Data download from: https://data.tainan.gov.tw/dataset/denguefevercases/resource/7617bfcd-20e2-4f8d-a83b-6f6b479367f9
colnames(data_disease) <- c("date", "district", "village", "street", "lon", "lat")

###### Read data 3 ######
setwd(paste0(path, "/Data"))
data_pop <- read.csv(file = "108TaiwanPopulation.csv", header = T)
data_pop <- data_pop[-c(1,370:375),]
data_pop$people_total <- as.numeric(as.character(data_pop$people_total))
data_pop$site_id <- as.character(data_pop$site_id)

###### Combine data ######
mydata <- data.frame(name = paste0(taiwan@data$COUNTYNAME, taiwan@data$TOWNNAME, sep = ""),
                     id = row.names(taiwan@data),
                     density = 0)
for(i in 1:nrow(mydata)){
    mydata$density[i] <- data_pop$people_total[which(data_pop$site_id == mydata$name[i])]
}
final.plot <- merge(taiwan_map,mydata,by="id",all.x=T)

###### polygon ######
ggplot() +
    geom_polygon(data = final.plot, 
                 aes(x = long, y = lat, 
                     group = group, 
                     fill  = density), 
                 color = "black", size = 0.2, alpha = 0.5) + 
    scale_fill_gradientn(colours = brewer.pal(9,"Reds"),
                         name = "Population") +
    geom_point(data = data_disease, aes(x=lon, y=lat), size = 0.1)+
    coord_cartesian(xlim = c(119.7, 121), 
                    ylim = c(22.5, 23.5), 
                    expand = FALSE) + 
    theme_void() +
    theme(legend.position=c(0.85,0.3), 
          legend.text = element_text(size = 15),
          legend.key.size = unit(1, "cm"), 
          legend.title = element_text(size = 15))



