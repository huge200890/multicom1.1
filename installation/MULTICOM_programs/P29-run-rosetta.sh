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

mkdir -p $outputdir/rosetta2
mkdir -p $outputdir/rosetta_common

cd $outputdir
sh /home/jh7x3/multicom_beta1.0/src/meta/script/make_rosetta_fragment.sh /home/jh7x3/multicom_beta1.0/examples/T1006.fasta abini  rosetta_common 100 2>&1 | tee  rosetta_common.log
cp -r rosetta_common/abini rosetta2
sh /home/jh7x3/multicom_beta1.0/src/meta/script/run_rosetta_no_fragment.sh /home/jh7x3/multicom_beta1.0/examples/T1006.fasta abini rosetta2 100 2>&1 | tee  rosetta2.log


printf "\nFinished.."
printf "\nCheck log file <$outputdir/rosetta2.log>\n\n"


if [[ ! -f "$outputdir/rosetta2/abini/abini-1.pdb" ]];then 
	printf "!!!!! Failed to run rosetta, check the installation </home/jh7x3/multicom_beta1.0/src/meta/script/run_rosetta_no_fragment.sh>\n\n"
else
	printf "\nJob successfully completed!"
	cp $outputdir/rosetta2/abini/abini-1.pdb $outputdir/$targetid.pdb 
	printf "\nResults: $outputdir/$targetid.pdb\n\n"
fi

