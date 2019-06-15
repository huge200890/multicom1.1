#!/bin/bash

dtime=$(date +%m%d%y)


mkdir -p /home/jh7x3/multicom_beta1.0/test_out/T1006_hhsearch151_hard_$dtime/
cd /home/jh7x3/multicom_beta1.0/test_out/T1006_hhsearch151_hard_$dtime/

mkdir hhsearch151
perl /home/jh7x3/multicom_beta1.0/src/meta/hhsearch151/script/tm_hhsearch151_main.pl /home/jh7x3/multicom_beta1.0/src/meta/hhsearch151/hhsearch151_option_hard /home/jh7x3/multicom_beta1.0/examples/T1006.fasta hhsearch151  2>&1 | tee  /home/jh7x3/multicom_beta1.0/test_out/T1006_hhsearch151_hard_$dtime.log


printf "\nFinished.."
printf "\nCheck log file </home/jh7x3/multicom_beta1.0/test_out/T1006_hhsearch151_hard_$dtime.log>\n\n"


if [[ ! -f "/home/jh7x3/multicom_beta1.0/test_out/T1006_hhsearch151_hard_$dtime/hhsearch151/hg1.pdb" ]];then 
	printf "!!!!! Failed to run hhsearch151, check the installation </home/jh7x3/multicom_beta1.0/src/meta/hhsearch151/>\n\n"
else
	printf "\nJob successfully completed!"
	printf "\nResults: /home/jh7x3/multicom_beta1.0/test_out/T1006_hhsearch151_hard_$dtime/hhsearch151/hg1.pdb\n\n"
fi

