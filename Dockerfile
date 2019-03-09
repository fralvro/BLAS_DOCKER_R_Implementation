
FROM rocker/r-ver:3.5.1


RUN apt-get update \ 
    && apt-get install -y libopenblas-base \
    && apt-get install -y libatlas3-base \
    && echo alias test=\'sh /home/performance/scripts/test.sh\' >> /root/.bashrc


CMD cat /home/performance/extras/intro.txt && /bin/bash

