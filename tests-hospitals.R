
outcomedatapath <- "~/Downloads/hospitalcomparedata/rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv"
outcomedata <- read.csv( outcomedatapath, colClasses = "character" )

colnames( outcomedata )
states <- unique( outcomedata[ ,7 ] )

outcomedata[, 17] <- as.numeric(outcomedata[, 17])
hist(outcomedata[, 17])

unique( outcomedata$State )



with(
        outcomedata,
        list( 
                summary( as.numeric( outcomedata[,11] ) ),
                summary( as.numeric( outcomedata[,17] ) ),
                summary( as.numeric( outcomedata[,23] ) )
                )
        )

with(
        outcomedata,
        list( 
                as.numeric( min( outcomedata[,11], na.rm = TRUE ) ) )
        )


daf<-outcomedata[,c(2,7,11,17,23)]
head(outcomedata[,c(2,7,11,17,23)])
by(daf, daf[,1],summary)

