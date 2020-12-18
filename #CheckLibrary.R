CheckLibrary=function(pkg)
{
  iniload=try(eval(parse(text=paste("library(",pkg,")",sep=""))))
  #if (class(iniload)!="try-error") 
  #{
  # cat(paste(pkg,"is loaded correctly.\n"))
  #} else 
  if (class(iniload)=="try-error") 
  {
    cat(paste(pkg,"is not installed.", "Automatic installation starts.\n"))
    install.packages(pkg,repos='http://cran.us.r-project.org') 
    
    reload=try(eval(parse(text=paste("library(",pkg,")",sep=""))))
    if ( class(reload)!="try-error" ) 
    {
      cat(paste(pkg,"now is installed and loaded.\n"))
    } else 
    {
      stop(paste("Something wrong with installing",pkg,".\n"))
    }
  }
}


#Data
# CheckLibrary("jsonlite")
# CheckLibrary("RCurl")
CheckLibrary("rvest")
CheckLibrary("curl")
CheckLibrary("methods")

#Map
CheckLibrary("ggplot2")
CheckLibrary("sp")
CheckLibrary("rgdal")
CheckLibrary("maps")
CheckLibrary("maptools")
CheckLibrary("RColorBrewer")
# CheckLibrary("rgeos")
CheckLibrary("mapproj")
# CheckLibrary("geoR")
CheckLibrary("raster")