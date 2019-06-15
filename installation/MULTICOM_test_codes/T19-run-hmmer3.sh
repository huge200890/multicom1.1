#!/bin/bash

dtime=$(date +%m%d%y)


mkdir -p /home/jh7x3/multicom_beta1.0/test_out/T1006_hmmer3_$dtime/
cd /home/jh7x3/multicom_beta1.0/test_out/T1006_hmmer3_$dtime/

mkdir hmmer3
perl /home/jh7x3/multicom_beta1.0/src/meta/hmmer3/script/tm_hmmer3_main.pl /home/jh7x3/multicom_beta1.0/src/meta/hmmer3/hmmer3_option /home/jh7x3/multicom_beta1.0/examples/T1006.fasta hmmer3  2>&1 | tee  /home/jh7x3/multicom_beta1.0/test_out/T1006_hmmer3_$dtime.log


printf "\nFinished.."
printf "\nCheck log file </home/jh7x3/multicom_beta1.0/test_out/T1006_hmmer3_$dtime.log>\n\n"


if [[ ! -f "/home/jh7x3/multicom_beta1.0/test_out/T1006_hmmer3_$dtime/hmmer3/jackhmmer1.pdb" ]];then 
	printf "!!!!! Failed to run hmmer3, check the installation </home/jh7x3/multicom_beta1.0/src/meta/hmmer3/>\n\n"
else
	printf "\nJob successfully completed!"
	printf "\nResults: /home/jh7x3/multicom_beta1.0/test_out/T1006_hmmer3_$dtime/hmmer3/jackhmmer1.pdb\n\n"
fi

