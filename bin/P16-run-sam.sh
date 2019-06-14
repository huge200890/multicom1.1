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

mkdir -p $outputdir/sam

cd $outputdir
perl /home/jh7x3/multicom_v1.1/src/meta/sam/script/tm_sam_main_v2.pl /home/jh7x3/multicom_v1.1/src/meta/sam/sam_option_nr $fastafile sam  2>&1 | tee  /home/jh7x3/multicom_v1.1/test_out/T0993s2_sam_$dtime.log

printf "\nFinished.."
printf "\nCheck log file <$outputdir/sam.log>\n\n"


if [[ ! -f "$outputdir/sam/sam1.pdb" ]];then 
	printf "!!!!! Failed to run sam, check the installation </home/jh7x3/multicom_v1.1/src/meta/sam/>\n\n"
else
	printf "\nJob successfully completed!"
	cp $outputdir/sam/sam1.pdb $outputdir/$targetid.pdb 
	printf "\nResults: $outputdir/$targetid.pdb\n\n"
fi
