

Below are the solutions to <a href="http://r-exercises.com/2017/12/27/exercises-with-raster-data-parts-1-2/">these</a> 
  exercises on raster data analysis (parts 1-2).


<!--begin.rcode, echo=TRUE, eval=TRUE, message=FALSE
####################
#                  #
#    Exercise 1    #
#                  #
####################

library(raster)

## Create a folder named data-raw inside the working directory to place downloaded data
if(!dir.exists("./data-raw")) dir.create("./data-raw")

## If you run into download problems try changing: method = "wget"
download.file("https://raw.githubusercontent.com/joaofgoncalves/R_exercises_raster_tutorial/master/data/srtm_pnpg.zip", 
              "./data-raw/srtm_pnpg.zip", method = "auto")

## Uncompress the zip file
unzip("./data-raw/srtm_pnpg.zip", exdir = "./data-raw")

rst <- raster("./data-raw/srtm_pnpg.tif")

# Number of rows, columns and layers
dim(rst)

# Number of rows
nrow(rst)
# Number of columns
ncol(rst)
# Number of layers
nlayers(rst)
# Number of cells
ncell(rst)

####################
#                  #
#    Exercise 2    #
#                  #
####################

# Spatial resolution (pixel size in x and y dimensions)
res(rst)

# Coordinate reference system: Datum/Ellipsoid: WGS 1984, Projection: UTM 29N, Units: meters
crs(rst)

####################
#                  #
#    Exercise 3    #
#                  #
####################

# The extent object
extent(rst)

# Lenght in meters
xmax(rst) - xmin(rst)

# Height in meters
ymax(rst) - ymin(rst)

####################
#                  #
#    Exercise 4    #
#                  #
####################

# Mean
cellStats(rst, mean)

# Standard-deviation
cellStats(rst, sd)

####################
#                  #
#    Exercise 5    #
#                  #
####################

# Raster quantiles
cellStats(rst, stat = function(x, ...) quantile(x, probs = c(0.01, 0.25, 0.5, 0.75, 0.99), ...))

####################
#                  #
#    Exercise 6    #
#                  #
####################

# Get values for the raster (memory may be an issue)
x <- values(rst)

# Make the plot (notice higher deviations for values above the average)
qqnorm(x)
qqline(x)

####################
#                  #
#    Exercise 7    #
#                  #
####################

set.seed(12345)

# Generate random points with uniform distribution bounded by the raster extent
xyRandPoints <- data.frame(x = runif(100, xmin(rst), xmax(rst)), y = runif(100, ymin(rst), ymax(rst)))

# Convert the initial data frame into a SpatialPoints objects for clarity
xyRandPoints <- SpatialPoints(xyRandPoints, proj4string = crs(rst))

# Extract values
xyVals <- extract(rst, xyRandPoints)

print(xyVals)

####################
#                  #
#    Exercise 8    #
#                  #
####################

rstFt <- rst / 0.3048

rstStack <- stack(rst, rstFt)

print(rstStack)

####################
#                  #
#    Exercise 9    #
#                  #
####################

# Bounding coordinates
xmin <- 554615
xmax <- 589015 
ymin <- 4618355 
ymax <- 4654705

# Create the extent object by defining the bounding coordinates
newExtent <- extent(xmin, xmax, ymin, ymax)

# Crop
cropRst <- crop(rst, newExtent)

print(cropRst)

####################
#                  #
#    Exercise 10   #
#                  #
####################

# Target CRS
targetCRS <- CRS("+init=epsg:3035")

# Reproject data
rst_ETRS89_LAEA <- projectRaster(rst, crs = targetCRS, res = 100, method = 'bilinear')

print(rst_ETRS89_LAEA)

end.rcode-->
