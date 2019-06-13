#!/bin/bash

dtime=$(date +%m%d%y)


mkdir -p /home/jh7x3/multicom_v1.1/test_out/T0993s2_hhsuite_$dtime/
cd /home/jh7x3/multicom_v1.1/test_out/T0993s2_hhsuite_$dtime/

mkdir hhsuite
perl /home/jh7x3/multicom_v1.1/src/meta/hhsuite/script/tm_hhsuite_main.pl /home/jh7x3/multicom_v1.1/src/meta/hhsuite/hhsuite_option /home/jh7x3/multicom_v1.1/examples/T0993s2.fasta hhsuite  2>&1 | tee  /home/jh7x3/multicom_v1.1/test_out/T0993s2_hhsuite_$dtime.log
perl /home/jh7x3/multicom_v1.1/src/meta/hhsuite/script/tm_hhsuite_main_simple.pl /home/jh7x3/multicom_v1.1/src/meta/hhsuite/super_option /home/jh7x3/multicom_v1.1/test/T0993s2.fasta hhsuite
perl /home/jh7x3/multicom_v1.1/src/meta/hhsuite/script/filter_identical_hhsuite.pl hhsuite

printf "\nFinished.."
printf "\nCheck log file </home/jh7x3/multicom_v1.1/test_out/T0993s2_hhsuite_$dtime.log>\n\n"


if [[ ! -f "/home/jh7x3/multicom_v1.1/test_out/T0993s2_hhsuite_$dtime/hhsuite/hhsuite1.pdb" ]];then 
	printf "!!!!! Failed to run hhsuite, check the installation </home/jh7x3/multicom_v1.1/src/meta/hhsuite/>\n\n"
else
	printf "\nJob successfully completed!"
	printf "\nResults: /home/jh7x3/multicom_v1.1/test_out/T0993s2_hhsuite_$dtime/hhsuite/hhsuite1.pdb\n\n"
fi

