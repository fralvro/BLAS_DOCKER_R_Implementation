#!/bin/bash

INPUT=$1

if [ "${INPUT}" = '--standard' ]
then
	update-alternatives --quiet --set libblas.so.3 /usr/lib/libblas/libblas.so.3	
	Rscript /home/performance/scripts/R-benchmark-25.R
elif [ "${INPUT}" = '--openblas' ]
then
	update-alternatives --quiet --set libblas.so.3 /usr/lib/openblas-base/libblas.so.3	
	Rscript /home/performance/scripts/R-benchmark-25.R
elif [ "${INPUT}" = '--all' ]
then
	echo '*************************************'
	echo 'Standard method'
	echo '*************************************'
	update-alternatives --quiet --set libblas.so.3 /usr/lib/libblas/libblas.so.3	
	Rscript /home/performance/scripts/R-benchmark-25.R
	echo '*************************************'
	echo 'Optimized method'
	echo '*************************************'
	update-alternatives --quiet --set libblas.so.3 /usr/lib/openblas-base/libblas.so.3	
	Rscript /home/performance/scripts/R-benchmark-25.R
elif [ "${INPUT}" = '--all_graphic' ]
then
        echo '*************************************'
        echo 'Standard Method Graphic Mode'
        echo '*************************************'
        update-alternatives --quiet --set libblas.so.3 /usr/lib/libblas/libblas.so.3    
        Rscript /home/performance/scripts/TripleF_benchmark.R
        echo '*************************************'
        echo 'Optimized method Graphic Mode'
        echo '*************************************'
        update-alternatives --quiet --set libblas.so.3 /usr/lib/openblas-base/libblas.so.3      
        Rscript /home/performance/scripts/TripleF_benchmark_opt.R
        rm /home/performance/Data_1.csv

elif [ "${INPUT}" = '--help' ]
then
	echo 'Runs a series of matrix operations in the R language in order to test performance of the system.'
	echo 'The script run is a modified version of Simon Urbanek R-benchmark 2.5.'
	echo 'The results are displayed on the terminal screen'.
	echo ''
	echo 'The available arguments are:'
	echo '   --standard		Runs the benchmark script using the default libblas package.'
	echo '   --openblas		Runs the benchmark script using the optimized libopenblas package.'
	echo '   --all		Runs the benchmark script using all available methods.'
        echo '   --all_graphic  Runs the benchmark script using all available methods and stores a graphical representation of each.'
	echo '   --help		Shows this document.'
else
	echo 'Please select a valid option.'
	echo "Try 'test.sh --help' for more information."
fi

