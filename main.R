# Load packages
library(raster)

# Working directory
#setwd("")

# Load function
source("classify.R")    # Iterative LouBar method (https://www.nature.com/articles/srep05276)
source("phi.R")         # Similarity metric Phi (https://www.nature.com/articles/s41467-019-12809-y)

# List of species
files=list.files("Input_rasters")
species=substr(files, 1, nchar(files)-4)

# Load rasters
# Outputs from Pinchpoint mapper are reclassified such as: 
#   - patches = 5
#   - circuitscape values = between 0 and 1
#   - outside study area = NA
#   - outside the calculation area of Pinchpoint mapper = 4

r=list()
nr=length(species)  # Number of rasters
for(i in 1:nr){
  r[[i]]=raster(paste0("Input_rasters/",species[i],".tif"))
}

# Extract the matrix
mat=list()
for(i in 1:nr){
  mat[[i]]=as.matrix(r[[i]])       # Extract matrix from raster
  mat[[i]][is.na(mat[[i]])]=-100   # Replace NA by -100 
}

# Identify and extract the values to discretize (between 0 and 1)
ind=list()
val=list()
for(i in 1:nr){
   ind[[i]]=(mat[[i]]>=0 & mat[[i]]<1)     # Identify values to discretize
   val[[i]]=as.numeric(mat[[i]][ind[[i]]])   # Extract values to discretize
}

# Classify in 5 levels (when possible) using the Loubar method iteratively (refs in README.md)
for(i in 1:nr){
   
   # Apply the level detection method implemented in classify.R with a maximum of 5 levels
   h=hthot(val[[i]],maxh=5)   

   # Discretize with cut to obtain 6 levels (5 levels + the rest)
   valc=as.numeric(as.character(cut(val[[i]],breaks=c(min(val[[i]])-1,rev(h),max(val[[i]])+1),labels=(length(h)+1):1))) 

   # Hotspots have negative integers because 4 and 5 are already taken (outputs from Pinchpoint mapper)
   val[[i]]=-valc
 
}

# Update the matrices and the rasters
for(i in 1:nr){
   mat[[i]][ind[[i]]]=val[[i]]
   mat[[i]][mat[[i]]==-100]=NA  # Replace -100 by NA 
   r[[i]]=setValues(r[[i]],mat[[i]])
   #plot(r[[i]])
}


# Reclassifiy rasters such as:
#   - patches= 0
#   - connectivity level 1= 1
#   - connectivity level 2= 2
#   - connectivity level 3= 3
#   - connectivity level 4= 4
#   - connectivity level 5= 5
#   - no connectivity= 6
#   - Outside area of calculation= 7

m <- c(5,0, 4,7, -1, 1, -2,2, -3,3, -4,4, -5,5, -6,6)
rclmat <- matrix(m, ncol=2, byrow=TRUE)
for(i in 1:nr){
   r[[i]] <- reclassify(r[[i]], rclmat)
}


# Export the outputs rasters
for(i in 1:nr){
  writeRaster(r[[i]],paste0("Output_rasters/connectivity_",species[i],".tif"))
}


# Calculation of the similarity metric between maps (Figure 2 of the paper)
matphi=matrix(-1,nr,nr)
rownames(matphi)=species
colnames(matphi)=species

for(i in 1:(nr-1)){  # Loop over the rasters

   print(i)

   for(j in i:nr){  # Loop over the rasters

       # First raster   
       ri=raster(paste0("Output_rasters/connectivity_",species[i],".tif"))
       ri[ri==7]=6
       mati=as.matrix(ri)

       # Second raster   
       rj=raster(paste0("Output_rasters/connectivity_",species[j],".tif"))
       rj[rj==7]=6  
       matj=as.matrix(rj)

       # Update the (symetric) similarity matrix with (i,j) and (j,i) values
       matphi[i,j]=phi(table(mati,matj))
       matphi[j,i]=matphi[i,j]
  
   }
}

matphi







