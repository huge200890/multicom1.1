#!/bin/bash

dtime=$(date +%m%d%y)


mkdir -p /home/jh7x3/multicom_v1.1/test_out/T0993s2_hhblits_$dtime/
cd /home/jh7x3/multicom_v1.1/test_out/T0993s2_hhblits_$dtime/

mkdir hhblits
perl /home/jh7x3/multicom_v1.1/src/meta/hhblits/script/tm_hhblits_main.pl /home/jh7x3/multicom_v1.1/src/meta/hhblits/hhblits_option /home/jh7x3/multicom_v1.1/examples/T0993s2.fasta hhblits  2>&1 | tee  /home/jh7x3/multicom_v1.1/test_out/T0993s2_hhblits_$dtime.log
perl /home/jh7x3/multicom_v1.1/src/meta/hhblits/script/filter_identical_hhblits.pl hhblits

printf "\nFinished.."
printf "\nCheck log file </home/jh7x3/multicom_v1.1/test_out/T0993s2_hhblits_$dtime.log>\n\n"


if [[ ! -f "/home/jh7x3/multicom_v1.1/test_out/T0993s2_hhblits_$dtime/hhblits/blits1.pdb" ]];then 
	printf "!!!!! Failed to run hhblits, check the installation </home/jh7x3/multicom_v1.1/src/meta/hhblits/>\n\n"
else
	printf "\nJob successfully completed!"
	printf "\nResults: /home/jh7x3/multicom_v1.1/test_out/T0993s2_hhblits_$dtime/hhblits/blits1.pdb\n\n"
fi

