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

mkdir -p $outputdir/hhblits

cd $outputdir
perl /home/jh7x3/multicom_v1.1/src/meta/hhblits/script/tm_hhblits_main.pl /home/jh7x3/multicom_v1.1/src/meta/hhblits/hhblits_option /home/jh7x3/multicom_v1.1/examples/T0993s2.fasta hhblits  2>&1 | tee  hhblits.log
perl /home/jh7x3/multicom_v1.1/src/meta/hhblits/script/filter_identical_hhblits.pl hhblits

printf "\nFinished.."
printf "\nCheck log file <$outputdir/hhblits.log>\n\n"


if [[ ! -f "$outputdir/hhblits/blits1.pdb" ]];then 
	printf "!!!!! Failed to run hhblits, check the installation </home/jh7x3/multicom_v1.1/src/meta/hhblits/>\n\n"
else
	printf "\nJob successfully completed!"
	cp $outputdir/hhblits/blits1.pdb $outputdir/$targetid.pdb 
	printf "\nResults: $outputdir/$targetid.pdb\n\n"
fi
