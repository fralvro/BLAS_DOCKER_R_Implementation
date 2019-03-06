#!/bin/bash

while getopts t:m:h option
do
case "${option}" in
	t) T=${OPTARG};;
	m) M=${OPTARG};;
	h) cat /home/performance/scripts/help.txt; exit 1;;
	*) echo 'One or more arguments are incorrect. Use -h for more information'; exit 2;;
esac
done

case ${T} in
	lp|lopez|ruiz|lopez-ruiz) 
		TEST='/home/performance/scripts/R-benchmark-25.R';;
	urbanek|u) 
		TEST='/home/performance/scripts/TripleF_benchmark.R';;
	*)
		echo "Incorrect test chosen. Lopez-Ruiz performance test used by default. Use -h for more information."
		TEST='/home/performance/scripts/R-benchmark-25.R'
		echo "###########"
		;;
esac

case ${M} in
	s|standard) 
		METHOD='/usr/lib/libblas/libblas.so.3';;
	o|openblas|open) 
		METHOD='/usr/lib/openblas-base/libblas.so.3';;
	a|atlas) 
		METHOD='/usr/lib/atlas-base/atlas/libblas.so.3';;
	all)
		echo ${TEST}
		sh /home/performance/scripts/all_tests.sh ${TEST}		
		exit;;
	*)
		echo "Incorrect method chosen. Standard BLAS used by default. Use -h for more information."
		METHOD='/usr/lib/openblas-base/libblas.so.3'
		echo "###########"
		;;
esac

update-alternatives --quiet --set libblas.so.3 ${METHOD}
Rscript ${TEST}

		

