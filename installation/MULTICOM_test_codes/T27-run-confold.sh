#!/bin/bash

dtime=$(date +%m%d%y)


source /home/jh7x3/multicom_v1.1/tools/python_virtualenv/bin/activate
export LD_LIBRARY_PATH=/home/jh7x3/multicom_v1.1/tools/boost_1_55_0/lib/:/home/jh7x3/multicom_v1.1/tools/OpenBLAS:$LD_LIBRARY_PATH

mkdir -p /home/jh7x3/multicom_v1.1/test_out/T0993s2_confold_$dtime/
cd /home/jh7x3/multicom_v1.1/test_out/T0993s2_confold_$dtime/

mkdir confold
sh /home/jh7x3/multicom_v1.1/src/meta/confold2/script/tm_confold2_main.sh /home/jh7x3/multicom_v1.1/src/meta/confold2/CONFOLD_option /home/jh7x3/multicom_v1.1/examples/T0993s2.fasta confold  2>&1 | tee  /home/jh7x3/multicom_v1.1/test_out/T0993s2_confold_$dtime.log


printf "\nFinished.."
printf "\nCheck log file </home/jh7x3/multicom_v1.1/test_out/T0993s2_confold_$dtime.log>\n\n"


if [[ ! -f "/home/jh7x3/multicom_v1.1/test_out/T0993s2_confold_$dtime/confold/confold2-1.pdb" ]];then 
	printf "!!!!! Failed to run confold, check the installation </home/jh7x3/multicom_v1.1/src/meta/confold2/>\n\n"
else
	printf "\nJob successfully completed!"
	printf "\nResults: /home/jh7x3/multicom_v1.1/test_out/T0993s2_confold_$dtime/confold/confold2-1.pdb\n\n"
fi

