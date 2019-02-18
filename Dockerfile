FROM rocker/r-ver:3.5.1

ENV SPARK_VERSION 2.3.0 
ENV SPARKLYR_VERSION 0.8.4

RUN cat /etc/os-release 

RUN apt-get update \ 
    && apt-get install -y libopenblas-base\
    -y pv


RUN install2.r --error \
    microbenchmark \
    SuppDists \
    ggplot2 \
    plyr \
    dplyr

