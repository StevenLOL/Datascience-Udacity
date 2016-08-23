rankhospital <- function(
        state = "", 
        outcome = "", 
        num = "best") {
        
        #state = "TX"
        #outcome = "heart failure"
        #num = "4"
        
        #check for invalid outcome and return error if not valid outcome
        validoutcomes <- c( "heart attack", "heart failure", "pneumonia" )
        if( identical( character(0), validoutcomes[ validoutcomes == outcome ] ) ) stop( "Invalid Outcome" )
        
        #initialize variables for use in data frames
        if(outcome == "heart attack") { outcome <- "heartAttack" }
        if(outcome == "heart failure") { outcome <- "heartFailure" }
        
        #initialize data directories
        root <- "~/Downloads/hospitalcomparedata/"
        folder <- "rprog-data-ProgAssignment3-data"
        directory <- paste( root, folder, "/", sep="" )
        setwd( directory )
        filenames <- as.character( list.files() )
        filepaths <- paste( directory, filenames, sep="" )
        hospitaldatapath <- filepaths[ 1 ]
        outcomedatapath <- filepaths[ 2 ]
        
        ## Read outcome data and initialize smaller subset to work with
        outcomedata <- read.csv( outcomedatapath, colClasses = "character", as.is = TRUE )
        outcomedata <- outcomedata[ , c( 2,7,11,17,23 ) ]
        names( outcomedata ) <- c( "hospitalName", "State", "heartAttack", "heartFailure", "pneumonia" )
        options(warn=-1)
        class( outcomedata$heartAttack ) <- "numeric"
        class( outcomedata$heartFailure ) <- "numeric"
        class( outcomedata$pneumonia ) <- "numeric"
        options(warn=0)
        
        ## Check that state is valid
        validstates <- unique( outcomedata$State )
        if( identical( character( 0 ), validstates[ validstates == state ] ) ) stop( "Invalid State" )
        
        ## Recreate the data frame using state and outcome
        outcomedata <- outcomedata[ outcomedata$State == state, ]
        
        ## Sort outcomedata by outcome and state name
        
        if( num == "worst" ) { 
                outcomedata <- outcomedata[ with( outcomedata, order( -outcomedata[,outcome], outcomedata[,"hospitalName"], na.last=NA )), ]
                outcomedata <- transform( outcomedata, ranking = rank(outcomedata[,outcome], ties.method = "first") )
                return( outcomedata[ 1,1 ] )
        }
        
        if( num == "best" ) { 
                outcomedata <- outcomedata[ with( outcomedata, order( outcomedata[,outcome], outcomedata[,"hospitalName"], na.last=NA )), ]
                outcomedata <- transform( outcomedata, ranking = rank(outcomedata[,outcome], ties.method = "first") )
                return( outcomedata[ 1,1 ] )
        }
        
        outcomedata <- outcomedata[ with( outcomedata, order( outcomedata[,outcome], outcomedata[,"hospitalName"], na.last=NA )), ]
        outcomedata <- transform( outcomedata, ranking = rank(outcomedata[,outcome], ties.method = "first") )
        outcomedata <- outcomedata[ outcomedata$ranking == num, ]
        return( outcomedata[ 1,1 ] )

}

#source("rankhospital.R")
#rankhospital("TX", "heart failure", 4)
# [1] "DETAR HOSPITAL NAVARRO"
#rankhospital("MD", "heart attack", "worst")
# [1] "HARFORD MEMORIAL HOSPITAL"
#rankhospital("MN", "heart attack", 5000)
# [1] NA