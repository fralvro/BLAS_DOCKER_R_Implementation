#!/bin/bash

TEST=$1

echo '*************************************'
echo 'Standard Method'
echo '*************************************'
update-alternatives --quiet --set libblas.so.3 /usr/lib/libblas/libblas.so.3    
Rscript ${TEST}
echo '*************************************'
echo 'Optimized OpenBLAS method'
echo '*************************************'
update-alternatives --quiet --set libblas.so.3 /usr/lib/openblas-base/libblas.so.3      
Rscript ${TEST}
echo '*************************************'
echo 'Optimized Atlas method'
echo '*************************************'
update-alternatives --quiet --set libblas.so.3 /usr/lib/atlas-base/atlas/libblas.so.3
Rscript ${TEST}
