## The first of the following two functions are used to cache a (square) matrix
## and it's inverse and retrieve it as needed. 

## The makeCacheMatrix function generates a list with the set, get, setInverse
## and getInverse functions needed

makeCacheMatrix <- function(x = matrix()) {
    m <- NULL
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    get <- function() x
    setinverse <- function(solve) m <<- solve
    getinverse <- function() m
    list(set = set, get = get,
         setinverse = setinverse,
         getinverse = getinverse)
    
}


## The cacheSolve function returns the inverse of a matrix. This matrix has to 
## be first stored in a list with function "makeCacheMatrix" above. In that case,
## cacheSolve will first check if the inverse was already computed and is stored
## in cache. If it is not, it will compute cache. In both cases the inverse will
## be returned.

cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    m <- x$getinverse()
    if(!is.null(m)){
        return(m)
    }
    data <- x$get()    
    m <- solve(data,...)
    x$setinverse(m)
    m
}
