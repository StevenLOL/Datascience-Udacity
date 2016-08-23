#setwd("~/Downloads/pollutionmonitordata/")
pollutantmean <- function (
        directory = "specdata", 
        pollutant = "sulfate", 
        id = 1:332 ) {
        
        #initialize variable to hold data from pollutant column
        filemeans <- c()
        
        #initialize file directory and initialize UNIX pathname to all files
        root <- "~/Downloads/pollutionmonitordata/"
        directory <- paste( root, directory, "/", sep="" )
        setwd( directory )
        filenames <- as.character( list.files() )
        filepaths <- paste( directory, filenames, sep="" )
        
        #iterate on filepaths using id and store values of pollutant column in filemeans
        for( i in id ) {
                loadfile <- read.csv( filepaths[ i ] )
                result <- loadfile[ ,pollutant ]
                valid <- result[ !is.na( result ) ]
                filemeans <- c( filemeans, valid )
        }
        
        #returns mean of columns
        return( mean( filemeans ) )
        
}

pollutantmean("specdata", "sulfate", 1:10)
## [1] 4.064
pollutantmean("specdata", "nitrate", 70:72)
## [1] 1.706
pollutantmean("specdata", "nitrate", 23)
## [1] 1.281

