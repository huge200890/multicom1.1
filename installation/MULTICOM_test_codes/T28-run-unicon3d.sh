#!/bin/bash

dtime=$(date +%m%d%y)


source /home/jh7x3/multicom_beta1.0/tools/python_virtualenv/bin/activate
export LD_LIBRARY_PATH=/home/jh7x3/multicom_beta1.0/tools/boost_1_55_0/lib/:/home/jh7x3/multicom_beta1.0/tools/OpenBLAS:$LD_LIBRARY_PATH

mkdir -p /home/jh7x3/multicom_beta1.0/test_out/T1006_unicon3d_$dtime/
cd /home/jh7x3/multicom_beta1.0/test_out/T1006_unicon3d_$dtime/

mkdir unicon3d
perl /home/jh7x3/multicom_beta1.0/src/meta/unicon3d/script/tm_unicon3d_main.pl /home/jh7x3/multicom_beta1.0/src/meta/unicon3d/Unicon3D_option /home/jh7x3/multicom_beta1.0/examples/T1006.fasta unicon3d  2>&1 | tee  /home/jh7x3/multicom_beta1.0/test_out/T1006_unicon3d_$dtime.log


printf "\nFinished.."
printf "\nCheck log file </home/jh7x3/multicom_beta1.0/test_out/T1006_unicon3d_$dtime.log>\n\n"


if [[ ! -f "/home/jh7x3/multicom_beta1.0/test_out/T1006_unicon3d_$dtime/unicon3d/Unicon3d-1.pdb" ]];then 
	printf "!!!!! Failed to run unicon3d, check the installation </home/jh7x3/multicom_beta1.0/src/meta/unicon3d/>\n\n"
else
	printf "\nJob successfully completed!"
	printf "\nResults: /home/jh7x3/multicom_beta1.0/test_out/T1006_unicon3d_$dtime/unicon3d/Unicon3d-1.pdb\n\n"
fi

