# This is a graphic representation of R Benchmark 2.5 (06/2008) [Simon Urbanek]
# This code runs Simon's Urbanek code and outputs a visual representation of the 
# efficience in which the code is running with/without OpenBLAS

runs <- 3			# Number of times the tests are executed
times <- rep(0, 15); dim(times) <- c(5,3)
require(Matrix)		# Optimized matrix operations
require(SuppDists)
require(ggplot2)
require(plyr)
require(dplyr)

Rnorm <- rnorm
Runif <- runif
#remove("a", "b")
options(object.size=100000000)

#cat("\n\n   R Benchmark 2.5\n")
#cat("   ===============\n")
#cat(c("Number of times each test is run__________________________: ", runs))



#cat("   I. Matrix calculation\n")
#cat("   ---------------------\n")


# (1)
cumulate_1 <- 0; a <- 0; b <- 0
for (i in 1:runs) {
  invisible(gc())
  timing_1.1 <- system.time({
    a <- matrix(Rnorm(2500*2500)/10, ncol=2500, nrow=2500);
    b <- t(a);
    dim(b) <- c(1250, 5000);
    a <- t(b)
  })[3]
  cumulate_1 <- cumulate_1 + timing_1.1
}
timing_1.1 <- cumulate_1/runs
times[1, 1] <- timing_1.1
#cat(c("Creation, transp., deformation of a 2500x2500 matrix (sec): ", timing, "\n"))
#remove("a", "b")


# (2)
cumulate_1 <- 0; b <- 0
for (i in 1:runs) {
  a <- abs(matrix(Rnorm(2500*2500)/2, ncol=2500, nrow=2500));
  invisible(gc())
  timing_1.2 <- system.time({ 
    b <- a^1000 
  })[3]
  cumulate_1 <- cumulate_1 + timing_1.2
}
timing_1.2 <- cumulate_1/runs
times[2, 1] <- timing_1.2
#cat(c("2400x2400 normal distributed random matrix ^1000____ (sec): ", timing, "\n"))
remove("a", "b")



# (3)
cumulate_1 <- 0; b <- 0
for (i in 1:runs) {
  a <- Rnorm(7000000)
  invisible(gc())
  timing_1.3 <- system.time({
    b <- sort(a, method="quick")	# Sort is modified in v. 1.5.x
    # And there is now a quick method that better competes with other packages!!!
  })[3]
  cumulate_1 <- cumulate_1 + timing_1.3
}
timing_1.3 <- cumulate_1/runs
times[3, 1] <- timing_1.3
#cat(c("Sorting of 7,000,000 random values__________________ (sec): ", timing, "\n"))
remove("a", "b")


# (4)
cumulate_1 <- 0; b <- 0
for (i in 1:runs) {
  a <- Rnorm(2800*2800); dim(a) <- c(2800, 2800)
  invisible(gc())
  timing_1.4 <- system.time({
    b <- crossprod(a)		# equivalent to: b <- t(a) %*% a
  })[3]
  cumulate_1 <- cumulate_1 + timing_1.4
}
timing_1.4 <- cumulate_1/runs
times[4, 1] <- timing_1.4
#cat(c("2800x2800 cross-product matrix (b = a' * a)_________ (sec): ", timing, "\n"))
remove("a", "b")


# (5)
cumulate_1 <- 0; c <- 0; qra <-0
for (i in 1:runs) {
  a <- new("dgeMatrix", x = Rnorm(2000*2000), Dim = as.integer(c(2000,2000)))
  b <- as.double(1:2000)
  invisible(gc())
  timing_1.5 <- system.time({
    c <- solve(crossprod(a), crossprod(a,b))
  })[3]
  cumulate_1 <- cumulate_1 + timing_1.5
  
  # This is the old method
  #a <- Rnorm(600*600); dim(a) <- c(600,600)
  #b <- 1:600
  #invisible(gc())
  #timing <- system.time({
  #  qra <- qr(a, tol = 1e-7);
  #  c <- qr.coef(qra, b)
  #  #Rem: a little faster than c <- lsfit(a, b, inter=F)$coefficients
  #})[3]
  #cumulate <- cumulate + timing
}
timing_1.5 <- cumulate_1/runs
times[5, 1] <- timing_1.5
#cat(c("Linear regr. over a 3000x3000 matrix (c = a \\ b')___ (sec): ", timing, "\n"))
remove("a", "b", "c", "qra")


times[ , 1] <- sort(times[ , 1])

trimed_geom_1 <- exp(mean(log(times[2:4, 1])))
#cat("                      --------------------------------------------\n")
#cat(c("                 Trimmed geom. mean (2 extremes eliminated): ", exp(mean(log(times[2:4, 1]))), "\n\n"))

#cat("   II. Matrix functions\n")
#cat("   --------------------\n")


# (1)
cumulate_2 <- 0; b <- 0
for (i in 1:runs) {
  a <- Rnorm(2400000)
  invisible(gc())
  timing_2.1 <- system.time({
    b <- fft(a)
  })[3]
  cumulate_2 <- cumulate_2 + timing_2.1
}
timing_2.1 <- cumulate_2/runs
times[1, 2] <- timing_2.1
#cat(c("FFT over 2,400,000 random values____________________ (sec): ", timing, "\n"))
remove("a", "b")


# (2)
cumulate_2 <- 0; b <- 0
for (i in 1:runs) {
  a <- array(Rnorm(600*600), dim = c(600, 600))
  # Only needed if using eigen.Matrix(): Matrix.class(a)
  invisible(gc())
  timing_2.2 <- system.time({
    b <- eigen(a, symmetric=FALSE, only.values=TRUE)$Value
    # Rem: on my machine, it is faster than:
    #	 b <- La.eigen(a, symmetric=F, only.values=T, method="dsyevr")$Value
    #	 b <- La.eigen(a, symmetric=F, only.values=T, method="dsyev")$Value
    #  b <- eigen.Matrix(a, vectors = F)$Value
  })[3]
  cumulate_2 <- cumulate_2 + timing_2.2
}
timing_2.1 <- cumulate_2/runs
times[2, 2] <- timing_2.1
#cat(c("Eigenvalues of a 640x640 random matrix______________ (sec): ", timing, "\n"))
remove("a", "b")


# (3)
cumulate_2 <- 0; b <- 0
for (i in 1:runs) {
  a <- Rnorm(2500*2500); dim(a) <- c(2500, 2500)
  #Matrix.class(a)
  invisible(gc())
  timing_2.3 <- system.time({
    #b <- determinant(a, logarithm=F)
    # Rem: the following is slower on my computer!
    # b <- det.default(a)
    b <- det(a)
  })[3]
  cumulate_2 <- cumulate_2 + timing_2.3
}
timing_2.3 <- cumulate_2/runs
times[3, 2] <- timing_2.3
#cat(c("Determinant of a 2500x2500 random matrix____________ (sec): ", timing, "\n"))
remove("a", "b")


# (4)
cumulate_2 <- 0; b <- 0
for (i in 1:runs) {
  a <- crossprod(new("dgeMatrix", x = Rnorm(3000*3000),
                     Dim = as.integer(c(3000, 3000))))
  invisible(gc())
  #a <- Rnorm(900*900); dim(a) <- c(900, 900)
  #a <- crossprod(a, a)
  timing_2.4 <- system.time({
    b <- chol(a)
  })[3]
  cumulate_2 <- cumulate_2 + timing_2.4
}
timing_2.4 <- cumulate_2/runs
times[4, 2] <- timing_2.4
#cat(c("Cholesky decomposition of a 3000x3000 matrix________ (sec): ", timing_2.4, "\n"))
remove("a", "b")


# (5)
cumulate_2 <- 0; b <- 0
for (i in 1:runs) {
  a <- new("dgeMatrix", x = Rnorm(1600*1600), Dim = as.integer(c(1600, 1600)))
  invisible(gc())
  #a <- Rnorm(400*400); dim(a) <- c(400, 400)
  timing_2.5 <- system.time({
    #  b <- qr.solve(a)
    # Rem: a little faster than
    b <- solve(a)
  })[3]
  cumulate_2 <- cumulate_2 + timing_2.5
}
timing_2.5 <- cumulate_2/runs
times[5, 2] <- timing_2.5
#cat(c("Inverse of a 1600x1600 random matrix________________ (sec): ", timing_2.5, "\n"))
remove("a", "b")


times[ , 2] <- sort(times[ , 2])

trimed_geom_2 <- exp(mean(log(times[2:4, 2])))
#cat("                      --------------------------------------------\n")
#cat(c("                Trimmed geom. mean (2 extremes eliminated): ", exp(mean(log(times[2:4, 2]))), "\n\n"))

#cat("   III. Programmation\n")
#cat("   ------------------\n")


# (1)
cumulate_3 <- 0; a <- 0; b <- 0; phi <- 1.6180339887498949
for (i in 1:runs) {
  a <- floor(Runif(3500000)*1000)
  invisible(gc())
  timing_3.1 <- system.time({
    b <- (phi^a - (-phi)^(-a))/sqrt(5)
  })[3]
  cumulate_3 <- cumulate_3 + timing_3.1
}
timing_3.1 <- cumulate_3/runs
times[1, 3] <- timing_3.1
#cat(c("3,500,000 Fibonacci numbers calculation (vector calc)(sec): ", timing_3.1, "\n"))
remove("a", "b", "phi")


# (2)
cumulate_3 <- 0; a <- 3000; b <- 0
for (i in 1:runs) {
  invisible(gc())
  timing_3.2 <- system.time({
    b <- rep(1:a, a); dim(b) <- c(a, a);
    b <- 1 / (t(b) + 0:(a-1))
    # Rem: this is twice as fast as the following code proposed by R programmers
    # a <- 1:a; b <- 1 / outer(a - 1, a, "+")
  })[3]
  cumulate_3 <- cumulate_3 + timing_3.2
}
timing_3.2 <- cumulate_3/runs
times[2, 3] <- timing_3.2
#cat(c("Creation of a 3000x3000 Hilbert matrix (matrix calc) (sec): ", timing_3.2, "\n"))
remove("a", "b")


# (3)
cumulate_3 <- 0; c <- 0
gcd2 <- function(x, y) {if (sum(y > 1.0E-4) == 0) x else {y[y == 0] <- x[y == 0]; Recall(y, x %% y)}}
for (i in 1:runs) {
  a <- ceiling(Runif(400000)*1000)
  b <- ceiling(Runif(400000)*1000)
  invisible(gc())
  timing_3.3 <- system.time({	  
    c <- gcd2(a, b)                            # gcd2 is a recursive function
  })[3]
  cumulate_3 <- cumulate_3 + timing_3.3
}
timing_3.3 <- cumulate_3/runs
times[3, 3] <- timing_3.3
#cat(c("Grand common divisors of 400,000 pairs (recursion)__ (sec): ", timing_3.3, "\n"))
remove("a", "b", "c", "gcd2")


# (4)
cumulate_3 <- 0; b <- 0
for (i in 1:runs) {
  b <- rep(0, 500*500); dim(b) <- c(500, 500)
  invisible(gc())
  timing_3.4 <- system.time({
    # Rem: there are faster ways to do this
    # but here we want to time loops (220*220 'for' loops)! 
    for (j in 1:500) {
      for (k in 1:500) {
        b[k,j] <- abs(j - k) + 1
      }
    }
  })[3]
  cumulate_3 <- cumulate_3 + timing_3.4
}
timing_3.4 <- cumulate_3/runs
times[4, 3] <- timing_3.4
#cat(c("Creation of a 500x500 Toeplitz matrix (loops)_______ (sec): ", timing_3.4, "\n"))
remove("b", "j", "k")


# (5)
cumulate_3 <- 0; p <- 0; vt <- 0; vr <- 0; vrt <- 0; rvt <- 0; RV <- 0; j <- 0; k <- 0;
x2 <- 0; R <- 0; Rxx <- 0; Ryy <- 0; Rxy <- 0; Ryx <- 0; Rvmax <- 0
# Calculate the trace of a matrix (sum of its diagonal elements)
Trace <- function(y) {sum(c(y)[1 + 0:(min(dim(y)) - 1) * (dim(y)[1] + 1)], na.rm=FALSE)}
for (i in 1:runs) {
  x <- abs(Rnorm(45*45)); dim(x) <- c(45, 45)
  invisible(gc())
  timing_3.5 <- system.time({
    # Calculation of Escoufier's equivalent vectors
    p <- ncol(x)
    vt <- 1:p                                  # Variables to test
    vr <- NULL                                 # Result: ordered variables
    RV <- 1:p                                  # Result: correlations
    vrt <- NULL
    for (j in 1:p) {                           # loop on the variable number
      Rvmax <- 0
      for (k in 1:(p-j+1)) {                   # loop on the variables
        x2 <- cbind(x, x[,vr], x[,vt[k]])
        R <- cor(x2)                           # Correlations table
        Ryy <- R[1:p, 1:p]
        Rxx <- R[(p+1):(p+j), (p+1):(p+j)]
        Rxy <- R[(p+1):(p+j), 1:p]
        Ryx <- t(Rxy)
        rvt <- Trace(Ryx %*% Rxy) / sqrt(Trace(Ryy %*% Ryy) * Trace(Rxx %*% Rxx)) # RV calculation
        if (rvt > Rvmax) {
          Rvmax <- rvt                         # test of RV
          vrt <- vt[k]                         # temporary held variable
        }
      }
      vr[j] <- vrt                             # Result: variable
      RV[j] <- Rvmax                           # Result: correlation
      vt <- vt[vt!=vr[j]]                      # reidentify variables to test
    }
  })[3]
  cumulate_3 <- cumulate_3 + timing_3.5
}
times[5, 3] <- timing_3.5
#cat(c("Escoufier's method on a 45x45 matrix (mixed)________ (sec): ", timing_3.5, "\n"))
remove("x", "p", "vt", "vr", "vrt", "rvt", "RV", "j", "k")
remove("x2", "R", "Rxx", "Ryy", "Rxy", "Ryx", "Rvmax", "Trace") 


times[ , 3] <- sort(times[ , 3])

trimed_geom_3 <-  exp(mean(log(times[2:4, 3])))

total <- sum(times)
overall_mean <- exp(mean(log(times[2:4, ])))

### Graphs 

type <- c(1,1,1,1,1,2,2,2,2,2,3,3,3,3,3)
time_type <- c(timing_1.1,timing_1.2,timing_1.3,timing_1.4,timing_1.5,
               timing_2.1,timing_2.2,timing_2.3,timing_2.4,timing_2.5,
               timing_3.1,timing_3.2,timing_3.3,timing_3.4,timing_3.5)

Process <- c('Creation, transp., deformation of a 2500x2500 matrix','2400x2400 normal distributed random matrix ^1000',
         'Sorting of 7,000,000 random values','2800x2800 cross-product matrix',
         'Linear regr. over a 3000x3000 matrix','FFT over 2,400,000 random values',
         'Eigenvalues of a 640x640 random matrix', 'Determinant of a 2500x2500 random matrix',
         'Cholesky decomposition of a 3000x3000 matrix','Inverse of a 1600x1600 random matrix',
         '3,500,000 Fibonacci numbers calculation','Creation of a 3000x3000 Hilbert matrix',
         'Grand common divisors of 400,000 pairs','Creation of a 500x500 Toeplitz matrix',
         'Escoufiers method on a 45x45 matrix')

dfr_ind <- data.frame(type,time_type)
dfr_ind$opt_std <- rep("opt",15)
dfr_ind$Process <- Process
dfr1 <- read.csv(file = "data/Data_1.csv")
dfr1$opt_std <- rep("std",15)
dfr1$Process <- Process
data_g <- rbind(dfr_ind, dfr1)

data_sorted <- arrange(data_g, Process, opt_std)

data_sorted$time_type <- round(data_cumsum$time_type,2)
data_cumsum <- ddply(data_sorted, "Process", transform, label_ypos = cumsum(time_type))


# Create the bar plot
g <- ggplot(data = data_cumsum, aes(x = Process, y = time_type, fill = opt_std)) + geom_bar(stat = "identity") + geom_text(aes(label = time_type, y = label_ypos), vjust = 1.6, color = "black", size = 3.5) + coord_flip()

g <- g + labs(y="Time", title = "Standard BLAS Vs. Optimized OpenBLAS")

ggsave('plot.jpg',plot=g,scale=1,dpi=320, width=35,height = 25, units = "cm")
  
cat("                      --- Open plot.jpg in repository ---\n\n")   

