# BLAS_DOCKER_R_Implementation

This repository contains a docker container which shows the differences in performance using the standard Basic Linear Algebra System (BLAS) and two optimized implementations: OpenBLAS (version 0.3.5+ds-2)and ATLAS (version 3.10.1-4).

We use a docker image of a Debian 9 distribution with the 4.15.0-46-generic kernel. The tests are run using R version 3.5.1. To measure performance, you can run two different performance tests: the R Benchmark 2.5, by Simon Urbanek (2008), and the Algebraic Packages Benchmark 1.0, by Dante Ruiz and Laura López (2019).

To build the docker and run the performance tests, you need to clone this repository and run the following commands:

```shell
docker build -t r-performance .
docker run --rm -i -t -v my/repository/folder:/home/performance r-performance /bin/bash
```
If everything goes well, you will start in the bash system of the newly created docker image. Then, you can run the performance tests with the command:

```shell
test --option
```

The available options are:
* `--standard` to run the test using the default BLAS system.
* `--openblas` to run the test using the optimized OpenBLAS system.
* `--atlas` to run the test using the optimized ATLAS system.
* `--all` to run the test using all systems.
* `--all_graphic` to run the test using all systems and displaying a graphical comparison.
* `--help` to get more detailed descriptions of the commands.
