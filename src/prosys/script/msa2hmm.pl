#!/usr/bin/perl -w
##########################################################################
#Use hmmbuild and hmmcalibrate to create hmm profiles from msa and query 
#input: script dir, hmmer dir, query file(fasta), query(msa), output file
#Author: Jianlin Cheng
#Date: 5/7/2005
##########################################################################
if (@ARGV != 5)
{
	die "need five parameters: script dir, hmmer dir(hmmer2.3.2), query file(fasta), query msa(from blast), output file.\n";
}
$script_dir = shift @ARGV;
$hmmer_dir = shift @ARGV;
-d $script_dir || die "can't find script dir.\n";
-d $hmmer_dir || die "can't find hmmer dir.\n";

$query_fasta = shift @ARGV;
-f $query_fasta || die "can't find query fasta file.\n";
open(QUERY, $query_fasta);
$code1 = <QUERY>;
chomp $code1; 
$code1 = substr($code1, 1);
$seq1 = <QUERY>;
chomp $seq1; 
close QUERY;

$query_msa = shift @ARGV;
-f $query_msa || die "can't find query msa file.\n";

$out_file = shift @ARGV;

#convert fasta and msa to gde format multiple alignments
system("$script_dir/msa2gde.pl $query_fasta $query_msa fasta $query_msa.fasta");

#create hmm from msa
#system("$hmmer_dir/binaries/hmmbuild $out_file $query_msa.fasta >/dev/null"); 

#allow overwriting (8/19/2005)
system("$hmmer_dir/binaries/hmmbuild -F $out_file $query_msa.fasta >/dev/null"); 
#calibrate the hmm
system("$hmmer_dir/binaries/hmmcalibrate $out_file >/dev/null");

`rm $query_msa.fasta `; 




