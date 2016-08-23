makeVector <- function( x = numeric() ) {
        
        # initialize value of mean, m is mean
        m <- NULL
        
        # set value of vector from user input y
        set <- function( y ) {
                
                # takes vector input y sets to global x
                x <<- y
                
                # clears mean value if it exists
                m <<- NULL
        }
        
        # get value of vector if it has been set
        get <- function() x
        
        # set value of mean
        setmean <- function(mean) m <<- mean
        
        # get value of mean
        getmean <- function() m
        
        list( set = set, get = get, setmean = setmean, getmean = getmean)
        
}