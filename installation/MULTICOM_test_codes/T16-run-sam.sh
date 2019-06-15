#!/bin/bash

dtime=$(date +%m%d%y)


mkdir -p /home/jh7x3/multicom_beta1.0/test_out/T1006_sam_$dtime/
cd /home/jh7x3/multicom_beta1.0/test_out/T1006_sam_$dtime/

mkdir sam
perl /home/jh7x3/multicom_beta1.0/src/meta/sam/script/tm_sam_main_v2.pl /home/jh7x3/multicom_beta1.0/src/meta/sam/sam_option_nr /home/jh7x3/multicom_beta1.0/examples/T1006.fasta sam  2>&1 | tee  /home/jh7x3/multicom_beta1.0/test_out/T1006_sam_$dtime.log


printf "\nFinished.."
printf "\nCheck log file </home/jh7x3/multicom_beta1.0/test_out/T1006_sam_$dtime.log>\n\n"


if [[ ! -f "/home/jh7x3/multicom_beta1.0/test_out/T1006_sam_$dtime/sam/sam1.pdb" ]];then 
	printf "!!!!! Failed to run sam, check the installation </home/jh7x3/multicom_beta1.0/src/meta/sam/>\n\n"
else
	printf "\nJob successfully completed!"
	printf "\nResults: /home/jh7x3/multicom_beta1.0/test_out/T1006_sam_$dtime/sam/sam1.pdb\n\n"
fi

