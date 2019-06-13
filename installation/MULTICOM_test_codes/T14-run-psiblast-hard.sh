#!/bin/bash

dtime=$(date +%m%d%y)


mkdir -p /home/jh7x3/multicom_v1.1/test_out/T0993s2_psiblast_hard_$dtime/
cd /home/jh7x3/multicom_v1.1/test_out/T0993s2_psiblast_hard_$dtime/

mkdir psiblast
perl /home/jh7x3/multicom_v1.1/src/meta/psiblast/script/main_psiblast_v2.pl /home/jh7x3/multicom_v1.1/src/meta/psiblast/psiblast_option_hard /home/jh7x3/multicom_v1.1/examples/T0993s2.fasta psiblast  2>&1 | tee  /home/jh7x3/multicom_v1.1/test_out/T0993s2_psiblast_hard_$dtime.log


printf "\nFinished.."
printf "\nCheck log file </home/jh7x3/multicom_v1.1/test_out/T0993s2_psiblast_hard_$dtime.log>\n\n"


if [[ ! -f "/home/jh7x3/multicom_v1.1/test_out/T0993s2_psiblast_hard_$dtime/psiblast/psiblast1.pdb" ]];then 
	printf "!!!!! Failed to run psiblast, check the installation </home/jh7x3/multicom_v1.1/src/meta/psiblast/>\n\n"
else
	printf "\nJob successfully completed!"
	printf "\nResults: /home/jh7x3/multicom_v1.1/test_out/T0993s2_psiblast_hard_$dtime/psiblast/psiblast1.pdb\n\n"
fi

