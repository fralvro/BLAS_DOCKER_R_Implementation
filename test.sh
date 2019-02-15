#!/bin/bash

INPUT=$1

if [ "${INPUT}" = '--standard' ]
then
	Rscript scripts/R-benchmark-25.R ^C
elif [ "${INPUT}" = '--openblas' ]
then
	echo 'Corriendo el método optimizado'
elif [ "${INPUT}" = '--all' ]
then
	echo 'Corriendo ambos metodos'
elif [ "${INPUT}" = '--help' ]
then
	echo 'ayuda'
else
	echo 'Please select a valid option'
fi

