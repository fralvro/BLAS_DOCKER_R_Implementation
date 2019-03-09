#!/bin/bash

TEST=$1
IMAGE=$2

echo '*************************************'
echo 'Standard Method'
echo '*************************************'
update-alternatives --quiet --set libblas.so.3 /usr/lib/libblas/libblas.so.3    
Rscript ${TEST}
cp /home/performance/img/results.csv /home/performance/img/s.csv
echo '*************************************'
echo 'Optimized OpenBLAS method'
echo '*************************************'
update-alternatives --quiet --set libblas.so.3 /usr/lib/openblas-base/libblas.so.3      
Rscript ${TEST}
cp /home/performance/img/results.csv /home/performance/img/o.csv
echo '*************************************'
echo 'Optimized Atlas method'
echo '*************************************'
update-alternatives --quiet --set libblas.so.3 /usr/lib/atlas-base/atlas/libblas.so.3
Rscript ${TEST}
cp /home/performance/img/results.csv /home/performance/img/a.csv
if [ "${IMAGE}" = 'yes' ]
then
	Rscript /home/performance/scripts/graph.R
fi
rm /home/performance/img/results.csv
rm /home/performance/img/s.csv
rm /home/performance/img/a.csv
rm /home/performance/img/o.csv
