#
#!usr/bin/perl -w
use strict;
use warnings;

=head
Frequent Words with Mismatches Problem


We defined a mismatch in “Approximate Pattern Matching Problem”. We now generalize “Frequent Words Problem” to incorporate mismatches as well.
Frequent Words with Mismatches Problem

Find the most frequent k-mers with mismatches in a string.

Given: A string Text as well as integers k and d.

Return: All most frequent k-mers with up to d mismatches in Text.
Sample Dataset

ACGTTGCATGTCGCATGATGCATGAGAGCT
4 1

Sample Output

GATG ATGC ATGT

Note: The algorithm for solving the Frequent Words with Mismatches Problem becomes rather slow as k and d increase. In practice, your solution should work for k = 12 and d = 3.

=cut


my $seq = "CAATTAGCCTATTGTCCTATTGTTTCTTAACAATTAGGCAGGTCTTATGTCGCTTTCTTAACCTATTGTATGTCGCTCCTATTGTCCTATTGTATGTCGCTGCAGGTCTTTTCTTAACAATTAGGCAGGTCTTTTCTTAACAATTAGATGTCGCTATGTCGCTGCAGGTCTTCAATTAGCAATTAGCAATTAGGCAGGTCTTCAATTAGCCTATTGTATGTCGCTGCAGGTCTTCAATTAGGCAGGTCTTCCTATTGTCCTATTGTGCAGGTCTTATGTCGCTTTCTTAATTCTTAAGCAGGTCTTTTCTTAATTCTTAATTCTTAATTCTTAATTCTTAATTCTTAAGCAGGTCTTCCTATTGTCCTATTGTTTCTTAACCTATTGTCCTATTGTATGTCGCTCCTATTGTATGTCGCTGCAGGTCTTATGTCGCTCCTATTGTGCAGGTCTTCAATTAGGCAGGTCTTATGTCGCTCAATTAGATGTCGCTATGTCGCTGCAGGTCTTGCAGGTCTTCCTATTGTATGTCGCTCAATTAGCAATTAGATGTCGCTCAATTAGCAATTAGATGTCGCTTTCTTAACAATTAGTTCTTAACAATTAGCAATTAGATGTCGCTGCAGGTCTTCAATTAGCCTATTGTCCTATTGTTTCTTAACAATTAGCAATTAGCCTATTGTCCTATTGTGCAGGTCTTGCAGGTCTTCAATTAGCCTATTGTGCAGGTCTTCAATTAGCAATTAGTTCTTAAATGTCGCTTTCTTAAATGTCGCTATGTCGCTTTCTTAAATGTCGCTCAATTAGCAATTAG";

my $len = 12;
my $mismatches = 3;

my %strings;
my %freqs;
my $maxFreq = 0;


my @subSeqs = ($seq=~m/(?=(\w{$len}))/g);



foreach my $probe(@subSeqs){

	#generate probes from this probe and check their freq too
	%strings = ();
	&generatePossibleProbes($probe, $mismatches);
	foreach(keys %strings){
		$freqs{$_}++;
		#print "$_\n";
		
	}
	
}


my %freqBins;

foreach(keys %freqs){
	#update the max freq
	push(@{$freqBins{$freqs{$_}}}, $_);
	
	if($freqs{$_} > $maxFreq){
		$maxFreq = $freqs{$_};
	}
	
}


print "@{$freqBins{$maxFreq}}\n";


















#find all possible strings with n mismatches for a string1
sub generatePossibleProbes{
	my $probe = shift;
	my $lim = shift;

	if($lim == 0){
		return;
	}
	
	#print $probe,"\t",$lim,"\n";
	
	my ($pre, $suf);
	for(my $i=0; $i < length $probe; $i++){
		$pre = substr($probe,0,$i);
		$suf = substr($probe,$i+1);
		
		foreach my $base('A', 'T', 'G', 'C'){
			my $kmer = $pre.$base.$suf;
						
			#print "$kmer  ";
			$strings{$kmer} = 1;
			&generatePossibleProbes($kmer, $lim-1);
			
		}
		#print "\n";
	}
	#print "\n";
}
