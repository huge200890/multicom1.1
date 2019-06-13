#!/bin/bash

dtime=$(date +%m%d%y)


mkdir -p /home/jh7x3/multicom_v1.1/test_out/T0993s2_newblast_$dtime/
cd /home/jh7x3/multicom_v1.1/test_out/T0993s2_newblast_$dtime/

mkdir newblast
perl /home/jh7x3/multicom_v1.1/src/meta/newblast/script/newblast.pl /home/jh7x3/multicom_v1.1/src/meta/newblast/newblast_option /home/jh7x3/multicom_v1.1/examples/T0993s2.fasta newblast  2>&1 | tee  /home/jh7x3/multicom_v1.1/test_out/T0993s2_newblast_$dtime.log


printf "\nFinished.."
printf "\nCheck log file </home/jh7x3/multicom_v1.1/test_out/T0993s2_newblast_$dtime.log>\n\n"


if [[ ! -f "/home/jh7x3/multicom_v1.1/test_out/T0993s2_newblast_$dtime/newblast/newblast1.pdb" ]];then 
	printf "!!!!! Failed to run newblast, check the installation </home/jh7x3/multicom_v1.1/src/meta/newblast/>\n\n"
else
	printf "\nJob successfully completed!"
	printf "\nResults: /home/jh7x3/multicom_v1.1/test_out/T0993s2_newblast_$dtime/newblast/newblast1.pdb\n\n"
fi

