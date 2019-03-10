# function to arrange the dataframe
get_sequence <- function(b){
    b + df_order
}

# load df
s <- read.csv('/home/performance/img/s.csv')
o <- read.csv('/home/performance/img/o.csv')
a <- read.csv('/home/performance/img/a.csv')

if (nrow(a) == 16) {
    t <- rbind(s$time, a$time, o$time)
    rownames(t) <- c('Standard', 'Atlas', 'OpenBLAS')
    colnames(t) <- s$test
    t <- t[,16:1]
    
    max_v <- round(max(t)+1)
    
    png(filename = '/home/performance/img/urbanek_test_results.png', 
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
            cex.names = 1.2,
            cex.lab = 1.2,
            cex.main = 3
            )
    legend('topright',
           legend = rownames(t), 
           fill = c('coral', 'deepskyblue3', 'chartreuse3'),
           cex = 2,
           title = 'BLAS package')
    dev.off()
}

if (nrow(a) == 9) {
    t <- rbind(s$time, a$time, o$time)
    rownames(t) <- c('Standard', 'Atlas', 'OpenBLAS')
    colnames(t) <- s$test
    t <- t[,9:1]
    
    max_v <- round(max(t)+1)
    
    png(filename = '/home/performance/img/lopez_ruiz_test_results.png', 
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
            cex.names = 1.2,
            cex.lab = 1.2,
            cex.main = 3
            )
    legend('topright',
           legend = rownames(t), 
           fill = c('coral', 'deepskyblue3', 'chartreuse3'),
           cex = 1.6,
           title = 'BLAS package')
    dev.off()
}

