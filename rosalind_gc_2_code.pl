#!usr/bin/perl -w

use strict;
use warnings;
=head
Problem:

Computing GC Content 

The GC-content of a DNA string is given by the percentage of symbols in the string that are 'C' or 'G'. For example, the GC-content of "AGCTATAG" is 37.5%. Note that the reverse complement of any DNA string has the same GC-content.

DNA strings must be labeled when they are consolidated into a database. A commonly used method of string labeling is called FASTA format. In this format, the string is introduced by a line that begins with '>', followed by some labeling information. Subsequent lines contain the string itself; the first line to begin with '>' indicates the label of the next string.

In Rosalind's implementation, a string in FASTA format will be labeled by the ID "Rosalind_xxxx", where "xxxx" denotes a four-digit code between 0000 and 9999.

Given: At most 10 DNA strings in FASTA format (of length at most 1 kbp each).

Return: The ID of the string having the highest GC-content, followed by the GC-content of that string. Rosalind allows for a default error of 0.001 in all decimal answers unless otherwise stated; please see the note on absolute error below.

Sample Dataset:

>Rosalind_6404
CCTGCGGAAGATCGGCACTAGAATAGCCAGAACCGTTTCTCTGAGGCTTCCGGCCTTCCC
TCCCACTAATAATTCTGAGG
>Rosalind_5959
CCATCGGTAGCGCATCCTTAGTCCAATTAAGTCCCTATCCAGGCGCTCCGCCGAAGGTCT
ATATCCATTTGTCAGCAGACACGC
>Rosalind_0808
CCACCCTCGTGGTATGGCTAGGCATTCAGGAACCGGAGAACGCTTCAGACCAGCCCGGAC
TGGGAACCTGCGGGCAGTAGGTGGAAT

Sample Output:

Rosalind_0808
60.919540

=cut

my $inputFile = "input.txt";

open(FH, $inputFile) or die "Can not open file $inputFile: $!\n";

my $bestGC = 0;
my $bestGcId = undef;

my $tempId = undef;
my $tempSeq = undef;
my $counter = 0;

while(my $line = <FH>){
	chomp $line;
	if($line =~m/^>(.*)/){
		if(!$counter){
			$tempId = $1;
			$counter++;
			next;
		}
		
		#process the seq
		($bestGC,$bestGcId) = &percentGC($tempSeq, $tempId, $bestGC, $bestGcId);
		
		
		#reset all
		$tempId = $1;
		$tempSeq = undef;
		
	}
	elsif($line=~m/^\w+/){
		$tempSeq.=$line;
	}
}

($bestGC,$bestGcId) = &percentGC($tempSeq, $tempId, $bestGC, $bestGcId);


print $bestGcId,"\n",$bestGC;











sub percentGC{
	my $GcCount = 0;
	
	$_[0] =~s/([GC])/$GcCount++;$1/eg;
	
	$GcCount = ($GcCount/length $_[0])*100;
	
	if($GcCount > $_[2]){
		return ($GcCount, $tempId);
	}
	
	return ($_[2], $_[3]);
}
