#!/bin/bash

if [ $# != 3 ]; then
	echo "$0 <target id> <fasta> <output-directory>"
	exit
fi

targetid=$1
fastafile=$2
outputdir=$3

mkdir -p $outputdir
cd $outputdir

if [[ "$fastafile" != /* ]]
then
   echo "Please provide absolute path for $fastafile"
   exit
fi

if [[ "$outputdir" != /* ]]
then
   echo "Please provide absolute path for $outputdir"
   exit
fi

mkdir -p $outputdir/prc

cd $outputdir
perl /home/jh7x3/multicom_beta1.0/src/meta/prc/script/tm_prc_main_v2.pl /home/jh7x3/multicom_beta1.0/src/meta/prc/prc_option_hard $fastafile prc  2>&1 | tee  prc.log


printf "\nFinished.."
printf "\nCheck log file <$outputdir/prc.log>\n\n"


if [[ ! -f "$outputdir/prc/prc1.pdb" ]];then 
	printf "!!!!! Failed to run prc, check the installation </home/jh7x3/multicom_beta1.0/src/meta/prc/>\n\n"
else
	printf "\nJob successfully completed!"
	cp $outputdir/prc/prc1.pdb $outputdir/$targetid.pdb 
	printf "\nResults: $outputdir/$targetid.pdb\n\n"
fi
