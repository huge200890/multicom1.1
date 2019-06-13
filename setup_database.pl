#!/usr/bin/perl -w
 use FileHandle; # use FileHandles instead of open(),close()
 use Cwd;
 use Cwd 'abs_path';

 # perl /home/jh7x3/multicom_v1.1/setup_database.pl
 
######################## !!! customize settings here !!! ############################
#																					#
# Set directory of multicom databases and tools								        #

$multicom_db_tools_dir = "/data/commons/MULTICOM_db_tools_v1.1/";							        
						        

######################## !!! End of customize settings !!! ##########################

######################## !!! Don't Change the code below##############

$install_dir = getcwd;
$install_dir=abs_path($install_dir);


if(!-s $install_dir)
{
	die "The multicom directory ($install_dir) is not existing, please revise the customize settings part inside the configure.pl, set the path as  your unzipped multicom directory\n";
}

if ( substr($install_dir, length($install_dir) - 1, 1) ne "/" )
{
        $install_dir .= "/";
}


print "checking whether the configuration file run in the installation folder ...";
$cur_dir = `pwd`;
chomp $cur_dir;
$configure_file = "$cur_dir/configure.pl";
if (! -f $configure_file || $install_dir ne "$cur_dir/")
{
        die "\nPlease check the installation directory setting and run the configure program under the main directory of multicom.\n";
}
print " OK!\n";


if(!-s $multicom_db_tools_dir)
{
	`mkdir $multicom_db_tools_dir`;
}
$multicom_db_tools_dir=abs_path($multicom_db_tools_dir);



if ( substr($multicom_db_tools_dir, length($multicom_db_tools_dir) - 1, 1) ne "/" )
{
        $multicom_db_tools_dir .= "/";
}

if (prompt_yn("multicom database will be installed into <$multicom_db_tools_dir> ")){

}else{
	die "The installation is cancelled!\n";
}


print "Start install multicom into <$multicom_db_tools_dir>\n"; 



chdir($multicom_db_tools_dir);

$database_dir = "$multicom_db_tools_dir/databases";
$tools_dir = "$multicom_db_tools_dir/tools";


if(!-s $database_dir)
{
	`mkdir $database_dir`;
}
if(!-s $tools_dir)
{
	`mkdir $tools_dir`;
}



=pod
nr_latest/nr
nr70_90/nr90;nr70_90/nr70
nr70_90/nr90;nr70_90/nr70
uniref/uniref90
uniref/uniref70
=cut



#### (1) Download basic databases
print("#### (1) Download basic databases\n\n");
chdir($database_dir);
$basic_db_list = "cm_lib.tar.gz;atom.tar.gz;fr_lib.tar.gz;big.tar.gz";
@basic_db = split(';',$basic_db_list);
foreach $db (@basic_db)
{
	$dbname = substr($db,0,index($db,'.tar.gz'));
	if(-e "$database_dir/$dbname/download.done")
	{
		print "\t$dbname is done!\n";
		next;
	}
	`wget http://sysbio.rnet.missouri.edu/bdm_download/multicom/databases/$db`;
	if(-e "$db")
	{
		print "\t$db is found, start extracting files......\n\n";
		`tar -zxf $db`;
		`echo 'done' > $dbname/download.done`;
		`rm $db`;
	}else{
		die "Failed to download $db from http://sysbio.rnet.missouri.edu/bdm_download/multicom/databases, please contact chengji\@missouri.edu\n";
	}
}


#### (2) Download basic tools
print("\n#### (2) Download basic tools\n\n");

chdir($tools_dir);
$basic_tools_list = "blast-2.2.17.tar.gz;blast-2.2.20.tar.gz;blast-2.2.25.tar.gz;modeller-9.16.tar.gz;tm_score2.tar.gz;tm_align2.tar.gz;clustalw1.83.tar.gz;mmseqs2.tar.gz";
@basic_tools = split(';',$basic_tools_list);
foreach $tool (@basic_tools)
{
	$toolname = substr($tool,0,index($tool,'.tar.gz'));
	if(-e "$tools_dir/$toolname/download.done")
	{
		print "\t$toolname is done!\n";
		next;
	}
	`wget http://sysbio.rnet.missouri.edu/bdm_download/multicom/tools/$tool`;
	if(-e "$tool")
	{
		print "\n\t$tool is found, start extracting files......\n\n";
		`tar -zxf $tool`;
		`echo 'done' > $toolname/download.done`;
		`rm $tool`;
	}else{
		die "Failed to download $tool from http://sysbio.rnet.missouri.edu/bdm_download/multicom/tools, please contact chengji\@missouri.edu\n";
	}
}


#### (3) Download uniref90
print("\n#### (3) Download uniref90\n\n");
$uniref_dir = "$multicom_db_tools_dir/databases/uniref";
if(!(-d "$uniref_dir"))
{
	`mkdir $uniref_dir`;
}
chdir($uniref_dir);

if(-e "uniref90.pal")
{
	print "\tuniref90 has been formatted, skip!\n";
}elsif(-e "uniref90.fasta")
{
	print "\tuniref90.fasta is found, start formating......\n";
	`$tools_dir/blast-2.2.25/bin/formatdb -i uniref90.fasta -o T -t uniref90 -n uniref90`;
}else{
	`wget ftp://ftp.uniprot.org/pub/databases/uniprot/uniref/uniref90/uniref90.fasta.gz`;
	if(-e "uniref90.fasta.gz")
	{
		print "\tuniref90.fasta.gz is found, start extracting files\n";
	}else{
		die "Failed to download uniref90.fasta.gz from ftp://ftp.uniprot.org/pub/databases/uniprot/uniref/uniref90/\n";
	}
	`gzip -d uniref90.fasta.gz`;
	`$tools_dir/blast-2.2.25/bin/formatdb -i uniref90.fasta -o T -t uniref90 -n uniref90`;

}

#### (3) Download uniref50
print("\n#### (4) Download uniref50\n\n");
$uniref_dir = "$multicom_db_tools_dir/databases/uniref";
if(!(-d "$uniref_dir"))
{
	`mkdir $uniref_dir`;
}
chdir($uniref_dir);

if(-e "uniref50.pal")
{
	print "\tuniref50 has been formatted, skip!\n";
}elsif(-e "uniref50.fasta")
{
	print "\tuniref50.fasta is found, start formating......\n";
	`$tools_dir/blast-2.2.25/bin/formatdb -i uniref50.fasta -o T -t uniref50 -n uniref50`;
}else{
	`wget ftp://ftp.uniprot.org/pub/databases/uniprot/uniref/uniref50/uniref50.fasta.gz`;
	if(-e "uniref50.fasta.gz")
	{
		print "\tuniref50.fasta.gz is found, start extracting files......\n";
	}else{
		die "Failed to download uniref50.fasta.gz from ftp://ftp.uniprot.org/pub/databases/uniprot/uniref/uniref50/\n";
	}
	`gzip -d uniref50.fasta.gz`;
	`$tools_dir/blast-2.2.25/bin/formatdb -i uniref50.fasta -o T -t uniref50 -n uniref50`;

}

#### (4) Generating uniref70
print("\n#### (4) Generating uniref70\n\n");
chdir($uniref_dir);

if(-e "uniref70.pal")
{
	print "\tuniref70 has been formatted, skip!\n";
}elsif(-e "uniref70.fasta")
{
	print "\tuniref70.fasta is found, start formating......\n";
	`$tools_dir/blast-2.2.25/bin/formatdb -i uniref70.fasta -o T -t uniref70 -n uniref70`;
}else{

	### run mmseq
	`mkdir $uniref_dir/create70`;
	chdir("$uniref_dir/create70");

	`$tools_dir/mmseqs2/bin/mmseqs createdb $uniref_dir/uniref90.fasta  uniref90`;
	`$tools_dir/mmseqs2/bin/mmseqs linclust uniref90 uniref70 tmp70 --min-seq-id 0.7`;
	`$tools_dir/mmseqs2/bin/mmseqs result2repseq uniref90 uniref70 uniref70_lin_req`;
	`$tools_dir/mmseqs2/bin/mmseqs result2flat uniref90 uniref90 uniref70_lin_req uniref70.fasta --use-fasta-header`;
	`cp uniref70.fasta $uniref_dir/uniref70.fasta`;
	`rm -rf $uniref_dir/create70`;
	
	chdir($uniref_dir);
	`$tools_dir/blast-2.2.25/bin/formatdb -i uniref70.fasta -o T -t uniref70 -n uniref70`;

}



#### (5) Generating uniref20
print("\n#### (5) Generating uniref20\n\n");
chdir($uniref_dir);

if(-e "uniref20.pal")
{
	print "\tuniref20 has been formatted, skip!\n";
}elsif(-e "uniref20.fasta")
{
	print "\tuniref20.fasta is found, start formating......\n";
	`$tools_dir/blast-2.2.25/bin/formatdb -i uniref20.fasta -o T -t uniref20 -n uniref20`;
}else{

	### run mmseq
	`mkdir $uniref_dir/create20`;
	chdir("$uniref_dir/create20");

	`$tools_dir/mmseqs2/bin/mmseqs createdb $uniref_dir/uniref50.fasta  uniref50`;
	`$tools_dir/mmseqs2/bin/mmseqs linclust uniref50 uniref20 tmp20 --min-seq-id 0.2`;
	`$tools_dir/mmseqs2/bin/mmseqs result2repseq uniref50 uniref20 uniref20_lin_req`;
	`$tools_dir/mmseqs2/bin/mmseqs result2flat uniref50 uniref50 uniref20_lin_req uniref20.fasta --use-fasta-header`;
	`cp uniref20.fasta $uniref_dir/uniref20.fasta`;
	`rm -rf $uniref_dir/create20`;
	
	chdir($uniref_dir);
	`$tools_dir/blast-2.2.25/bin/formatdb -i uniref20.fasta -o T -t uniref20 -n uniref20`;

}


#### (6) Linking databases
print("\n#### (6) Linking databases\n\n");

### linking sequence database 

-d "$database_dir/nr_latest" || `mkdir $database_dir/nr_latest`;
-d "$database_dir/nr70_90" || `mkdir $database_dir/nr70_90`;
-d "$database_dir/nr20" ||  `mkdir $database_dir/nr20`;

opendir(DBDIR,"$uniref_dir") || die "Failed to open $uniref_dir\n";
@files = readdir(DBDIR);
closedir(DBDIR);
foreach $file (@files)
{
	if($file eq '.' or $file eq '..')
	{
		next;
	}
	
	if(substr($file,0,9) eq 'uniref90.')
	{
		$subfix = substr($file,9);
		if(-l "$database_dir/nr70_90/nr90.$subfix")
		{
			`rm $database_dir/nr70_90/nr90.$subfix`; 
		}
		if($subfix eq 'pal')
		{
			## change to nr90
			open(TMP,"$uniref_dir/$file");
			open(TMPOUT,">$database_dir/nr70_90/nr90.pal");
			while(<TMP>)
			{
				$li=$_;
				chomp $li;
				if(index($li,'uniref90')>=0)
				{
					$li =~ s/uniref90/nr90/g;
					print TMPOUT "$li\n";
				}else{
					print TMPOUT "$li\n";
				}
			}
			close TMP;
			close TMPOUT;
		}else{
			`ln -s $uniref_dir/$file $database_dir/nr70_90/nr90.$subfix`;
		}
	}
	
	if(substr($file,0,9) eq 'uniref70.')
	{
		$subfix = substr($file,9);
		if(-l "$database_dir/nr70_90/nr70.$subfix")
		{
			`rm $database_dir/nr70_90/nr70.$subfix`; 
		}
		if($subfix eq 'pal')
		{
			## change to nr90
			open(TMP,"$uniref_dir/$file");
			open(TMPOUT,">$database_dir/nr70_90/nr70.pal");
			while(<TMP>)
			{
				$li=$_;
				chomp $li;
				if(index($li,'uniref70')>=0)
				{
					$li =~ s/uniref70/nr70/g;
					print TMPOUT "$li\n";
				}else{
					print TMPOUT "$li\n";
				}
			}
			close TMP;
			close TMPOUT;
		}else{
			`ln -s $uniref_dir/$file $database_dir/nr70_90/nr70.$subfix`;
		}
		
	}
	
	if(substr($file,0,9) eq 'uniref90.')
	{
		$subfix = substr($file,9);
		if(-l "$database_dir/nr_latest/nr.$subfix")
		{
			`rm $database_dir/nr_latest/nr.$subfix`; 
		}
		if($subfix eq 'pal')
		{
			## change to nr90
			open(TMP,"$uniref_dir/$file");
			open(TMPOUT,">$database_dir/nr_latest/nr.pal");
			while(<TMP>)
			{
				$li=$_;
				chomp $li;
				if(index($li,'uniref90')>=0)
				{
					$li =~ s/uniref90/nr/g;
					print TMPOUT "$li\n";
				}else{
					print TMPOUT "$li\n";
				}
			}
			close TMP;
			close TMPOUT;
		}else{
			`ln -s $uniref_dir/$file $database_dir/nr_latest/nr.$subfix`;
		}
		
	}
	
	if(substr($file,0,9) eq 'uniref20.')
	{
		$subfix = substr($file,9);
		if(-l "$database_dir/nr20/nr20.$subfix")
		{
			`rm $database_dir/nr20/nr20.$subfix`; 
		}
		if($subfix eq 'pal')
		{
			## change to nr90
			open(TMP,"$uniref_dir/$file");
			open(TMPOUT,">$database_dir/nr20/nr20.pal");
			while(<TMP>)
			{
				$li=$_;
				chomp $li;
				if(index($li,'uniref20')>=0)
				{
					$li =~ s/uniref20/nr20/g;
					print TMPOUT "$li\n";
				}else{
					print TMPOUT "$li\n";
				}
			}
			close TMP;
			close TMPOUT;
		}else{
			`ln -s $uniref_dir/$file $database_dir/nr20/nr20.$subfix`;
		}
	}
}

#### (7) Setting up tools and databases for methods
print("\n#### (7) Setting up tools and databases for methods\n\n");

$method_file = "$install_dir/method.list";
$method_info = "$install_dir/installation/server_info";

if(!(-e $method_file) or !(-e $method_info))
{
	print "\nFailed to find method file ($method_file and $method_info), please contact us!\n\n";
}else{
	
	open(IN,$method_info) || die "Failed to open file $method_info\n";
	@contents = <IN>;
	close IN;
	%method_db_tools=();
	foreach $line (@contents)
	{
		chomp $line;
		if(substr($line,0,1) eq '#')
		{
			next;
		}
		$line =~ s/^\s+|\s+$//g;
		if($line eq '')
		{
			next;
		}
		@tmp = split(':',$line);
		$method_db_tools{$tmp[0]} = $tmp[1];
	}
	
	open(IN,$method_file) || die "Failed to open file $method_file\n";
	@contents = <IN>;
	foreach $method (@contents)
	{
		chomp $method;
		if(substr($method,0,1) eq '#')
		{
			next;
		}
		$method =~ s/^\s+|\s+$//g;
		if($method eq '')
		{
			next;
		}
		if(exists($method_db_tools{"${method}_tools"}) and exists($method_db_tools{"${method}_databases"}))
		{
			print "\tSetting for method <$method>\n";
			### tools
			chdir($tools_dir);
			$basic_tools_list = $method_db_tools{"${method}_tools"};
			@basic_tools = split(';',$basic_tools_list);
			foreach $tool (@basic_tools)
			{
				$toolname = substr($tool,0,index($tool,'.tar.gz'));
				if(-e "$tools_dir/$toolname/download.done")
				{
					print "\t\t$toolname is done!\n";
					next;
				}
				`wget http://sysbio.rnet.missouri.edu/bdm_download/multicom/tools/$tool`;
				if(-e "$tool")
				{
					print "\n\t\t$tool is found, start extracting files......\n\n";
					`tar -zxf $tool`;
					`echo 'done' > $toolname/download.done`;
					`rm $tool`;
				}else{
					die "Failed to download $tool from http://sysbio.rnet.missouri.edu/bdm_download/multicom/tools, please contact chengji\@missouri.edu\n";
				}
			}
			
			### databases
			chdir($database_dir);
			$basic_db_list = $method_db_tools{"${method}_databases"};
			@basic_db = split(';',$basic_db_list);
			foreach $db (@basic_db)
			{
				$dbname = substr($db,0,index($db,'.tar.gz'));
				if(-e "$database_dir/$dbname/download.done")
				{
					print "\t\t$dbname is done!\n";
					next;
				}
				`wget http://sysbio.rnet.missouri.edu/bdm_download/multicom/databases/$db`;
				if(-e "$db")
				{
					print "\t\t$db is found, start extracting files......\n\n";
					`tar -zxf $db`;
					`echo 'done' > $dbname/download.done`;
					`rm $db`;
				}else{
					die "Failed to download $db from http://sysbio.rnet.missouri.edu/bdm_download/multicom/databases, please contact chengji\@missouri.edu\n";
				}
			}
			
		}else{
			print "Failed to find database/tool definition for method $method\n";
		}
	}
}




=pod

## optional for hhsuite
#### (4) Download uniprot30
print("\n#### (4) Download uniprot30\n\n");
$uniprot30_dir = "$multicom_db_tools_dir/databases/uniprot30";
if(!(-d "$uniprot30_dir"))
{
	`mkdir $uniprot30_dir`;
}
chdir($uniprot30_dir);

if(-e "uniclust30_2017_10/uniclust30_2017_10_hhm.ffdata")
{
	print "\tuniclust30_2017_10 has been downloaded, skip!\n";
}else{
	`wget http://wwwuser.gwdg.de/~compbiol/uniclust/2017_10/uniclust30_2017_10_hhsuite.tar.gz`;
	if(-e "uniclust30_2017_10_hhsuite.tar.gz")
	{
		print "\tuniclust30_2017_10_hhsuite.tar.gz is found, start extracting files......\n";
		`tar -zxf uniclust30_2017_10_hhsuite.tar.gz`;
		`rm uniclust30_2017_10_hhsuite.tar.gz`;
	}else{
		die "Failed to download uniclust30_2017_10_hhsuite.tar.gz from http://wwwuser.gwdg.de/~compbiol/uniclust/2017_10/\n";
	}

}


#### (5) Download uniprot20
print("\n#### (5) Download uniprot20\n\n");
$uniprot20_dir = "$multicom_db_tools_dir/databases/uniprot20";
if(!(-d "$uniprot20_dir"))
{
	`mkdir $uniprot20_dir`;
}
chdir($uniprot20_dir);

if(-e "uniprot20_2016_02/uniprot20_2016_02_hhm.ffdata")
{
	print "\tuniprot20_2016_02 has been downloaded, skip!\n";
}else{
	`wget http://wwwuser.gwdg.de/~compbiol/data/hhsuite/databases/hhsuite_dbs/old-releases/uniprot20_2016_02.tgz`;
	if(-e "uniprot20_2016_02.tgz")
	{
		print "\tuniprot20_2016_02.tgz is found, start extracting files......\n";
		`tar -xf uniprot20_2016_02.tgz`;
		`rm uniprot20_2016_02.tgz`;
	}else{
		die "Failed to download uniprot20_2016_02.tgz from http://wwwuser.gwdg.de/~compbiol/data/hhsuite/databases/hhsuite_dbs/old-releases/\n";
	}

}
=cut

print "\n\n";




sub prompt_yn {
  my ($query) = @_;
  my $answer = prompt("$query (Y/N): ");
  return lc($answer) eq 'y';
}
sub prompt {
  my ($query) = @_; # take a prompt string as argument
  local $| = 1; # activate autoflush to immediately show the prompt
  print $query;
  chomp(my $answer = <STDIN>);
  return $answer;
}





