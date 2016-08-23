#setwd("~/Downloads/pollutionmonitordata/")
complete <- function(
        directory = "specdata", 
        id = 1:332 ) {
        
        #initialize variable to store complete cases
        nobs <- c()
        
        #initialize file directory and initialize UNIX pathname to all files
        root <- "~/Downloads/pollutionmonitordata/"
        directory <- paste( root, directory, "/", sep="" )
        setwd( directory )
        filenames <- as.character( list.files() )
        filepaths <- paste( directory, filenames, sep="" )
        
        #iterate on filepaths using id and store values of pollutant columns
        for(i in id) {
                loadfile <- read.csv( filepaths[i] )
                sulfate <- loadfile$sulfate
                nitrate <- loadfile$nitrate
                valid <- sum( complete.cases( sulfate, nitrate ) )
                nobs <- c(nobs, valid)
        }
        
        #construct the table of complete cases
        cases <- c()
        cases <- cbind(  
                id, 
                nobs 
        )
        
        return( as.data.frame( cases ) )
        
}


complete("specdata", 1)
##   id nobs
## 1  1  117

complete("specdata", c(2, 4, 8, 10, 12))
##   id nobs
## 1  2 1041
## 2  4  474
## 3  8  192
## 4 10  148
## 5 12   96

complete("specdata", 30:25)
##   id nobs
## 1 30  932
## 2 29  711
## 3 28  475
## 4 27  338
## 5 26  586
## 6 25  463

complete("specdata", 3)
##   id nobs
## 1  3  243

