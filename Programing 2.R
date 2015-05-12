# Agregar 

makeVector <- function(x = numeric()) {
  m <- NULL
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  get <- function() x
  setmean <- function(mean) m <<- mean
  getmean <- function() m
  list(set = set, get = get,
       setmean = setmean,
       getmean = getmean)
}

# The following function calculates the mean of the special "vector" created with 
# the above function. However, it first checks to see if the mean has already been 
# calculated. If so, it gets the mean from the cache and skips the computation.
# Otherwise, it calculates the mean of the data and sets the value of the mean 
# in the cache via the setmean function.

cachemean <- function(x, ...) {
  m <- x$getmean()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- mean(data, ...)
  x$setmean(m)
  m
}

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

# The following function calculates the mean of the special "vector" created with 
# the above function. However, it first checks to see if the mean has already been 
# calculated. If so, it gets the mean from the cache and skips the computation.
# Otherwise, it calculates the mean of the data and sets the value of the mean 
# in the cache via the setmean function.

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

a <- makeCacheMatrix()
a$set(matrix(c(2,1,-2,1,1,-2,-1,0,1),3,3,byrow=TRUE))
cachesolve(a)

a$set(matrix(c(1,1,1,-1,0,-1,0,2,1),3,3))
A = a$get()
cachesolve(a)
B = cachesolve(a)
cachesolve(a)
A%*%B

a$set(matrix(1:16,4,4))
cachesolve(a)
cachesolve(a)





