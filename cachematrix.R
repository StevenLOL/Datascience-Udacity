## This R function is able to cache potentially time-consuming inverse matrix computations

## The first function, `makeCacheMatrix` creates a special "vector", which is really a list containing a function to 
## 1. set the value of the matrix
## 2. get the value of the matrix
## 3. set the value of the inverse matrix
## 4. get the value of the inverse matrix

makeCacheMatrix <- function( x = matrix() ) {
        
        # initialize value of inverse matrix
        inversematrix = NULL
        
        # set value of matrix from user input y
        set <- function( y, ... ) {
                
                # sets to global x value of matrix input y 
                x <<- y
                
                # clears inversematrix value if it exists
                inversematrix <<- NULL
        }
        
        # get value of matrix if it has been set
        get <- function() x
        
        # set value of the inverse of matrix
        setinverse <- function(solve) inversematrix <<- solve
        
        # get value of the inversematrix
        getinverse <- function() inversematrix

        list( set = set, 
              get = get, 
              setinverse = setinverse, 
              getinverse = getinverse)
        
}


## The following function calculates the mean of the special "matrix" created with the above function. 
## However, it first checks to see if the mean has already been calculated. 
## If so, it `get`s the mean from the cache and skips the computation. 
## Otherwise, it calculates the mean of the data and sets the value of the mean in the cache via the `setmean` function.

cacheSolve <- function( x, ... ) {
        
        #get value of inverse
        inversematrix <- x$getinverse()
        
        #check to see if inverse is already computed
        if( !is.null( inversematrix ) ) {
                message("getting cached data")
                
                #if inverse is cached, get the cached value and return
                return( inversematrix )
                
        }
        
        #otherwise calculates inverse of data
        invertiblematrix <- x$get()
        inversematrix <- solve(invertiblematrix, ...)
        
        #set mean to cached value
        x$setinverse(inversematrix)
        
        ## Return a matrix that is the inverse of 'x'
        inversematrix
}
