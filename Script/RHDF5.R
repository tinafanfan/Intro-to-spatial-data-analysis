install.packages("BiocManager")
BiocManager::install("rhdf5")


setwd()
library(rhdf5)
h5createFile("2hdf5file.h5")
h5createGroup("2hdf5file.h5","site1")
h5createGroup("2hdf5file.h5","site2")
h5createGroup("2hdf5file.h5","site1/sensor a")
h5createGroup("2hdf5file.h5","site2/sensor a")
h5ls("2hdf5file.h5")

A = matrix(1:10,nr=5,nc=2)
h5write(A, "2hdf5file.h5","site1/sensor a/1-min")

B = c(0.3,0.01)
h5write(B, "2hdf5file.h5","site1/sensor a/30-mins")

C = data.frame(1:5,seq(0,1,length.out=5),c("x","yy","z","o","p"), stringsAsFactors=FALSE)
h5write(C, "2hdf5file.h5","site1/sensor a/daily avg.")

D = matrix(1:10,nrow=5,nc=2)
h5write(D, "2hdf5file.h5","site2/sensor a/1-min")

E =  c(0.3,0.01)
h5write(E, "2hdf5file.h5","site2/sensor a/30-mins")

G = data.frame(1:5,seq(0,1,length.out=5),c("x","yy","z","o","p"), stringsAsFactors=FALSE)
h5write(G, "2hdf5file.h5","site2/sensor a/daily avg.")
h5ls("2hdf5file.h5")



