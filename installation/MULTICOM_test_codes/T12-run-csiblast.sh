#!/bin/bash

dtime=$(date +%m%d%y)


mkdir -p /home/jh7x3/multicom_v1.1/test_out/T0993s2_csiblast_$dtime/
cd /home/jh7x3/multicom_v1.1/test_out/T0993s2_csiblast_$dtime/

mkdir csiblast
perl /home/jh7x3/multicom_v1.1/src/meta/csblast/script/multicom_csiblast_v2.pl /home/jh7x3/multicom_v1.1/src/meta/csblast/csiblast_option /home/jh7x3/multicom_v1.1/examples/T0993s2.fasta csiblast  2>&1 | tee  /home/jh7x3/multicom_v1.1/test_out/T0993s2_csiblast_$dtime.log


printf "\nFinished.."
printf "\nCheck log file </home/jh7x3/multicom_v1.1/test_out/T0993s2_csiblast_$dtime.log>\n\n"


if [[ ! -f "/home/jh7x3/multicom_v1.1/test_out/T0993s2_csiblast_$dtime/csiblast/csiblast1.pdb" ]];then 
	printf "!!!!! Failed to run csiblast, check the installation </home/jh7x3/multicom_v1.1/src/meta/csblast/>\n\n"
else
	printf "\nJob successfully completed!"
	printf "\nResults: /home/jh7x3/multicom_v1.1/test_out/T0993s2_csiblast_$dtime/csiblast/csiblast1.pdb\n\n"
fi

