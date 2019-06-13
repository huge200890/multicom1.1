#!/bin/bash

dtime=$(date +%m%d%y)


mkdir -p /home/jh7x3/multicom_v1.1/test_out/T0993s2_hhpred_hard_$dtime/
cd /home/jh7x3/multicom_v1.1/test_out/T0993s2_hhpred_hard_$dtime/

mkdir hhpred
perl /home/jh7x3/multicom_v1.1/src/meta/hhpred/script/tm_hhpred_main.pl /home/jh7x3/multicom_v1.1/src/meta/hhpred/hhpred_option_hard /home/jh7x3/multicom_v1.1/examples/T0993s2.fasta hhpred  2>&1 | tee  /home/jh7x3/multicom_v1.1/test_out/T0993s2_hhpred_hard_$dtime.log


printf "\nFinished.."
printf "\nCheck log file </home/jh7x3/multicom_v1.1/test_out/T0993s2_hhpred_hard_$dtime.log>\n\n"


if [[ ! -f "/home/jh7x3/multicom_v1.1/test_out/T0993s2_hhpred_hard_$dtime/hhpred/hp1.pdb" ]];then 
	printf "!!!!! Failed to run hhpred, check the installation </home/jh7x3/multicom_v1.1/src/meta/hhpred/>\n\n"
else
	printf "\nJob successfully completed!"
	printf "\nResults: /home/jh7x3/multicom_v1.1/test_out/T0993s2_hhpred_hard_$dtime/hhpred/hp1.pdb\n\n"
fi

