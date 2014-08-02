#!usr/bin/perl -w

use strict;
use warnings;

=head
Frequent Words Problem

This is the first problem in a collection of "code challenges" to accompany Bioinformatics Algorithms: An Active-Learning Approach by Phillip Compeau & Pavel Pevzner.

A k-mer is a string of length k. We define Count(Text, Pattern) as the number of times that a k-mer Pattern appears as a substring of Text. For example,

Count(ACAACTATGCATACTATCGGGAACTATCCT,ACTAT)=3.

We note that Count(CGATATATCCATAG, ATA) is equal to 3 (not 2) since we should account for overlapping occurrences of Pattern in Text.

We say that Pattern is a most frequent k-mer in Text if it maximizes Count(Text, Pattern) among all k-mers. For example, "ACTAT" is a most frequent 5-mer in "ACAACTATGCATCACTATCGGGAACTATCCT", and "ATA" is a most frequent 3-mer of "CGATATATCCATAG".
Frequent Words Problem

Find the most frequent k-mers in a string.

Given: A DNA string Text and an integer k.

Return: All most frequent k-mers in Text (in any order).
Sample Dataset

ACGTTGCATGTCGCATGATGCATGAGAGCT
4

Sample Output

CATG GCAT



=cut

my $seq = "CGAGACGGCAAGATGTTAAAAAAGGTACCAACGTTATCCAGCAAGATGTTAAAAAAGGTACCAAGTTAAAAAAGGTACCAAGTTAAAAAAGGTACCAAAGGTACCAACGTTATCCACGTTATCCAGCAAGATCGTTATCCAGCAAGATGTTAAAAAGTTAAAAAGTTAAAAAAGGTACCAAGCAAGATCGTTATCCAGTTAAAAAGTTAAAAACGTTATCCAGTTAAAAAGCAAGATCGAGACGGCAAGATCGAGACGGCAAGATGCAAGATGCAAGATCGTTATCCACGTTATCCACGTTATCCAGCAAGATCGTTATCCAAGGTACCAAGCAAGATGCAAGATGCAAGATGCAAGATCGTTATCCAAGGTACCAAAGGTACCAAGTTAAAAACGAGACGCGTTATCCACGAGACGCGTTATCCAAGGTACCAAAGGTACCAAGTTAAAAAGCAAGATCGAGACGCGTTATCCAGCAAGATAGGTACCAAGCAAGATAGGTACCAACGAGACGCGTTATCCACGTTATCCAAGGTACCAAGTTAAAAACGAGACGCGTTATCCAGTTAAAAAGCAAGATGTTAAAAAAGGTACCAACGTTATCCAGCAAGATGCAAGATCGAGACGCGTTATCCACGAGACGGCAAGATCGTTATCCAGTTAAAAACGTTATCCACGTTATCCACGTTATCCAGCAAGATGCAAGATGTTAAAAACGTTATCCAGTTAAAAAAGGTACCAAGCAAGATCGTTATCCAGCAAGATCGTTATCCACGTTATCCACGAGACGCGTTATCCAGTTAAAAAGCAAGATAGGTACCAACGTTATCCAGTTAAAAACGAGACG";
my $kmer = 12;

my %freq;

while($seq =~m/(?=(.{$kmer}))/g){
	$freq{$1}++;
}

my $tempFreq = 0;

foreach(sort {$freq{$b} <=> $freq{$a}}keys %freq){
	if(!$tempFreq){
		$tempFreq = $freq{$_};
		print $_," ";
		next;
	}
	
	if($freq{$_} < $tempFreq){
		last;
	}
	
	print $_," ";
	
}
