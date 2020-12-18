path <- "~/Documents/4_Teaching/空間資料教學"
setwd(path)
source("#CheckLibrary.R")

###### Read data 1 ######
setwd(paste0(path, "/Data/台灣鄉鎮"))
taiwan <- rgdal::readOGR(dsn = paste0(path, "/Data/台灣鄉鎮"), layer = "TOWN_MOI_1081121")
taiwan_map <- fortify(taiwan)
taiwan_map$id <- as.numeric(as.character(taiwan_map$id))

###### Read data 2 ######
setwd(paste0(path, "/Data"))
data_pop <- read.csv(file = "108TaiwanPopulation.csv", header = T)
data_pop <- data_pop[-c(1,370:375),]
data_pop$people_total <- as.numeric(as.character(data_pop$people_total))
data_pop$site_id <- as.character(data_pop$site_id)
# B<-as.vector(data_pop$site_id)
# Encoding(B) <- "UTF-8"
# data_pop$site_id <- B

###### Combine data ######
mydata <- data.frame(name = paste0(taiwan@data$COUNTYNAME, taiwan@data$TOWNNAME, sep = ""),
                     id = row.names(taiwan@data),
                     population = 0)

for(i in 1:nrow(mydata)){
    mydata$population[i] <- data_pop$people_total[which(data_pop$site_id == mydata$name[i])]
}

final.plot <- merge(taiwan_map,mydata,by="id",all.x=T)

###### polygon ######
ggplot() +
    geom_polygon(data = final.plot, 
                 aes(x = long, y = lat, group = group, 
                     fill = population), 
                 color = "black", size = 0.2) + 
    scale_fill_gradientn(colours = brewer.pal(9,"Reds"),
                         name = "Population") +
    coord_cartesian(xlim = c(119.7, 122.3), 
                    ylim = c(21.6,25.6), 
                    expand = FALSE) + 
    theme_void() +
    theme(legend.position=c(0.85,0.3), 
          legend.text = element_text(size = 15),
          legend.key.size = unit(1, "cm"), 
          legend.title = element_text(size = 15))

