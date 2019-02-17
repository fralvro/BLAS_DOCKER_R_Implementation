FROM ubuntu:18.04

RUN apt-get update -y && apt-get install -y build-essential \
	nano \
	man \
	sudo \
	openssh-server \
	sshpass

### Instalo BLAS, LAPACK, ATLAS y R

RUN sudo apt-get install -y  libblas-dev libblas3 libatlas-base-dev\
 libatlas3-base libblas-test libblasr libblasr-dev libopenblas-base\
 libopenblas-dev
 

### Copio los scrips que tengo en mi carpeta
COPY triplef_benchmark.sh /triplef_benchmark.sh
COPY r-benchmark-25.sh /r-benchmark-25.sh


RUN sudo apt-get install -y r-base --with-blas="libopenblas-base"

CMD ["/triplef_benchmark.sh"]
CMD ["/r-benchmark-25.sh"]

RUN sudo apt-get install -y r-base --with-blas="libatlas3-base"

CMD ["/triplef_benchmark.sh"]
CMD ["/r-benchmark-25.sh"]

RUN sudo apt-get install -y r-base --without-blas

CMD ["/triplef_benchmark.sh"]
CMD ["/r-benchmark-25.sh"]
