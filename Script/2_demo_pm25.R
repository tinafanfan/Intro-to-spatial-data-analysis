path <- "~/Documents/4_Teaching/空間資料教學"
setwd(path)
source("#CheckLibrary.R")

###### Read data 1 ######
setwd(paste0(path, "/Data/台灣縣市"))
taiwan <- rgdal::readOGR(dsn = paste0(path, "/Data/台灣縣市"), layer = "COUNTY_MOI_1090820")
# View(taiwan@data)
# #chinese code procedure
# B<-as.vector(tw.map@data$COUNTYNAME)
# Encoding(B) <- "UTF-8"
# tw.map@data$COUNTYNAME<-B
# View(tw.map@data)

###### Read data 2 ######
setwd(paste0(path, "/Data"))
load(file = "pm.RData")

###### point ######
ggplot(data_points, aes(x=lon, y=lat, color=pm25)) +
    geom_path(data = taiwan,
              aes(x = long, y = lat, group = group),
              color = 'black', size = .1) +
    geom_point(size=1) +
    scale_colour_gradientn(colours = c("green4","yellow","orange","red","purple"),
                           values = seq(0,1, length.out = 10),
                           limits = c(0,125),
                           guide = "colourbar",
                           name = bquote(mu * g / km^2),
                           breaks = seq(0,120,by=20),
                           labels = seq(0,120,by=20)) +
    coord_cartesian(xlim = c(119.7, 122.3), 
                    ylim = c(21.6,25.6), 
                    expand = FALSE) + 
    theme_void() +
    theme(legend.position=c(0.85,0.3), 
          legend.text = element_text(size = 15),
          legend.key.size = unit(1, "cm"), 
          legend.title = element_text(size = 15))

###### raster ######
ggplot(data_raster, aes(x=lon, y=lat, color=pm25)) +
    geom_raster(aes(fill = pm25)) +
    scale_fill_gradientn(colours = c("green4","yellow","orange","red","purple"), 
                         values = seq(0,1, length.out = 10),
                         limits = c(0,125),
                         guide = "colourbar",
                         name = bquote(mu * g / km^2),
                         breaks = seq(0,120,by=20),
                         labels = seq(0,120,by=20)) +
    theme_void() +
    geom_path(data = taiwan,
              aes(x = long, y = lat, group = group),
              color = 'black', size = .1) +
    coord_cartesian(xlim = c(119.7, 122.3), 
                    ylim = c(21.6,25.6), 
                    expand = FALSE) + 
    theme(legend.position=c(0.85,0.3), 
          legend.text = element_text(size = 15),
          legend.key.size = unit(1, "cm"), 
          legend.title = element_text(size = 15))





