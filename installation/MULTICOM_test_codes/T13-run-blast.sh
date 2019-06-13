#!/bin/bash

dtime=$(date +%m%d%y)


mkdir -p /home/jh7x3/multicom_v1.1/test_out/T0993s2_blast_$dtime/
cd /home/jh7x3/multicom_v1.1/test_out/T0993s2_blast_$dtime/

mkdir blast
perl /home/jh7x3/multicom_v1.1/src/meta/blast/script/main_blast_v2.pl /home/jh7x3/multicom_v1.1/src/meta/blast/cm_option_adv /home/jh7x3/multicom_v1.1/examples/T0993s2.fasta blast  2>&1 | tee  /home/jh7x3/multicom_v1.1/test_out/T0993s2_blast_$dtime.log
perl /home/jh7x3/multicom_v1.1/src/meta/hhsearch/script/tm_hhsearch_main_casp8.pl /home/jh7x3/multicom_v1.1/src/meta/hhsearch/hhsearch_option_cluster_used_in_casp8 /home/jh7x3/multicom_v1.1/examples/T0993s2.fasta blast


printf "\nFinished.."
printf "\nCheck log file </home/jh7x3/multicom_v1.1/test_out/T0993s2_blast_$dtime.log>\n\n"


if [[ ! -f "/home/jh7x3/multicom_v1.1/test_out/T0993s2_blast_$dtime/blast/hs1.pdb" ]];then 
	printf "!!!!! Failed to run blast, check the installation </home/jh7x3/multicom_v1.1/src/meta/blast/>\n\n"
else
	printf "\nJob successfully completed!"
	printf "\nResults: /home/jh7x3/multicom_v1.1/test_out/T0993s2_blast_$dtime/blast/hs1.pdb\n\n"
fi

