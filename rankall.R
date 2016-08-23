rankall <- function(
        outcome, 
        num = "best") {
        
        # Need plyr library for ddply functions
        library("plyr", lib.loc="/usr/local/Cellar/r/3.0.3/R.framework/Versions/3.0/Resources/library")
        
        ## Check that outcome is valid
        validoutcomes <- c( "heart attack", "heart failure", "pneumonia" )
        if( identical( character( 0 ), validoutcomes[ validoutcomes == outcome ] ) ) stop( "Invalid Outcome" )
        
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
        names( outcomedata ) <- c( "hospital", "state", "heartAttack", "heartFailure", "pneumonia" )
        options( warn = -1 )
        class( outcomedata$heartAttack ) <- "numeric"
        class( outcomedata$heartFailure ) <- "numeric"
        class( outcomedata$pneumonia ) <- "numeric"
        options( warn = 0 )
        
        #Orders by state and then by outcome and then by hospital name, keeping NA values in tact
        outcomedata <- outcomedata[ with( outcomedata, order( outcomedata[ ,"state" ], outcomedata[,outcome], outcomedata[ ,"hospital" ], na.last=TRUE )), ]

        ## Consider the cases where outcome is best and worst and return if case is best or worst
        if ( num == "best" ) {
        z <- ddply(outcomedata, "state", function( x ) x[ which.min( x[ ,outcome ] ) , ] )
        return ( z[ , c( 1, 2 ) ] )
        }
        
        if ( num == "worst" ) {
        z <- ddply(outcomedata, "state", function( x ) x[ which.max( x[ ,outcome ] ) , ] )
        return ( z[ , c( 1, 2 ) ] )
        }
                
        #adds a ranking column to data in order of the specified outcome ranking across all observations
        outcomedata <- transform( outcomedata, ranking = rank( outcomedata[ ,outcome ], ties.method = "first" ) )
        
        #changes rankings to be rankings by state
        outcomedata <- ddply( outcomedata, "state", function( x ) transform( x, ranking = rank( x$ranking, ties.method = "first" ) ) )
        
        #matches ranking to num
        num = as.numeric( num )
        x <- split( outcomedata, outcomedata$state )
        result <- c()
        for ( i in seq( x ) ) {
                y <- if( max( x[[ i ]]$ranking ) > num ) {
                        result <- c( result, x[[ i ]]$hospital[ num ], x[[ i ]]$state[ num ] )
                } else {
                        result <- c( result, NA, x[[ i ]]$state[ 1 ] )
                }           
        }
        
        result <- matrix( result, ncol = 2, byrow = TRUE )
        result <- data.frame( result )
        names( result ) <- c( "hospital", "state" )
        return( result )
}

#source("rankall.R")
head( rankall("heart attack", 20), 10 )
## hospital state
## AK <NA> AK
## AL D W MCMILLAN MEMORIAL HOSPITAL AL
## AR ARKANSAS METHODIST MEDICAL CENTER AR
## AZ JOHN C LINCOLN DEER VALLEY HOSPITAL AZ
## CA SHERMAN OAKS HOSPITAL CA
## CO SKY RIDGE MEDICAL CENTER CO
## CT MIDSTATE MEDICAL CENTER CT
## DC <NA> DC
## DE <NA> DE
## FL SOUTH FLORIDA BAPTIST HOSPITAL FL

tail(rankall("pneumonia", "worst"), 3)
## hospital state
## WI MAYO CLINIC HEALTH SYSTEM - NORTHLAND, INC WI
## WV PLATEAU MEDICAL CENTER WV
## WY NORTH BIG HORN HOSPITAL DISTRICT WY

tail(rankall("heart failure"), 10)
## hospital state
## TN WELLMONT HAWKINS COUNTY MEMORIAL HOSPITAL TN
## TX FORT DUNCAN MEDICAL CENTER TX
## UT VA SALT LAKE CITY HEALTHCARE - GEORGE E. WAHLEN VA MEDICAL CENTER UT
## VA SENTARA POTOMAC HOSPITAL VA
## VI GOV JUAN F LUIS HOSPITAL & MEDICAL CTR VI
## VT SPRINGFIELD HOSPITAL VT
## WA HARBORVIEW MEDICAL CENTER WA
## WI AURORA ST LUKES MEDICAL CENTER WI
## WV FAIRMONT GENERAL HOSPITAL WV
## WY CHEYENNE VA MEDICAL CENTER WY