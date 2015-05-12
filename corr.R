corr <- function(directory, threshold = 0) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0
    
    ## Return a numeric vector of correlations
    ## NOTE: Do not round the result!
    
    source("complete.R")
    n <- complete("specdata")
    monitors <- n$id[n$nobs > threshold]
    files_list <- list.files(directory,full.names=TRUE)
    dat <- data.frame()    #creates an empty data frame
    cr <- integer()        #creates an empty vector
    for (i in monitors) {                                
        dat <- read.csv(files_list[i])
        dat <- dat[complete.cases(dat), ]
        cr <- c(cr , cor(dat$sulfate,dat$nitrate))
    }
    cr
    }
