#!/bin/sh
if [ $# -ne 2 ]
then
        echo "need two parameters: input fasta file, output directory."
        exit 1
fi

fastafile=$1
outputdir=$2

source /home/jh7x3/multicom_v1.1/tools/python_virtualenv/bin/activate
export LD_LIBRARY_PATH=/home/jh7x3/multicom_v1.1/tools/boost_1_55_0/lib/:/home/jh7x3/multicom_v1.1/tools/OpenBLAS:$LD_LIBRARY_PATH

if [ ! -d "$outputdir" ]; then
  mkdir -p $outputdir
fi

/home/jh7x3/multicom_v1.1/src/multicom_ve.pl /home/jh7x3/multicom_v1.1/src/multicom_system_option_casp13 $fastafile $outputdir 

