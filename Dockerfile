FROM ubuntu:18.04
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y && apt-get install -y build-essential \
	nano \
	man \
	sudo \
	openssh-server \
	sshpass

RUN apt-get install -y r-base

### Copio los scrips que tengo en mi carpeta
ADD triplef_benchmark.sh /
RUN /triplef_benchmark.sh
