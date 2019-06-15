#!/bin/bash

dtime=$(date +%m%d%y)


source /home/jh7x3/multicom_beta1.0/tools/python_virtualenv/bin/activate
export LD_LIBRARY_PATH=/home/jh7x3/multicom_beta1.0/tools/boost_1_55_0/lib/:/home/jh7x3/multicom_beta1.0/tools/OpenBLAS:$LD_LIBRARY_PATH


mkdir -p /home/jh7x3/multicom_beta1.0/test_out/T1006_dncon2_$dtime/
cd /home/jh7x3/multicom_beta1.0/test_out/T1006_dncon2_$dtime/
/home/jh7x3/multicom_beta1.0/tools/DNCON2/dncon2-v1.0.sh /home/jh7x3/multicom_beta1.0/examples/T1006.fasta /home/jh7x3/multicom_beta1.0/test_out/T1006_dncon2_$dtime/  2>&1 | tee  /home/jh7x3/multicom_beta1.0/test_out/T1006_dncon2_$dtime.log


printf "\nFinished.."
printf "\nCheck log file </home/jh7x3/multicom_beta1.0/test_out/T1006_dncon2_$dtime.log>\n\n"


if [[ ! -f "/home/jh7x3/multicom_beta1.0/test_out/T1006_dncon2_$dtime/T1006.dncon2.rr" ]];then 
	printf "!!!!! Failed to run DNCON2, check the installation </home/jh7x3/multicom_beta1.0/tools/DNCON2/>\n\n"
else
	printf "\nJob successfully completed!"
	printf "\nResults: /home/jh7x3/multicom_beta1.0/test_out/T1006_dncon2_$dtime/T1006.dncon2.rr\n\n"
fi

