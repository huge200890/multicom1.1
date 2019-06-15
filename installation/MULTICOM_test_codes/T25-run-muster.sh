#!/bin/bash

dtime=$(date +%m%d%y)


mkdir -p /home/jh7x3/multicom_beta1.0/test_out/T1006_muster_$dtime/
cd /home/jh7x3/multicom_beta1.0/test_out/T1006_muster_$dtime/

mkdir muster
perl /home/jh7x3/multicom_beta1.0/src/meta/muster/script/tm_muster_main.pl /home/jh7x3/multicom_beta1.0/src/meta/muster/muster_option_version4 /home/jh7x3/multicom_beta1.0/examples/T1006.fasta muster  2>&1 | tee  /home/jh7x3/multicom_beta1.0/test_out/T1006_muster_$dtime.log
perl /home/jh7x3/multicom_beta1.0/src/meta/muster/script/filter_identical_muster.pl muster

printf "\nFinished.."
printf "\nCheck log file </home/jh7x3/multicom_beta1.0/test_out/T1006_muster_$dtime.log>\n\n"


if [[ ! -f "/home/jh7x3/multicom_beta1.0/test_out/T1006_muster_$dtime/muster/muster1.pdb" ]];then 
	printf "!!!!! Failed to run muster, check the installation </home/jh7x3/multicom_beta1.0/src/meta/muster/>\n\n"
else
	printf "\nJob successfully completed!"
	printf "\nResults: /home/jh7x3/multicom_beta1.0/test_out/T1006_muster_$dtime/muster/muster1.pdb\n\n"
fi

