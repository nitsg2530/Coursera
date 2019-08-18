
##To create a special object that stores a matrix and caches its inverse.
makeCacheMatrix <- function(x = matrix()) {
 if(dim(x)[1]==dim(x)[2])
 {
   m <- NULL
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  get <- function() x
  setsolve <- function(solve) m <<- solve
  getsolve <- function() m
  list(set = set, get = get,
       setsolve = setsolve,
       getsolve = getsolve)
 }
  else
  {
    message("Supplied Matrix is not inversible, please provide square matrix")
  }
}

##This function computes the inverse of the special "matrix" returned by makeCacheMatrix
cacheSolve <- function(x, ...) {
  m <- x$getsolve()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- solve(data, ...)
  x$setsolve(m)
  m
}