#!/bin/bash

if [ $# != 3 ]; then
	echo "$0 <target id> <fasta> <output-directory>"
	exit
fi

targetid = $1
fastafile = $2
outputdir = $3

mkdir -p $outputdir
cd $outputdir

perl SOFTWARE_PATH/src/meta/hhsearch/script/tm_hhsearch_main_v2.pl SOFTWARE_PATH/src/meta/hhsearch/hhsearch_option_hard $fastafile $outputdir  2>&1 | tee   $outputdir/run_hhsearch.log

printf "\nFinished.."
printf "\nCheck log file <$outputdir/run_hhsearch.log>\n\n"


if [[ ! -f "$outputdir//hh1.pdb" ]];then 
	printf "!!!!! Failed to run hhsearch, check the installation <SOFTWARE_PATH/src/meta/hhsearch/>\n\n"
else
	printf "\nJob successfully completed!"
	cp $outputdir/hh1.pdb $outputdir/$targetid.pdb 
	printf "\nResults: $outputdir/$targetid.pdb\n\n"
fi

