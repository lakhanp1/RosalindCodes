#!usr/bin/perl -w

use strict;
use warnings;

=head
Minimum Skew Problem

Define the skew of a DNA string Genome, denoted Skew(Genome), as the difference between the total number of occurrences of G and C in Genome. Let Prefixi (Genome) denote the prefix (i.e., initial substring) of Genome of length i. For example, the values of Skew(Prefixi ("CATGGGCATCGGCCATACGCC")) are:

0 -1 -1 -1 0 1 2 1 1 1 0 1 2 1 0 0 0 0 -1 0 -1 -2
Minimum Skew Problem

Find a position in a genome minimizing the skew.

Given: A DNA string Genome.

Return: All integer(s) i minimizing Skew(Prefixi (Text)) over all values of i (from 0 to |Genome|).
Sample Dataset

CCTATCGGTGGATTAGCATGTCCCTGTACGTTTCGCCGCGAACTAGTTCACACGGCTTGATGGCAAATGGTTTTTCCGGCGACCGTAATCGTCCACCGAG

Sample Output

53 97


=cut

my $seq;
open(FH, "rosalind_1e.txt") or die "Cant open file: $!\n";


while(<FH>){
	chomp;
	$seq.=$_;
}

my $gCount = 0;
my $cCount = 0;

my $flag = 0;;
my $minSkew = 0;
my @minPos = ();


#print $gCount - $cCount," ";

my $i = 0;
foreach(split(//,$seq)){
	$i++;
	if($_ eq "C"){
		$cCount++;
	}
	elsif($_ eq "G"){
		$gCount++;
	}
	my $skew = $gCount - $cCount;
	#print $skew." ";
	
	if($skew == $minSkew){
		push(@minPos, $i);
	}
	elsif($skew < $minSkew){
		@minPos = ($i);
		$minSkew = $skew;
	}
}


print "@minPos\n";
