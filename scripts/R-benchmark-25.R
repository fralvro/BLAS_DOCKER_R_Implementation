# Comienza prueba

cat("\n\n   R Benchmark 2.5\n")
cat("   ===============\n")
cat(c("Number of times each test is run_______________________________: ", "8"))
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


# Crear una matriz de 2500 x 2500 utilizando números aleatorios de una distribución uniforme.
set.seed(1234)
M<-matrix(runif(tamano*tamano,min=0,1000),tamano,tamano)

# Mutiplicación de matriz por vector
t2 <- system.time({ 
  M %*% x
})

# Multiplicación de una matriz por una matriz
t3 <- system.time({ 
  (M %*% t(M))
})

# Calcular los eigen valores de una matriz
t4 <- system.time({ 
  eigen(M)
})

# Invertir una matriz
t5 <- system.time({ 
  solve(M)
})


# Resolver un sistema de ecuaciones lineals
t6 <- system.time({ 
  solve(M,y)
})


# Análisis de componentes principales
t7 <- system.time({ 
  princomp(M)
})

# Descomposición de valores singulares
t8 <- system.time({ 
  svd(M)
})




cat(c("Multiplicación de vector por vector 2500x1_______________ (sec):",t1[1],"\n"))
cat(c("Multiplicación de matiz por vector (2500x2500)x(2500x1)__ (sec):",t2[1],"\n"))
cat(c("Multiplicación de matiz por matriz (2500x2500)x(2500x1)__ (sec):",t3[1],"\n"))
cat(c("Eigenvalores de matiz 2500x2500__________________________ (sec):",t4[1],"\n"))
cat(c("Inversa  de matiz 2500x2500______________________________ (sec):",t5[1],"\n"))
cat(c("Solución a sistema de ecuaciones matiz 2500x2500 b=2500x1 (sec):",t6[1],"\n"))
cat(c("Componentes principales en  matriz de 2500x2500__________ (sec):",t7[1],"\n"))
cat(c("Descomposición en valores singulares matriz de 2500x2500_ (sec):",t8[1],"\n\n"))

tiempo <- t1[1]+t2[1]+t3[1]+t4[1]+t5[1]+t6[1]+t6[1]+t8[1]
cat(c("Total time for all 8 tests_______________________________ (sec): ", tiempo, "\n"))
cat(c("Mean of 8 tests__________________________________________ (sec): ", tiempo/8, "\n"))
cat("                      --- End of test ---\n\n") 
