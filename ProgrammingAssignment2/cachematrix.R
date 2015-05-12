#`cacheSolve`computes the inverse of the special "matrix" returned
# by `makeCacheMatrix`. If the inverse has already been calculated
# (and the matrix has not changed), then the `cachesolve` retrieves 
# the inverse from the cache.

makeCacheMatrix <- function(x = numeric()) {
    m <- NULL
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    get <- function() x
    setinv <- function(solve) m <<- solve
    getinv <- function() m
    list(set = set, get = get,
         setinv = setinv,
         getinv = getinv)
}

cachesolve <- function(x, ...) {
    m <- x$getinv()
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    data <- x$get()
    if(det(data)== 0) {
        message("no invertible matrix")
    }else{
        m <- solve(data, ...)
        x$setinv(m)
        m
    }
}
