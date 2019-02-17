
FROM rocker/r-ver:3.5.1


RUN apt-get update \ 
    && apt-get install -y libopenblas-base


RUN install2.r --error \
    microbenchmark \
    SuppDists
