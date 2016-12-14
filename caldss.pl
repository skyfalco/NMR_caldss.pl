#!/usr/bin/perl
#Center Position PPM Calculator
#20161214 Revised by CPX
use strict;

my $DSSH;
my $DSSC;
my $DSSN;
my $spect;
my $BFH;
my $BFC;
my $BFN;
my $SFOH;
my $SFOC;
my $SFON;

 $DSSH = $ARGV[0];
START:
 while ($DSSH==0){
    print "Please input your DSS value:";
    $DSSH=<STDIN>;
 }
 if ($DSSH<300||$DSSH>1000){
    print "   Are you sure?\n Your DSS value = $DSSH\n";
    $DSSH=0;
    goto START;
 }
 $DSSC = $DSSH*0.25144952;
 $DSSN = $DSSH*0.10132905;
# print "which spectrometer you have used:";
# $spect = <STDIN>;
# if ($spect == 500){
#   $BFH = 500.13;
#   $BFC = 125.758;
#   $BFN = 50.678;
# }elsif($spect == 600){
#   $BFH = 600.13;
#   $BFC = 150.903;
#   $BFN = 60.811;
# }else{
#   $BFH = 800.2;
#   $BFC = 201.21;
#   $BFN = 81.08;
# }
 my $acqus = "acqus";
 open (INFILE, $acqus)||die "fail oepn acqus!";
 while (<INFILE>){
   my $line = $_;
   chomp ($line);
   if ($line =~ m/SFO1/){
     $line =~ m/\d+.\d+/;
     $SFOH = $&;
   }
   if ($line =~ m/SFO2/){
     $line =~ m/\d+.\d+/;
     $SFOC = $&;
   }
   if ($line =~ m/SFO3/){
     $line =~ m/\d+.\d+/;
     $SFON = $&;
   }
   if ($line =~ m/BF1/){
     $line =~ m/\d+.\d+/;
     $BFH =$&;
   }     
   if ($line =~ m/BF2/){
     $line =~ m/\d+.\d+/;
     $BFC =$&;
   }
   if ($line =~ m/BF3/){
     $line =~ m/\d+.\d+/;
     $BFN =$&;
   }
 } 
 #print "please input SFO1:";
 #$SFOH = <STDIN>;
 my $PPMH = ($SFOH - $DSSH)/$BFH*1000000;
 #print "please input SFO2:";
 #$SFOC = <STDIN>;
 #if ($SFOC != 0){
 my $PPMC = ($SFOC - $DSSC)/$BFC*1000000;
 #}else{
 #  $PPMC = 0;
 #}
 #print "please input SFO3:";
 #$SFON = <STDIN>;
 #if ($SFON != 0){
 my $PPMN = ($SFON - $DSSN)/$BFN*1000000;
 #}else{
 #  $PPMN = 0;
 #}
printf ("\n*** 20161214 Revised by CPX ***\n\n");
 printf ("   Center Position PPM:\n%8s,%8s,%8s",'H','C','N');
 printf "\n";
 printf ("%8.3f,%8.3f,%8.3f",$PPMH,$PPMC,$PPMN);
 printf "\n\n";
 
 close INFILE;
 
# LABEL:print "Do you want refresh your fid.com(It will overwrite your fid.com!)?(Y/N)  ";
# my $fid = <STDIN>;
# chomp ($fid);
# if ($fid eq ("Y"|"y")){
#   system "cp ~/macro/fid.com ./fid.com";
#   open (OUTFILE, "+<fid.com")||die "fail correct fid.com!";
#   my $point =0;
#   while (<OUTFILE>){
#     my $line = $_;
#     chomp ($line);
#     $PPMH =~ m/4.\d{3}/;
#     my $H = $&;
#     $PPMN =~ m/11\d{1}.\d{3}/;
#     my $N = $&;
#     $PPMC =~ m/(5|17|4)\d{1}.\d{3}/;
#     my $C = $&; 
#     if ($line =~ /xCAR/){
#        print "$line\n";
#	$line =~ s/4.\d+/$H/;
#	$line =~ s/11\d{1}.\d{3}/$N/;
#	$line =~ s/(5|4|17)\d{1}.\d{3}/$C/;
#	print "$line\n";
#	seek (OUTFILE,$point,0);
#	print OUTFILE "$line\n";
#     }
#     $point = tell(OUTFILE);
#   }
#   close OUTFILE;
# }elsif ($fid eq ("N"|"n")){
#    die;
# }else{goto LABEL;}
# LABEL1:print "Do you want refresh your nmrproc.com(It will overwrite your nmrproc.com!)?(Y/N)  ";
# my $fid1 = <STDIN>;
# chomp ($fid1);
# if ($fid1 eq ("Y"|"y")){
#   system "cp ~/macro/nmrproc.com ./nmrproc.com";
# }elsif ($fid1 eq ("N"|"n")){
#   die;
# }else{goto LABEL1;}
