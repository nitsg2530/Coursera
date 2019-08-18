complete_ORG<-function(directory, id=1:332){
  filenames <- list(sprintf("%s//%03d.csV",directory, id))
  tbl <- sapply(unlist(filenames, use.names=FALSE), fread, simplify=FALSE) 
  
  DT_merged <- na.omit(tbl[[1]], cols=c("nitrate","sulfate"))
  
  for(i in 1:length(tbl)){
    if(i > 1){
      DT_merged <- data.table::rbindlist(list(DT_merged,  na.omit(tbl[[i]], cols=c("nitrate","sulfate"))))
    }
  }
  
  ## colMeans(DT_merged[,pollutant,with=FALSE])
  counts <- DT_merged[, .(nobs = .N), by = ID]
  counts
}
complete <- function(directory, id = 1:332) {
  nobs <- c()
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  for(monitor_id in id) {
    path <- sprintf("%s/%03d.csv", directory, monitor_id)
    
    df <- read.csv(path, header = TRUE, comment.char = "")
    nobs <- c(nobs, sum(complete.cases(df)))
  }
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  data.frame(id, nobs)
}