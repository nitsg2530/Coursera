
pollutantmean<-function(directory, pollutant, id=1:332){
  
  filenames <- list(sprintf("%s//%03d.csV",directory, id))
  tbl <- sapply(unlist(filenames, use.names=FALSE), fread, simplify=FALSE) 
  DT_merged <- na.omit(tbl[[1]], cols=pollutant)
  
  for(i in 1:length(tbl)){
    if(i > 1){
      DT_merged <- data.table::rbindlist(list(DT_merged,  na.omit(tbl[[i]], cols=pollutant)))
    }
  }
  
  colMeans(DT_merged[,pollutant,with=FALSE])
  ## DT_merged[ , `:=`( COUNT = .N , IDX = 1:.N ) , by = ID ]
  
  
  
}

