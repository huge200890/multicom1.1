#!/bin/bash

dtime=$(date +%m%d%y)


mkdir -p /home/jh7x3/multicom_beta1.0/test_out/T1006_csblast_$dtime/
cd /home/jh7x3/multicom_beta1.0/test_out/T1006_csblast_$dtime/

mkdir csblast
perl /home/jh7x3/multicom_beta1.0/src/meta/csblast/script/multicom_csblast_v2.pl /home/jh7x3/multicom_beta1.0/src/meta/csblast/csblast_option /home/jh7x3/multicom_beta1.0/examples/T1006.fasta csblast  2>&1 | tee  /home/jh7x3/multicom_beta1.0/test_out/T1006_csblast_$dtime.log


printf "\nFinished.."
printf "\nCheck log file </home/jh7x3/multicom_beta1.0/test_out/T1006_csblast_$dtime.log>\n\n"


if [[ ! -f "/home/jh7x3/multicom_beta1.0/test_out/T1006_csblast_$dtime/csblast/csblast1.pdb" ]];then 
	printf "!!!!! Failed to run csblast, check the installation </home/jh7x3/multicom_beta1.0/src/meta/csblast/>\n\n"
else
	printf "\nJob successfully completed!"
	printf "\nResults: /home/jh7x3/multicom_beta1.0/test_out/T1006_csblast_$dtime/csblast/csblast1.pdb\n\n"
fi

