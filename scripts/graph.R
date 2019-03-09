# function to arrange the dataframe
get_sequence <- function(b){
    b + df_order
}

# load df
s <- read.csv('results.csv')
s$time <- s$time + 2
o <- read.csv('results.csv')
o$time <- o$time + 0.5
a <- read.csv('results.csv')

if (nrow(a) == 16) {
    t <- rbind(s$time, o$time, a$time)
    rownames(t) <- c('Standard', 'OpenBLAS', 'Atlas')
    colnames(t) <- s$test
    t <- t[,16:1]
    
    max_v <- round(max(t)+1)
    
    png(filename = 'results.png', 
        width = 1600, height = 800,
        type='cairo')
    par(mai=c(1,5,1,1))
    barplot(t,
            width=4, 
            beside=T,
            axes= TRUE,
            xlab='Time (sec)',
            main = 'BLAS test performance results',
            col = c('coral', 'deepskyblue3', 'chartreuse3'), 
            horiz = TRUE,
            las = 1, 
            names.arg = colnames(t),
            cex.names = 1,
            cex.lab = 1.2,
            cex.main = 3
            )
    legend('topright',
           legend = rownames(t), 
           fill = c('coral', 'deepskyblue3', 'chartreuse3'),
           cex = 2.25,
           title = 'BLAS package')
    dev.off()

}

