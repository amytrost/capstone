#### Creating data frames from json ####
#### files for jeannette objects

# Installing libraries, including jsonlite install.packages("jsonlite")
library (jsonlite)

# setting working directory
setwd("~/Desktop/jeannette-output")

# list of all objects in the DB
objects <- c("annotations", "assets", "entities", "ships",
                      "transcriptions","voyages")

object_all <- list() # initialize variable to hold data


# Pulling contents of  files into r data frames
# looping through each mongo document aggregation
for (i in 1:6){
  
  # establishing file names 
  # for source data (eg, annotations_combo.json)
  f_name <- paste(objects[i],"_combo.json",sep="")
  
  # reading source file content into a list variable
  object_all[i] <- (fromJSON(paste("[",paste(readLines(
    f_name), collapse=","),"]"),flatten=TRUE))
  
  # displaing info
  View(object_all[i],objects[i])
  
  # creating a better name for the variable for later use
  # object_all[i] is a list of data frames
  assign(paste(objects[i], "_all", sep=""),object_all[i])

}
