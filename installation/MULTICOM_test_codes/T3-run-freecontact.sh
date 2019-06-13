#!/bin/bash

dtime=$(date +%m%d%y)


export LD_LIBRARY_PATH=/home/jh7x3/multicom_v1.1/tools/boost_1_55_0/lib/:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/home/jh7x3/multicom_v1.1/tools/OpenBLAS/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/home/jh7x3/multicom_v1.1/tools/DNCON2/freecontact-1.0.21/lib:$LD_LIBRARY_PATH

mkdir -p /home/jh7x3/multicom_v1.1/test_out/T0993s2_freecontact_$dtime/
cd /home/jh7x3/multicom_v1.1/test_out/T0993s2_freecontact_$dtime/
/home/jh7x3/multicom_v1.1/tools/DNCON2/freecontact-1.0.21/bin/freecontact < /home/jh7x3/multicom_v1.1/examples/T0993s2.aln > /home/jh7x3/multicom_v1.1/test_out/T0993s2_freecontact_$dtime/T0993s2.freecontact.rr

col_num=$(head -1 /home/jh7x3/multicom_v1.1/test_out/T0993s2_freecontact_$dtime/T0993s2.freecontact.rr | tr ' ' '\n' | wc -l)

if [[ $col_num != 6 ]]
then 
	printf "\n!!!!! Failed to run freecontact, check the installation </home/jh7x3/multicom_v1.1/tools/DNCON2/freecontact-1.0.21/>\n\n"
else
	printf "\nJob successfully completed!"
	printf "\nResults: /home/jh7x3/multicom_v1.1/test_out/T0993s2_freecontact_$dtime/T0993s2.freecontact.rr\n\n"
fi
