#!/bin/bash

dtime=$(date +%m%d%y)


mkdir -p /home/jh7x3/multicom_v1.1/test_out/T0993s2_ffas_$dtime/
cd /home/jh7x3/multicom_v1.1/test_out/T0993s2_ffas_$dtime/

mkdir ffas
perl /home/jh7x3/multicom_v1.1/src/meta/ffas/script/tm_ffas_main.pl /home/jh7x3/multicom_v1.1/src/meta/ffas/ffas_option /home/jh7x3/multicom_v1.1/examples/T0993s2.fasta ffas  2>&1 | tee  /home/jh7x3/multicom_v1.1/test_out/T0993s2_ffas_$dtime.log


printf "\nFinished.."
printf "\nCheck log file </home/jh7x3/multicom_v1.1/test_out/T0993s2_ffas_$dtime.log>\n\n"


if [[ ! -f "/home/jh7x3/multicom_v1.1/test_out/T0993s2_ffas_$dtime/ffas/ff1.pdb" ]];then 
	printf "!!!!! Failed to run ffas, check the installation </home/jh7x3/multicom_v1.1/src/meta/ffas/>\n\n"
else
	printf "\nJob successfully completed!"
	printf "\nResults: /home/jh7x3/multicom_v1.1/test_out/T0993s2_ffas_$dtime/ffas/ff1.pdb\n\n"
fi

