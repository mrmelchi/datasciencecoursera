# The regular assignment arrow, <-, always creates a variable in the
# current environment. The deep assignment arrow, <<-, never creates
# a variables in the current environment, but instead modifies an 
# existing variable found by walking up the parent environments. You
# can also do deep binding with assign(): name <- value is equivalent 
# to assign('name', value, inherits = TRUE) -Advanced R By Hadley Wickham

#'cacheSolve' computes the inverse of the special "matrix" returned
# by 'makeCacheMatrix'. If the inverse has already been calculated
# (and the matrix has not changed), then the `cachesolve` retrieves 
# the inverse from the cache.


makeCacheMatrix <- function(x = numeric()) {
    s <- NULL
    set <- function(y) {
        x <<- y                 # equivalent to: assign('x', y, inherits = TRUE)
        s <<- NULL              # equivalent to: assign('s', NULL, inherits = TRUE)
    }
    get <- function() x
    
    # next line is equivalent to : setinv <- function(solve) s <<- solve 
    setinv <- function(solve) assign('s', solve, inherits = TRUE)
   
    getinv <- function() s
    list(set = set, get = get,         # Return list of functions
         setinv = setinv,
         getinv = getinv)
}

cachesolve <- function(x, ...) {
    s <- x$getinv()                    
    if(!is.null(s)) {                     # If the inverse wa cached
        message("getting cached data")    # print message
        return(s)                         # exit the program without compute the inverse again.
    }
    data <- x$get()                       # otherwise, put the matrix supplied in data
        if(det(data)== 0) {               # control the matrix supplied is invertible
        stop("no invertible matrix")      # stop funtions is not so.
    }else{
        s <- solve(data, ...)             # cumpute the inverse
        x$setinv(s)                       # call funtion to cache the inverse
        s                                 # return the inverse of the matrix supplied
    }
}

# Example

a <- makeCacheMatrix()
a$set(matrix(c(2,1,-2,1,1,-2,-1,0,1),3,3,byrow=TRUE))
cachesolve(a)
#       [,1] [,2] [,3]
# [1,]    1   -1    0
# [2,]    1    0    2
# [3,]    1   -1    1
 
a$set(matrix(c(1,1,1,-1,0,-1,0,2,1),3,3))
A = a$get()
cachesolve(a)
#       [,1] [,2] [,3]
# [1,]    2    1   -2
# [2,]    1    1   -2
# [3,]   -1    0    1

B = cachesolve(a)
# getting cached data

cachesolve(a)
# getting cached data
#       [,1] [,2] [,3]
# [1,]    2    1   -2
# [2,]    1    1   -2
# [3,]   -1    0    1

A%*%B
#       [,1] [,2] [,3]
# [1,]    1    0    0
# [2,]    0    1    0
# [3,]    0    0    1

a$set(matrix(1:16,4,4))
cachesolve(a)
# Error in cachesolve(a) : no invertible matrix
