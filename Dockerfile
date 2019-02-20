
FROM rocker/r-ver:3.5.1


RUN apt-get update \ 
    && apt-get install -y libopenblas-base \
    && apt-get install -y libatlas3-base


RUN install2.r --error \
    microbenchmark \
    SuppDists \
    ggplot2\
    dplyr

