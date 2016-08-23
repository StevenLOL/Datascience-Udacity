cachemean <- function( x, ... ) {
        
        #get value of mean
        m <- x$getmean()
        
        #check to see if mean is already computed
        if( !is.null( m ) ) {
                message("getting cached data")

                #if mean is cached, get the cached value and return
                return( m )
                
        }

        #otherwise calculates mean of data
        data <- x$get()
        m <- mean(data, ...)
        
        #set mean to cached value
        x$setmean(m)
        
        #output mean
        m
        
}