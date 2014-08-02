#!usr/bin/perl -w

use strict;
use warnings;

=head
Clump Finding Problem

Given integers L and t, a string Pattern forms an (L, t)-clump inside a (larger) string Genome if there is an interval of Genome of length L in which Pattern appears at least t times. For example, TGCA forms a (25,3)-clump in the following Genome: gatcagcataagggtcccTGCAaTGCAtgacaagccTGCAgttgttttac.
Clump Finding Problem

Find patterns forming clumps in a string.

Given: A string Genome, and integers k, L, and t.

Return: All distinct k-mers forming (L, t)-clumps in Genome.
Sample Dataset

CGGACTCGACAGATGTGAAGAAATGTGAAGACTGAGTGAAGAGAAGAGGAAACACGACACGACATTGCGACATAATGTACGAATGTAATGTGCCTATGGC
5 75 4

Sample Output

CGACA GAAGA AATGT


=cut


my $kmer = 11;

my $seq = "CAATGAAGAGGGCTACTAGTCAGGCGCGAAGTTGGAATATGGGCGATTCCGCGCGCAATTGTAAAGCAGCGGAGAGTTAGCATTTGCAGGCCGAACTCAAGTCCGTAGTTTAAGTAGCAAGGTAACCATCATATGCAGTATGATATATGTGATCTATGAACCAAACCGTTATCCAATGACGACGATACATACTATCGAAAACGCAAATGGAACGGGCATGCGATATTCACTGTAAGGCTGTTGACCAGCAGTATCAGGAGCTAATCTAAATTGGGTTACGTGATAACGTCTCGCCTCTGCAAGCCGTGCCCGCGCTTCCAGCGAGTGTCGTGCCGGCTGAGACGTAGGCCTCAGCTTGGGAGTTTTCGGGATCGACCAAACAGAGAATAAGGAGACAAACAGAGAAAGCCACGGTCTTCATGGCACCTGGATGGGTGGTATCAACAGAAGGGCACAACACAAACAGAGAACTCAAACAGAGAAGAGAAACAGACCAAACAGAGAAAAAAACAGAGCAAACACAAACAGAGAAGAGAAGGCCACAAACAGAGAAGAAGTAGGATTGCTTTCACTTCCCAAACACAAACAGAGAATAATCATAGCTGGATCCGAAAATCAAACAGAGCAAACAGAGAAAACAGAGAATCTCCTGATCCAAACAGAGAAGCAAACAGAGAACAAACAGAGAAAACAGAGAACAAACAAACAGAGAAAACCGAATGATGAGTATAGAACTAGTTCAAACAGAGAAGCCCCGTCCACCTCGATAGTGAACCCCGATCATCGCAACGCATGTCAAAGCCAAACAGAGAATCAAACAGAGAACTGTAACTACACAAACAGAGCAAACAGAGAAAAACAGAGAAAACACAAACAGAGAACCAAGGCACAATAAAACTTAGGTTGTCCGTGAACTCGGCATATTTCGACAAACAGAGAACGTCCTCGAGAAACCGCCACGAACACGGGTACTTTTGCGTAAATGTAAACCAAATTCCCGGTATAACGAGGTGTCAAATGTGCCTGAAGAACGAGGTGTCCCTCGGTCGAGATCCACGAACGAGGAACGAGGTGTCGGTGTCCGGCAACGAGGTGTCGGTGTCAACGAGGTGTCGGAACTGCTTCTTAGGGCCAAGGAGAGACATTAAGAAACGAGGTGTCCACCTCGATACTTAACGAGGTGTCTGTCTGTTTTGGAGTACTGGTAACGAGGTGTCCGAGGTGTCAACGAGGTGTCTAATTGGCAACAGATGACTCAAAACGAGGTGTCCAGCGACGTTGGTAACGAGGTGTCCAAAACGAGGTGTCGGTGTCAACGAGGTGTCATGGCAACGAGGTGTCAACGAGGTGTCGTCCGGATCGATACGAAACGAGGTGTCCGAGGTAACGAGGTGTCCAACGAAACGAGGTGTCTTAGCCAAACGAGGTGTAACGAGAACGAGGTGTCCAGAAGGCTCCCATAGATTCAACTCATTGGTCATAATCTCATGGCGGACATGTGAATTTCCAACGAGGTGTCGTAACGAGGTGTCCAGAAGCTGAACGAGGTGTCGACATCAAGGTAACGAGGTGTCTAATAGTGGACCGTTTCCACAGTGGATCGCAGGGGGGGTTTTGGCCGAGGCTAGCGCCGCCACTTAATCACGATGGTACACAGCGCTTAAGCTATGGAAGGATTGGACGCTAGCTCGGCGGGTGCTCACGATTAGTCGATCTATGGTCGGAGCATGGGTCACCCAACACGCGAATTATGAACTCGTGTTGTACTGAAAGCGCAAATGAACACTTGACGAGGCGCCTGAACACAATCTTCCTCTGTTACAACACGCCTTCGCAGGGAATGTGCTCCGCAGCCTCTGTCGAGTTCTTTCTATCTTACGATCCTCACCCCTGGTATCAGACAAAATAATACGTAGCAACGCCTGACAATTGGCATTTTAATCAGTCGCGGAGTTAGCCAACCTCTCTAAATTGACGTCGCCCGCAGGCGAAGAAATCTTACAATGAAGAAAGCTGAGGACGGGTCCTCGCAGGGGGATTTCGTTTTGTTACACTGCCGTACGGTCTAAGCTTTTCCACAGGGTACGGGGCGACTCACCTGGCCTTAGCATTACGGTGTATGAAAACTGTAGCTCTCCATGCTGCCAGCGACGCTAATATATATTTTCGCTGCTACATACCAGCCCTAAATTGGTTCACACCAAGCTACTGGAGGTAGTGCCGGGCGCAAGATGTAATCATCCAATCCTTCCCGCTCTGGGACCACCTTAAGTCACATTCGCCTGCCCCCCCTCCAGAGTGCATCCGACACTTAACATCCCGGCGGCGTGATGTTGATGGCGAAGTCCTGTCAATTGTTGAAACACTATTTGTCCCAGTTGGCAATAGGAGATGTTTTAGAATCGCCGATTGGCTCGGTCATCTGGCCTAACAATGTGATGAGCTATCGCGGGTGGTAAGAGATAATTGAGCGGACGTGGAGCGTTAGTCTGAGTTTTCACGGCAGTCCACCCGGGCGTATCCGAGTGAGCAGACTCCCATGATTTACTTAGACTTTCGACGACGCCTTCCAGAGGAGCTGGAATTTCATCCGGGAACTGAGGGAGGAGTTACAGTTGTTCTGAACCGAGTAAATGACCGGAGGTCTGTTTGATGCGGTCAACAGATGTGGGTGCGGAGGCTCTACGTAAGGAATATAAAATGTAAATTTAAGTCTGCTGGTGTATGCTGGCCGATAAGCCCCACGAGCCCAGCTTCAAACCTACACCCCACGAGCCGCAGACGTGCACCCCGGAAAGGAACGGGTCCCCCCCCCACGCCCCCCACGAGCCACGAGCCACTCATCCCCCCCCACGAGCCGCCGCGTGTCATTCCCCACGAGCCAGCTAGGCCCCCACGAGCCCCCCCACGAGCCTACTGTAGTCTCGCCCTCCCCACGACCCCACGAGCCATTCCGTATTACAAGGGGACTTACTTTCATGAAAGGAGATTCCCCACGAGCCGCGTCGGTACCCCACGAGCCTCCGGATCCAAGTTGCCGTAGTAGCAAGTAAATGAGTACCCCACGAGCCTCGACCCCACGAGCCCGAGCCCCACGAGCCCGGTGAGCCCCCCACGAGCCCATGCGGATCCCCACGAGCCGAGCCTATTAAATGAAGCCCCACGACCCCACGAGCCGAGCCGCTCCTAGCATCCCCACGAGCCGCCCCCCACGAGCCGAGCCGTGCTACTTCCCCCACGAGCCGCCTAACCCCACGAGCCCAAGGAAACTGTTGATCCCCCACGAGCCAGCCTTGTGCGAATCTTCACGAGCCTAGAGTGGCGTTCCTAGCGCCATCGGGCTTCTAAGCACACCAATCCAACCGACGCATTGCCTTTTGATATACAATATCAGCCGGCGTTCCTCATACGCTAAGTGGGGTCGAGAGCTATGGGATGTTCGCTAGCACATCGTAATTTCGTTCCCTGCGACGTCAGAAGAAGAGAAACCTGCGGACTCGGCGTGGACAAGAGCTACGCATTTCTTATTAGCAGGCTACCATCTAAGTAAACGAGGTCGGTAATCTGGATGTAACTGTAATATGCGAGTGTAACCGCCGAATGTGTCACTGTGAGGAACTCATACAAATACAAGACTTTTGGCCAGCGTTGTGATGTTAGAACGGAGGGGTATGGCACCACACTACATCAAGGCTGAGGTTAGTAATATCGGTATTGGACGACTAATGACAACAATGACGAGACGGCTGCACTTTACTTGGTGGTCATGAAGCGCGAGCAATGAGCAACGATTGGGCACTGACGATGGTCAAGTCTACCGTAATATGTTAAGCCTAAGTCACACTTCCGTATGGAGTGGCTTCATGGTTATCAGAATTTGCCGGTATCAGGATTGACGACCTAGGTGAGGGAGCTGGAAGTTCGCCTCCTACTACGATTCTTGCGCAAAACCATATTTATCGATAACCGGACTAGTGATTAGCTGGCGGGAAAAGCATCCTATTTTCGATTGTAGAACCAGCTGAACCGCTTACTTAACTCCCGAATATTTGTATCCCGGTAGTTAAATCCAAAATCTCGGAGTGGAGGAAAAGGATTTACGGGTATCGGTTCCGGGAGACGTACTGCGTGGTAACGAAGAAGAGCAGTTTGTCCTATCAGTTAATTAGACCATGCCAAAGCCGCCGCTATTGCTTGTGTCCCGGACACGTATCTAAGAGGCTCTCCAACCGGCAGCGGGTAGTCTTGTTGGCCTACAGAGTGTCCGCGCGGAAAATTTAGCACGGTCAAGAAGTATTTGTGCAGCCTCACGATTTTGCTTGAGCCGTGCAGCCGCCCCTTTGTAAAGGGTTCCGACTTTCCCTATCACTTGGAGTTTGCGTCCCATCGCCTCGTGGGGGGTGAGGGAACAGGCGTCTCTAATAAGTGTAAATAGGGGTATGAATAAAGAATTCAATCGCAGAAGGGTGAGCCCGGGTCAGTCGAAATCGACATGTATTTCAGTCGAAATCTATCGCCGATACTCAAGCGTACTGCGGTGAAGACTATCTAGATGTAGATATCAGTCGAAATTCGCATCGCCTACTAATCATTCAGTCGAAATGAAATATCAGTCGAAATGCGGATCGTGGCCCTATTTGCAAGCTCAGTCGAAATAGTCGAAATTCAGTCTCAGTCGTCAGTCGAAATGAATCAGTCGAAATAAGACCAATTCCCTTCAGTCGAAATTGGTCAATTCCCTCAATTCCCTCAGGCAATTTCAGTCGTCAGTCGAAATCACATGAATCAGTCGAAATCCTCATAACGGTCAGTCTCAGTCGAAATCAATTCAGTCGAAATTCAGTCTCAGTCGAAATATCTCAGTCGAAATTTTCAGTCGAAATCTCATGGCAATTCCCTCATTTCAGTCGTCAGTCGAAATTCAGATAAACTCTAACTGCAATTCCCTCACCCTTCAGTCGAAATCCTCACCAATCAGTCGAAATCTCAAGTCCAACAATTCCCTCACGTGATTCAGTCGAAATCTCAGTCAGTCGAAACTAACCATTCTCATTCTATCAATTCCTAACCATTCTCCTCAATTCCCTCCTAACCATTCTATGAAGTTTCTTATACTGTTCACCCGTAGGCACCAATTCCCTCCTAACCATTCTGGATTCGCTAACCATTCTCCTACAATTCAACAATTCCCTCACCTCAGTATTTGGCTAACCATTCTCCATTCTCTGATCTACTAACCATTCTATTCTAAACTGTCTACCAATTCCCTCACTTTTCGGCCAATCTCTAACCATTCTTTCTTGTCATTGCGTGATAAATACTCTAACCCTAACCATTCTTGGCTAACCATTCTAACCATTCTCCGAATTTTCTAACCATTCTAATGCCTCTAACCATTCTGCAGCAGCCCTAACCATTCTGGCTTCCCTAACCATTCTAACCATTCTCTTAGTCTCAGGCTTATCTGGCGCAGACTAACCATTCTTCGCGGCTAACCATTCTTGGGTGCATGTAAACTCTAACCATTCTATTCTCAGGTCTAACCATTCTAACCCTAACTAACCATTCTCTAACCATTCTGTAGCCCGTACCGTACTACGAGTAACTCTAACCATTCTGAGCAGAACATGGACCAACTAGGGAAGGGCAAATTTGAAACTGGTCTTAGTGACTTGGAGATGTTAGCTATATATTAATCACCCTGTAAAAATTCAGGGATGACTGAGAGCGAATACCGGGGCGACATCTTTGGGAAACGGGTGGGGACCACGATACCGCATCCGACTCCGTGGGGTAGATTTAGCTAACTCACCAAGGTAGAGAGAAACACCTTAACGAGACTTCCACGCCGCTTATGCTAGCCTCAGCTCAATAGATGCAAAGAGGGTGTGTCGAGGTCATTGAGAAAAGGGCTTGTACACGCCAGACCGGAACTCTGCTTTTCGAAGGGTCACTTGGCGGGAGTACTCACCACGAGTGGGTCGGTTTGAGGATTGCAAGGCTCTAGACGTTTGATAGAACGACCACCTGACCTTAAAAGTCGGTTGCGCTCAGCCGTGAATTCTGTAGTCAATTGGTCCCTTGGTCATTCATTCCTAAGTGATGCCATGTGCCTGCCAAACATCTGCCGAGTACTGTATACTGTAGTACTGTAGGCACACACGCTCCAATACTGTAGGCAAACTCACTCTTTACTACTGTAGGCCCTACCGAATGTTACGATACTGTAGGCAGGTATACTGTAGTTCCTACCGAATGGCCTACCGAATGAATGGGGCAGTAGGCACAATATTTCCCATAAGATTTTTCCTACCGAATGAAGTTTCCCATAAGCCCTACCGAATGTCACCTACCGAATGTACCCTACCTACCGAATGTTTCCCATCCTACCGAATGAGGCATACTTTTCCCTACCGAATGATGCTATACCGCATGTTCCTACCGAATGTCCTACCGAATGACCGCATGTGCGCTGCTACTTTTTCCCATAAGCATGGTCCGTTTTTTCCCATAAGCCTACCGAATGATGAAGCAAGAGACCCCTACCGAATGAGATAAGCAAGCCTACCGAATGATGAAGAGAGGCCGTATACCTATCCTACCGCCCTACCGAATGGCATCCTACCGAATGACCGAATGAAGCACCTACCGAATGCCTACCGAATGATGTAGGCATACTTAAGCAAGAGATCCCTACCGAACCTACCGAATGCCGCCCCTACCGAATGAGAGACCTACCGAATGAATGGAATGCGAATGTAACCTACCTACCGAATGTAAGCAAGAGATACCTTATACCGCATGATACCGTATACCGCATGACCTTTCCCATAAGCAAGAGAGAATAATAATAAGCAAGAGACAAGAGAGCATGTAGCTTAAGCAAGAGAGCAAGAGACCGCATGATTAAGCTAAGCAATAAGCAAGAGACAAGAGAGTCTTTGTCGACTTATAGTAAGCAAGAGATATTTAGTAAATACTGGGTGCCTATTTAGTCCTATTTAGTAAGTCCTATTTATAAGCATAAGCAAGAGAAAGAGAGTAGACTAAGCTAAGCAAGAGAAGCAAGAGATTGGCGAAGATGTTGGCGAAGATGAGATGTTGGCGAAGATGGCGAAGATGTGGCGAAGATGTAGGGAGGTATACAGGGAGGTAATTTCCTATTGGCGAAGATGGCGCAGTGACGCAGTGAGTCCCGAAGATGGCAGGGAGGCGCAGTGAGTCATGCATGGCGAAGATGGAAGATGTTTAGTCGCAGTGAGTCGGCGAACGCAGTGAGTCTCCGCAGTGAGTCCGAAGATGCTGGCGCAGTCGCAGTGAGTCGTCAGGGTCGCAGTGCGCAGTGAGCGCAGTGAGTCGAGTCTCGCAGTGAGTCGGTTGGCGAAGATGCCTGGCGAAGATTGCGCAGTGAGTCAACATGTGGCGAAGATGCAGGGAGGTATTAGTAGATTTGCGCTGGCTGGCGCAGTGAGTCTTTAGTGCCGCAGTGAGTCGTCGCAGTGAGTCGAGTCCGAAGATGGTCGCAGTGAGTCGCGACGCACGCAGTGAGCGCAGTGAGTCGAAGATGTACTGACGGTTCGCAGTGAGTCTAATGGCGCAGTGACGCAGTGAGTCGTCCGAAGATGAAGATGGTATTGAATAGTGGCGAAGATGGAGCAGGGACGCAGTGAGTCTGCGCAGTGAGTCAGTGAGTCCCTACGTAGGAGCATACAATACGTCGGCGTGCCAAGCAATCAATACAGCTGTATTCGAGTAATGATGGATGGATCTATATGCAGATAGGACACTCATTTGCACTTGCTGATTACTTTGCACTGAAATAGCTACGAGACCCCTGCGGACGCTGTTCACTCAGTGTTTACCGTCTCGGGGACTTGTCCCTGTATCTGTTCCGGTAGCGAACCGGGACTTGTGTCAACATGCTACATAAGCACGACAAGGGGACAAATGGCGCGCCGTTTCGTTGTCCTTGTTATCTCAATGGGGGGATTACAGTCAACACCACAACTCCATTAAACGCTCGCTAGGCATAGGGTCCGTCCAATCCCCAGGTGGCCCCATGTAGCAGAGCTCGTTGTCGCTTCCCCAATAGTCCAGCCACCACGTCTAGCTTGTCTGAACTCCTTGGTGCCCGGTTGACGTCGTTGGCTTTTGCCGCCTCGAATCCTGTGACCCCACTGTAGTCGATCACACCCGTTTCGCGACATTTCTATGACGCACCAAGCGGCAGCCGGACAGGCATTCCTTCGTTAGCGCGTTTGAAGGCAAACGCTGCTGGAACATACATAGCAACCGTCTGCTCAGAAGGTTCCAGTCAACTTACGCGGGCGGTTCTGAGGTTGAAAAAGGCGGTAACGTCTCGAGCGGGGCTCTCACTCCAGTGATTTGATAGTCTTCACTATTTTGTCTAGTCCAGTTACGGGATCGGCAGTGCTACGGCTTTATTTTCGACCCTTCAAGATCTTACTTTAACGAAATAGGGTCGATCCCGCAGTGATCATGGCTACTCCCCCATACTGACAGGCAGCTGACAGGCAGCTGACAGGCAGCTGACAGGCAGCTGACAGGCAGCTGACAGGCAGCTGACAGGCAGCTGACAGGCAGCTGACAGGCAGCTGACAGGCAGCTGACAGGCAGCTGACAGGCAGCTGACAGGCAGCTGACAGGCAGCTGACAGGCAGCTGACAGGCAGCTGACAGGCAGCTGACAGGCAGCTGACAGGCAGCTGACAGGCAGCTGACAGGCAGCTGACAGGCAGCTGACAGGCAGCTGACAGGCAGCTGACAGGCAGCTGACAGGCAGCTGACAGGCAGCTGACAGGCAGCTGACAGGCAGCTGACAGGCAGCTGACAGGCAGCTGACAGGCAGCTGACAGGCAGCTGACAGGCAGCTGACAGGCAGCTGACAGGCAGCTGACAGGCAGCTGACAGGCAGCTGACAGGCAGCTGACAGGCAG";
my $interval = 521;
my $t = 20;

my %distinctKmers;

while($seq=~m/(?=(.{$interval}))/g){
	my $tempSeq = $1;
	#print $tempSeq,"\n";
	
	my %freq;
	while($tempSeq =~m/(?=(.{$kmer}))/g){
		$freq{$1}++;
	}
	
	foreach(keys %freq){
		if($freq{$_} == $t){
			$distinctKmers{$_}++;
		}
	}
	
	#print "\n\n";
}


print join(" ", keys %distinctKmers),"\n";
