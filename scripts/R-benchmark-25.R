# Comienza prueba

cat("\n\n   Algebraic Packages Benchmark v1.0\n")
cat("   ===============\n")
cat("\n\n")


# Fijar el tamaño de las matrices y vectores
tamano <- 2500

# Multiplicación de dos vectores
x <- runif(tamano,0,1000)
# Se crea una vector de 1000 x 1 y adicionalmente se perturba con valores aleatorios entre 250 y 750
y <- runif(tamano,0,1000) + runif(1,250,750)

t1 <- system.time({ 
  x %*% y
})
cat(c("2500x1 vector multiplication_________________________ (sec):",t1[1],"\n"))

# Crear una matriz de 2500 x 2500 utilizando números aleatorios de una distribución uniforme.
set.seed(1234)
M<-matrix(runif(tamano*tamano,min=0,1000),tamano,tamano)

# Mutiplicación de matriz por vector
t2 <- system.time({ 
  M %*% x
})
cat(c("Matrix vector multiplication (2500x2500)x(2500x1)____ (sec):",t2[1],"\n"))

# Multiplicación de una matriz por una matriz
t3 <- system.time({ 
  (M %*% t(M))
})
cat(c("Matrix matrix multiplication (2500x2500)x(2500x1)____ (sec):",t3[1],"\n"))

# Calcular los eigen valores de una matriz
t4 <- system.time({ 
  eigen(M)
})
cat(c("Eigenvector of 2500x2500 matrix______________________ (sec):",t4[1],"\n"))

# Invertir una matriz
t5 <- system.time({ 
  solve(M)
})
cat(c("Inverse of 2500x2500 matrix__________________________ (sec):",t5[1],"\n"))

# Resolver un sistema de ecuaciones lineals
t6 <- system.time({ 
  solve(M,y)
})
cat(c("Solving matrix equation system 2500x2500 b=2500x1____ (sec):",t6[1],"\n"))

# Análisis de componentes principales
t7 <- system.time({ 
  princomp(M)
})
cat(c("Principal components of 2500x2500 matrix_____________ (sec):",t7[1],"\n"))

# Descomposición de valores singulares
t8 <- system.time({ 
  svd(M)
})
cat(c("Singular value decomposition of 2500x2500 matrix_____ (sec):",t8[1],"\n\n"))



tiempo <- t1[1]+t2[1]+t3[1]+t4[1]+t5[1]+t6[1]+t6[1]+t8[1]
cat(c("Total time for all tests_____________________________ (sec): ", tiempo, "\n"))
cat(c("Mean of all tests____________________________________ (sec): ", tiempo/8, "\n"))
cat("                      --- End of test ---\n\n") 
