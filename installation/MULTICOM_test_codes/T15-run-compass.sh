#!/bin/bash

dtime=$(date +%m%d%y)


mkdir -p /home/jh7x3/multicom_v1.1/test_out/T0993s2_compass_$dtime/
cd /home/jh7x3/multicom_v1.1/test_out/T0993s2_compass_$dtime/

mkdir compass
perl /home/jh7x3/multicom_v1.1/src/meta/compass/script/tm_compass_main_v2.pl /home/jh7x3/multicom_v1.1/src/meta/compass/compass_option /home/jh7x3/multicom_v1.1/examples/T0993s2.fasta compass  2>&1 | tee  /home/jh7x3/multicom_v1.1/test_out/T0993s2_compass_$dtime.log


printf "\nFinished.."
printf "\nCheck log file </home/jh7x3/multicom_v1.1/test_out/T0993s2_compass_$dtime.log>\n\n"


if [[ ! -f "/home/jh7x3/multicom_v1.1/test_out/T0993s2_compass_$dtime/compass/com1.pdb" ]];then 
	printf "!!!!! Failed to run compass, check the installation </home/jh7x3/multicom_v1.1/src/meta/compass/>\n\n"
else
	printf "\nJob successfully completed!"
	printf "\nResults: /home/jh7x3/multicom_v1.1/test_out/T0993s2_compass_$dtime/compass/com1.pdb\n\n"
fi

