# The regular assignment arrow, <-, always creates a variable in the
# current environment. The deep assignment arrow, <<-, never creates
# a variables in the current environment, but instead modifies an 
# existing variable found by walking up the parent environments. You
# can also do deep binding with assign(): name <<- value is equivalent 
# to assign('name', value, inherits = TRUE) -Advanced R By Hadley Wickham      

#'cacheSolve' computes the inverse of the special "matrix" returned
# by 'makeCacheMatrix'. If the inverse has already been calculated
# (and the matrix has not changed), then the `cachesolve` retrieves 
# the inverse from the cache.


makeCacheMatrix <- function(x = numeric()) {
    s <- NULL
    set <- function(y) {
        x <<- y             # equivalent to: assign('x', y, inherits = TRUE)
        s <<- NULL          # equivalent to: assign('s', NULL, inherits = TRUE)
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
    if(!is.null(s)) {                     # If the inverse was cached
        message("getting cached data")    # print message
        return(s)                         # exit the program without compute 
                                          # the inverse again
    }
    
    data <- x$get()               # otherwise, put the matrix supplied in data
        
    if (dim(data)[1] != dim(data)[2]){  # control that the  matrix supplied 
        stop("no invertible matrix")    # is a invertible matrix. 
        }                               # stop funtions is not so. 
    if(det(data)== 0){
        stop("no invertible matrix")                   
        }else{
        s <- solve(data, ...)           # cumpute the inverse
        x$setinv(s)                     # call funtion to cache the inverse
        s                               # return the inverse.
    }
}

# Example

a <- makeCacheMatrix() 
attributes(a)
class(a)
a$set(matrix(c(2,1,-2,1,1,-2,-1,0,1),3,3,byrow=TRUE)) 
cachesolve(a)                                         
 
a$set(matrix(c(1,1,1,-1,0,-1,0,2,1),3,3))             
A = a$get()                                           

                    # As the matrix supplied has changed,
cachesolve(a)       # cachesolve function doesn't retrieves the inverse from 
                    # the cache.


                    # As the matrix supplied has not changed, the inverse
B = cachesolve(a)   # has already been calculated and  cachesolve function
                    # retrieves the inverse from the cache and the assign to B.


A%*%B                # compute the identity matrix


a$set(matrix(1:16,4,4))     # determinat must be != zero
cachesolve(a)

a$set(matrix(1:15,5,3))     # must be a square matrix
cachesolve(a)
