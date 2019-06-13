#!/bin/bash

dtime=$(date +%m%d%y)


mkdir -p /home/jh7x3/multicom_v1.1/test_out/T0993s2_raptorx_$dtime/
cd /home/jh7x3/multicom_v1.1/test_out/T0993s2_raptorx_$dtime/

mkdir raptorx
perl /home/jh7x3/multicom_v1.1/src/meta/raptorx/script/tm_raptorx_main.pl /home/jh7x3/multicom_v1.1/src/meta/raptorx/raptorx_option_version3 /home/jh7x3/multicom_v1.1/examples/T0993s2.fasta raptorx  2>&1 | tee  /home/jh7x3/multicom_v1.1/test_out/T0993s2_raptorx_$dtime.log


printf "\nFinished.."
printf "\nCheck log file </home/jh7x3/multicom_v1.1/test_out/T0993s2_raptorx_$dtime.log>\n\n"


if [[ ! -f "/home/jh7x3/multicom_v1.1/test_out/T0993s2_raptorx_$dtime/raptorx/rapt1.pdb" ]];then 
	printf "!!!!! Failed to run raptorx, check the installation </home/jh7x3/multicom_v1.1/src/meta/raptorx/>\n\n"
else
	printf "\nJob successfully completed!"
	printf "\nResults: /home/jh7x3/multicom_v1.1/test_out/T0993s2_raptorx_$dtime/raptorx/rapt1.pdb\n\n"
fi

