# BLAS_DOCKER_R_Implementation

This repository contains a docker container which shows the differences in performance using the standard Basic Linear Algebra System (BLAS) that comes with the Ubuntu 18.04 version of R (and other implementations) and OpenBLAS, an optimized BLAS system.

To build the docker and run the performance tests, you need to clone this repository and run the following commands:

```shell
sudo docker build -t r-performance .
sudo docker run --rm -i -t -v my/repository/folder:/home/performance r-performance /bin/bash
```
If everything goes well, you will start in the bash system of the newly created docker image. Then, you can run the performance tests with the command:

```shell
sh /home/performance/test.sh --option
```

The available options are:
* `--standard` to run the test using the default BLAS system.
* `--openblas` to run the test using the optimized OpenBLAS system.
* `--atlas` to run the test using the optimized ATLAS system.
* `--all` to run the test using both systems.
* `--all_graphic` to run the test using both systems and displaying a graphical comparison.
* `--help` to get more detailed descriptions of the commands.
