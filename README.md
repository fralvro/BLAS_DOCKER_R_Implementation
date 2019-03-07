# BLAS_DOCKER_R_Implementation

This repository contains a docker container which shows the differences in performance using the standard Basic Linear Algebra System (BLAS) and two optimized implementations: OpenBLAS (version 0.3.5+ds-2) and ATLAS (version 3.10.1-4).

We use a docker image of a Debian 9 distribution with the 4.15.0-46-generic kernel. The tests are run using R version 3.5.1. To measure performance, you can run two different performance tests: *R Benchmark 2.5*, by Simon Urbanek (2008), and *Algebraic Packages Benchmark 1.0*, by Dante Ruiz and Laura López (2019).

To build the docker and run the performance tests, you need to clone this repository and run the following commands:

```shell
docker build -t r-performance .
docker run --rm -i -t -v my/repository/folder:/home/performance r-performance /bin/bash
```
If everything goes well, you will start in the bash system of the newly created docker image. Then, you can run the performance tests with the command:

```shell
test -args
```

The arguments for this command are:
* `-t` to select which test to run. Available options are `u` or `urbanek` for Urbanek's test and `lp` or `lopez-ruiz` for López and Ruiz test.
* `-m` to select which BLAS package to use. Available options are `s` or `standard` for the default BLAS package, `o` or `openblas` for the OpenBLAS package, `a` or `atlas` for the Atlas package and `all` to run the test using all three packages.
* `-h` to get more detailed descriptions of the arguments.
