best <- function(
        state, 
        outcome) {
        
        #check for invalid outcome and return error if not valid outcome
        validoutcomes <- c( "heart attack", "heart failure", "pneumonia" )
        if( identical( character(0), validoutcomes[ validoutcomes == outcome ] ) ) stop( "Invalid Outcome" )
        
        #initialize variables for use in data frames
        if( outcome == "heart attack" ) { outcome <- "heartAttack" }
        if( outcome == "heart failure" ) { outcome <- "heartFailure" }
        
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
                
        ## Return hospital name in that state with lowest 30-day death rate
        x <- outcomedata[ with( outcomedata, order( outcomedata[,outcome], outcomedata[,"State"] )), ]
        
        return ( x[ 1,1 ] )
        
}


#best("TX", "heart attack") #[1] "CYPRESS FAIRBANKS MEDICAL CENTER"
#best("TX", "heart failure") # [1] "FORT DUNCAN MEDICAL CENTER" ##[1] "PECOS COUNTY MEMORIAL HOSPITAL"?
#best("MD", "heart attack") #[1] "JOHNS HOPKINS HOSPITAL, THE"
#best("MD", "pneumonia") # [1] "GREATER BALTIMORE MEDICAL CENTER" ## [1] "CALVERT MEMORIAL HOSPITAL"?
#best("BB", "heart attack") # Error in best("BB", "heart attack") : invalid state
#best("NY", "hert attack") # Error in best("NY", "hert attack") : invalid outcome
