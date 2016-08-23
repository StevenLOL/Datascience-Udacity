#setwd("~/Downloads/pollutionmonitordata/")
corr <- function (
        directory = "specdata",
        threshold = 1 ) {
        
        #function that returns number of complete observations in file
        source("~/Downloads/pollutionmonitordata/complete.R")
        
        #initialize file directory and initialize UNIX pathname to all files
        root <- "~/Downloads/pollutionmonitordata/"
        directory <- paste( root, directory, "/", sep="" )
        setwd( directory )
        filenames <- as.character( list.files() )
        filepaths <- paste( directory, filenames, sep="" )
        
        #initialize complete cases
        filecount <- length( list.files() )
        cases <- complete("specdata", id = 1:filecount)
        
        #initialize cases that meet threshold minimum and set column names
        valid <- cases[ ,2 ] >= threshold
        validcases <- cbind(
                valid1 <- cases[ ,1 ][ valid ],
                valid2 <- cases[ ,2 ][ valid ]
        )
        colnames( validcases ) <- c("id", "nobs")
        
        #initialize new UNIX pathnames using only valid cases
        filenames <- filenames[ validcases[ ,1 ] ]
        filepaths <- paste( directory, filenames, sep="" )
        
        #if no files meet threshold return empty vector
        if( length( filenames ) == 0 ) {
                corrs = c()
                return( corrs )
        }
        
        #initialize vector to store correlations for each file
        corrs <- c()
        
        #loop through UNIX pathnames and store values in corrs
        for( i in seq( filepaths ) ) {
                loadfile <- read.csv( filepaths[ i ] )
                
                #read the sulfate and nitrate values for open file
                sulfate <- loadfile$sulfate
                nitrate <- loadfile$nitrate
                
                #calculate correlation using only complete cases of sulfate, nitrate
                corrs <- c( corrs, cor( 
                                    sulfate[ complete.cases( sulfate, nitrate ) ],
                                    nitrate[ complete.cases( sulfate, nitrate ) ] 
                                        )
                            )
        }
        
        return( corrs )
}



setwd("~/Downloads/pollutionmonitordata/")
source("complete.R")
cr <- corr("specdata", 150)
head(cr)
## [1] -0.01896 -0.14051 -0.04390 -0.06816 -0.12351 -0.07589

summary(cr)
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## -0.2110 -0.0500  0.0946  0.1250  0.2680  0.7630

cr <- corr("specdata", 400)
head(cr)
## [1] -0.01896 -0.04390 -0.06816 -0.07589  0.76313 -0.15783

summary(cr)
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## -0.1760 -0.0311  0.1000  0.1400  0.2680  0.7630

cr <- corr("specdata", 5000)
summary(cr)
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## 

length(cr)
## [1] 0

cr <- corr("specdata")
summary(cr)
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## -1.0000 -0.0528  0.1070  0.1370  0.2780  1.0000

length(cr)
## [1] 323
