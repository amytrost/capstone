#### Extracting jeannette data into single ####
#### json files for each object ####

# Installing Library
library(rjson) 

# Set Working Directory
setwd("~/Desktop/jeannette-output")

# list of all objects classes in the DB
objects <- c("annotations", "assets", "entities", "ships",
                      "transcriptions","voyages")

# create a large file for each object class with rjson

for(i in 1:6){  # for each directory

  # making path where all the json files live  
  parent_path <- paste("./", objects[i], sep="")

  # listing files
  file_paths <- paste(parent_path,"/",
            list.files(parent_path), sep="")

  # combining file contents in jsonc variable
  jsonl <- lapply(file_paths, function(f) fromJSON(file = f))
  jsonc <- toJSON(jsonl)

  # write to file
  write(jsonc, file = paste(objects[i],"_combo.json",sep=""))
}


