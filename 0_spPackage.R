path <- "~/Documents/4_Teaching/空間資料教學"
setwd(path)
source("#CheckLibrary.R")

###### Point ######
# coordinates
x = round(rnorm(10), 2)
y = round(rnorm(10), 2)
xy = cbind(x, y)
# attributes
df = data.frame(z1 = 1:10, 
                z2 = 11:20)
# w/o attributes
xy.sp = SpatialPoints(xy)
summary(xy.sp)
coordinates(xy.sp)
plot(coordinates(xy.sp), pch = 16)
# w/ attributes - 1
xy.df1 = SpatialPointsDataFrame(xy, df)
summary(xy.df1)
# w/ attributes - 2
xy.df2 = data.frame(xy, df)
coordinates(xy.df2) = c("x", "y")

###### Line ######
# coordinates
pt1 <- cbind(c(1,2,3),c(4,2.5,3))
pt2 <- cbind(c(1,2,3),c(1.5,2,1))
l1 = Line(pt1)
l2 = Line(pt2)
Sl1 = Lines(list(l1), ID="a")
Sl2 = Lines(list(l2), ID="b")
# w/o attributes
Sline = SpatialLines(list(Sl1, Sl2))
summary(Sline)
plot(Sline, axes = T)
points(pt1, pch = 16);points(pt2, pch = 16)
# w/ attributes
df = data.frame(z = c(1,2), 
                row.names=sapply(slot(Sline, "lines"), function(x) slot(x, "ID")))
Sldf = SpatialLinesDataFrame(Sline, data = df)
Sldf@data

###### Polygon ######
Sr1 = Polygon(cbind(c(2,4,4,1,2),c(2,3,5,4,2)))
Sr2 = Polygon(cbind(c(5,4,2,5),c(2,3,2,2)))
Sr3 = Polygon(cbind(c(4,4,5,10,4),c(5,3,2,5,5)))
Sr4 = Polygon(cbind(c(5,6,6,5,5),c(4,4,3,3,4)), hole = TRUE)
Srs1 = Polygons(list(Sr1), "s1")
Srs2 = Polygons(list(Sr2), "s2")
Srs3 = Polygons(list(Sr3, Sr4), "s3/4")
# w/o attributes
SpP = SpatialPolygons(list(Srs1,Srs2,Srs3), 1:3)
plot(SpP, col = 1:3, axes = T)
# w/ attributes
attr = data.frame(a=1:3, b=3:1, row.names=c("s3/4", "s2", "s1"))
SrDf = SpatialPolygonsDataFrame(SpP, attr)
SrDf@data

