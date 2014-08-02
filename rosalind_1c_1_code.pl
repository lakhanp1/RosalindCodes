#!usr/bin/perl -w

use strict;
use warnings;

=head
Pattern Matching Problem

In this problem, we ask a simple question: how many times can one string occur as a substring of another? Recall from “Frequent Words Problem” that different occurrences of a substring can overlap with each other. For example, ATA occurs three times in CGATATATCCATAG.
Pattern Matching Problem

Find all occurrences of a pattern in a string.

Given: Strings Pattern and Genome.

Return: All starting positions in Genome where Pattern appears as a substring.
Sample Dataset

ATAT
GATATATGCATATACTT

Sample Output

1 3 9


=cut

my $seq = "AGTACAGCCTACAGCCCGTCGATACAGCCGTACAGCCTACAGCCAGGCTACAGCCTTTACAGCCCATAGGCGCGGCTACAGCCGGTACAGCCTACAGCCTACAGCCAAGGCTACAGCCCGATACAGCCACCTTACAGCCTACAGCCTACAGCCGGTACAGCCCTACAGCCATACAGCCATACAGCCACCATATACAGCCAATACAGCCTACAGCCGTACAGCCCTACAGCCCTACAGCCTACAGCCAAATACAGCCTACAGCCTATTACAGCCCAATTTACAGCCGTTACAGCCCTTACAGCCGTTGTACAGCCTACAGCCCTACAGCCCGCGTACAGCCTTTTCTCCATACAGCCCCCTGTTACAGCCCTACAGCCTCACTTACAGCCTACAGCCAGTACAGCCATACAGCCTACAGCCGTACAGCCGTGCAGTACAGCCTACAGCCTTCTGTTACAGCCAGATACAGCCTACAGCCTGGACAATGTGAGAAAGTCCTACAGCCATACAGCCTACAGCCATCTAAGTTGGTGGTACAGCCATACAGCCGTTACAGCCCATACAGCCATAGTTACAGCCTACAGCCTACAGCCTTACAGCCGTACAGCCGTACAGCCGGTACAGCCCATACAGCCACATACAGCCGTGTGCAGTACAGCCTACAGCCTGTTCATGCTTACACGCGCTACAGCCGTCTACAGCCTTACAGCCGGTGGGGGTACAGCCCCTACAGCCTCTTACAGCCTACAGCCTGTACAGCCTTACAGCCAATACAGCCATATACAGCCTAGCAAGGGACGTACCTACAGCCGGATCCTACAGCCTACAGCCACCATGGCCTCGTTACAGCCTACAGCCCTACAGCCCTCTAGTACAGCCTACAGCCTACAGCCCATGCTACAGCCTACAGCCTTACAGCCCTACAGCCAACTTACAGCCTTACAGCCCTACAGCCCTCTTACAGCCTACAGCCATGGCTACAGCCTACAGCCTAAATACAGCCAGATTGGTACAGCCTACAGCCGTATACAGCCTACAGCCGAAAAGATACAAGTTACAGCCTACAGCCCTACAGCCAACAGCGGATTCGGATACAGCCGCCCTACAGCCTTACAGCCCGTCCTACAGCCAGGCTACAGCCCGTACAGCCATACAGCCTCTATACAGCCTACAGCCTACAGCCGAGGGGAATTGTAAATGTACAGCCGCGTTAAGCCATACAGCCTACAGCCTACAGCCCACAACTGTACAGCCAGTACAGCCTACAGCCCTACAGCCTTACAGCCGGTACAGCCTACAGCCTACAGCCATGTACAGCCGCGCTTACAGCCCGCACGGTACAGCCTTACAGCCTTTACAGCCCCTATAGGAATACAGCCTTACAGCCACGAGTATTACAGCCCATAGTTACAGCCGATACAGCCAGTTATACAGCCGAGCTATACAGCCCTACAGCCAATACAGCCGTGTACAGCCGTACAGCCGCGTACAGCCGGATACAGCCTACAGCCCGTACAGCCTACAGCCACCACTGATACAGCCTTACAGCCATACAGCCCGAATACAGCCATACAGCCATCTACAGCCTTTTTACAGCCTACAGCCCTTGCTACAGCCTTACAGCCTACAGCCATACAGCCAATACAGCCTACAGCCTACAGCCTACAGCCTAGTACAGCCACAATACAGCCGGAGTACAGCCTACAGCCCTACAGCCACTTATACAGCCTTACGTACAGCCTGGTTGAATACAGCCAGCTTGACAATAGAGATGACTACAGCCTGTTACAGCCGCTACAGCCTACAGCCTCTACAGCCTACAGCCACTACAGCCTACAGCCTACAGCCTTACAGCCGCATACAGCCTACAGCCTTACAGCCTACAGCCGCTACAGCCCTTACAGCCTACAGCCTACAGCCTCTACAGCCCCAGTTTACAGCCTTACAGCCTACAGCCGTGTACAGCCCTACAGCCTACAGCCCCTTCTCGTACAGCCTACAGCCCTACAGCCAGGTACAGCCACTGCGTACAGCCCTACAGCCTACAGCCTCCTACAGCCTACAGCCACGATACAGCCTTTACACCTACAGCCGTATACAGCCTACAGCCTACAGCCTACAGCCTCGTCGTGGATACAGCCGTTACAGCCCTACAGCCTGCTTACAGCCTTACAGCCTACAGCCATACAGCCTACAGCCCAGTACAGCCCCTACAGCCGTACAGCCCATTACAGCCGTTACAGCCTACAGCCTACAGCCGCGTGGTACAGCCATACAGCCATGGCAGCTACAGCCCTACAGCCTTACAGCCTACAGCCTTACAGCCTACAGCCATTTACAGCCGCCTACAGCCTACAGCCTTGTTACAGCCAGACTTGTACAGCCAATACAGCCTACAGCCTACAGCCTACAGCCCCTACAGCCTCGCTACAGCCGCCCGATACAGCCACGATACAGCCTCTTACAGCCTACAGCCTACAGCCGTGCTACAGCCATTACTACAGCCAAGATCGTAGCAACATACAGCCTACAGCCGGGCTACAGCCTACAGCCTTGGTACAGCCGTACAGCCGTACAGCCGCGAAGATGACCGTCTACAGCCCTACAGCCGTGTGCATACAGCCAATCTACAGCCATACAGCCTACAGCCGTTCAGTCAGCTACAGCCATTACAGCCGCGCTGACTACAGCCGGTACAGCCTACAGCCCGTACGCGTACAGCCTTACAGCCTCTACAGCCTACAGCCTACAGCCTCTATTACAGCCTACAGCCGACTAATACAGCCCTACTTTACAGCCTACAGCCTACAGCCATCTACAGCCTAGTACAGCCTACAGCCAGTACAGCCGGGTACAGCCGATACTTTCCCGCGAACTATACAGCCTACAGCCTACAGCCTACAGCCTTTACAGCCAGTCTAAATCATCTACAGCCTTGGGTGCCGTACAGCCGCTTACAGCCTACAGCCTGTGATTATACAGCCGTCGATACAGCCCGGCTACAGCCGTACAGCCTTCTCTACAGCCTACAGCCTACAGCCACCTACAGCCTTCTTACAGCCGATACAGCCTACAGCCCGTGACTACAGCCGGTACAGCCATACAGCCAATATTACAGCCCTCTACAGCCCCGCATAAGATACAGCCTTACAGCCCGATACTCTCTTTACAGCCTCTACAGCCTTTACAGCCCTCGCTACAGCCGTACAGCCTTACAGCCGAACATAGCATTACAGCCAGTACAGCCGCCCCTGGATACAGCCTCGTGCGCAGAAATACAGCCTACAGCCTACAGCCCATACAGCCTAATACAGCCTACAGCCTATATACAGCCCTACAGCCTTATACAGCCTACAGCCCTGTTACAGCCATAGTACTCATATACAGCCGTGGTACAGCCCTACAGCCTACAGCCATTACAGCCCTACAGCCTTACTACAGCCTTACAGCCGACTACAGCCGTACAGCCGCATACAGCCAGTACAGCCATCCATACAGCCTACAGCCTAGAACTGATTTTATACAGCCCAATGAATTACAGCCTCCACACAATACAGCCATTACAGCCGTACAGCCGTACAGCCTAATACAGCCTATTCATACAGCCTACAGCCCTACAGCCTACAGCCTACAGCCCCTTACAGCCAGTACAGCCTTACAGCCGTACAGCCCTTACAGCCCAGTACAGCCCAGTACAGCCTTACAGCCTTCTTACAGCCCTACAGCCTGGCTCTACAGCCGTACAGCCTACAGCCATACAGCCGTACAGCCATTAGAGTGCTCTACAGCCTACAGCCTTGCCGCACCTACAGCCTACAGCCTCGTACAGCCTACAGCCTACAGCCTACAGCCCTACAGCCTTACAGCCTACAGCCTGTTAGTTGTGGGCTACAGCCTCTACAGCCTGGGGCATACAGCCAGGTAGCTACAGCCAGGTACAGCCGGTACAGCCTACAGCCTACAGCCGTACAGCCTACAGCCGCGTTACAGCCTTACAGCCTACTCGTACAGCCTTACAGCCACTGCTACAGCCATGCTTACAGCCGTTACAGCCGCAGTCTACAGCCTCCTCTAACCGTACAGCCACTACAGCCGTACAGCCTACAGCCTACAGCCAATACAGCCTACAGCCATACAGCCCCTACAGCCACTACAGCCTACAGCCTACAGCCTGTTGCTACAGCCTTACAGCCTTCTTTTACAGCCGCATCCTCGTTAGTACAGCCATACAGCCTACAGCCTACAGCCGTACAGCCTACAGCCAGAAATACAGCCATTACAGCCTACTGTGAACTACGCGCTAACTACAGCCTACAGCCGATTCTACAGCCCTACAGCCTACAGCCCTTTACAGCCATATACAGCCCCATCACTTATACAGCCTACAGCCTGAAATTTACAGCCAGCTACAGCCTTTACAGCCGTACAGCCTGATTATACAGCCCGCAGGTTACAGCCCCTACAGCCCGTCTACAGCCTACAGCCTGAAACATGTACAGCCGACTACAGCCATACAGCCTACAGCCAAGTGGTAACCCGGGTACAGCCAAGTACAGCCCTCGCTACAGCCTACAGCCATACAGCCCTCGTAATACAGCCTACAGCCTTACAGCCCGATAAGATTACAGCCCAAGCGCTACAGCCGTCGATACAGCCTACAGCCCACCTACAGCCTAACGATTGGTACAGCCAGAAGTTTACAGCCTCTTACAGCCAGGACTACAGCCGTACAGCCTATACAGCCTGTACAGCCTACAGCCTACAGCCCACTACAGCCGATTACAGCCCTACAGCCTACAGCCCTACAGCCTCGGTACAGCCATACAGCCTACAGCCCAACTACAGCCGGGAAGATTTCTACAGCCCCTACAGCCTACAGCCTTTACAGCCACTACAGCCTACAGCCTACAGCCGGTGTCGTACAGCCTCCGTACAGCCCTACAGCCCTGCTTGCTACAGCCTGGGTTGTACAGCCTCGACCTACAGCCTACAGCCATACAGCCTAAAGGATTACAGCCTGTACAGCCTTACAGCCATACAGCCCGGTTACAGCCTACAGCCCGGTACAGCCTACAGCCTTACAGCCAGTGACTTACAGCCCTACAGCCAGCTTACAGCCAAGTACAGCCCGTATACAGCCTCTACAGCCTACAGCCAAGATACAGCCTACAGCCGCTTCTACAGCCCTACAGCCGTACAGCCTTACAGCCTCTACAGCCGACGCTTCATACAGCCACCGCCGTACAGCCCTCATACAGCCCCATACAGCCTACAGCCCGGAGGGCGATAATACAGCCTTTCTTACAGCCGTACAGCCGGTACAGCCTACAGCCATTTACAGCCTTTACAGCCTACAGCCTTACAGCCTACAGCCATACAGCCTGGCTGTACAGCCCTGTACAGCCCCACTACAGCCGTACAGCCTACAGCCGAGGGTACAGCCATACAGCCCTACAGCCTACAGCCGGGCGTACAGCCATACAGCCTACAGCCGCTCATACAGCCTACAGGGTACAGCCGCTACAGCCGGTGTGAGTACAGCCTACAGCCATACAGCCATACAGCCTACAGCCGCCCCTGAAGTACAGCCTACAGCCCCTACAGCCGGTACAGCCTACAGCCTACAGCCTACAGCCGTACAGCCATACAGCCGATACAGCCAATACAGCCGGTTACAGCCGATGCCAGCTACAGCCATCTACAGCCCGGAACTACAGCCGGCTACAGCCTACAGCCGTCTTACAGCCTACAGCCTCCATACAGCCGTACAGCCGTACAGCCGTGTTACAGCCCTACAGCCATACAGCCTACAGCCACTACAGCCTACAGCCGACAGTACAGCCGGATGTACAGCCTACAGCCCTACAGCCTGCATACAGCCTACAGCCTTACAGCCTATCAAGGGCTTACAGCCTACAGCCGTGTTTACAGCCTACAGCCTACAGCCTACAGCCAAGCGTACAGCCAACTAACATTACAGCCCATACAGCCTACAGCCCATTACAGCCTAGCCATACAGCCCGTCAGATACAGCCTCTACAGCCGATCTCATATACAGCCTGTAATACAGCCTACAGCCTACAGCCGTACAGCCGATTACAGCCCCTACAGCCTACAGCCCGTACAGCCAGTACAGCCTACAGCCATACAGCCTACAGCCTCCAGTTACAGCCTACAGCCTTTTGCTACAGCCCCTACAGCCTACAGCCCGTACAGCCGATACAGCCCTAAACGGGGTCGTTACAGCCAGTACAGCCTACAGCCTACAGCCCTACAGCCTACAGCCTACAGCCTATACAGCCGGATTGTTACAGCCTACAGCCTATACAGCCCCCATACAGCCTACAGCCTACAGCCTTACAGCCTACAGCCTACAGCCTACAGCCCTCCTACAGCCTACAGCCTTATTACAGCCTGTATGGTACAGCCAATTCCTCTCATACAGCCTACAGCCTACAGCCGTACAGCCTACAGCCGCATACAGCCTTACAGCCTTTACAGCCGTGGTACAGCCATACAGCCCTACAGCCGTACAGCCAAGTACAGCCGATACAGCCTACAGCCCCCGGCCAGCAATTACAGCCTACAGCCCATACAGCCGTACAGCCTACAGCCTATACAGCCCTACAGCCATACAGCCTCACTACAGCCTACAGCCACGGTTTTACAGCCGTACAGCCTAGATACAGCCTTACAGCCGTACAGCCTACAGCCCTACAGCCTACAGCCGTAGGCGTACAGCCCTACGTGAATACAGCCACTACAGCCGGAATACAGCCGGCGGTACAGCCATACAGCCTTTACAGCCTACAGCCTACAGCCCTACAGCCTACAGCCTACAGCCGCTTACAGCCTACAGCCGGGCGCACTTTACAGCCGCTTACAGCCTTTACAGCCGGCCTACAGCCTTCTACAGCCTACAGCCTACAGCCTGCTAATTTACAGCCTTACAGCCCCTTACAGCCCTACAGCCTTACAGCCCTATGTAGATTACAGCCCCTACAGCCGCGATATACAGCCTTACAGCCTGATACAGCCGTACAGCCTGGTACAGCCTTACAGCCATCTACAGCCTACAGCCTACAGCCTTACAGCCTACAGCCTACAGCCTACAGCCTTATACAGCCTTGTTTACAGCCTATACAGCCTACAGCCGTACAGCCTACAGCCACTACAGCCTTACAGCCTACAGCCTACAGCCTACAGCCCATTGTTACAGCCTACAGCCCTACAGCCCAATTACAGCCGAACATACAGCCTACAGCCAGGATCATACAGCCGTACAGCCTACAGCCATACAGCCGCTACAGCCTTACAGCCGTACAGCCGAGCTTACAGCCTACAGCCTACAGCCGGGTTACAGCCCTTACCGTGTCTATACAGCCAAATACAGCCTACAGCCCAGTTACAGCCCTACAGCCTACAGCCCCTTGACTACAGCCTACAGCCATACAGCCGTACAGCCAGTGAATACAGCCAGTGTGGTCTGTTTACAGCCGATGTATACAGCCTACAGCCGTATACAGCCTACAGCCTACAGCCGGCGTCTTACAGCCCGGTCTAAGTAATACAGCCGTACAGCCTACAGCCTACAGCCTATACAGCCGCATACAGCCTTACAGCCCGGTTACAGCCTACAGCCGAAGGTACAGCCGTTACAGCCTGTTTACAGCCATACAGCCGCTACAGCCTATACATGTAATACAGCCTACAGCCTACAGCCCTCTACAGCCCAATACAGCCACGCTACAGCCCGCCGATTACAGCCTACAGCCCTACAGCCCATACAGCCGTCCGATCTATCTTACAGCCTACAGCCAGTACAGCCTACAGCCCAGTACAGCCTTACAGCCTAATACAGCCAGTTACAGCCTACAGCCGTTTACAGCCATACAGCCCTACAGCCCTCTACCCGTACAGCCTTACAGCCATTACAGCCATATACAGCCTACAGCCATACAGCCTTTACAGCCCGGTTACAGCCTACAGCCTACAGCCCCTACAGCCATACAGCCCTATACAGCCTACAGCCTACAGCCTATTACAGCCTACAGCCTTACAGCCTACAGCCACCTGGGTGCTCCTTACAGCCATTACAGCCCTACAGCCGTATACAGCCGGCTCATACAGCCATACAGCCTACAGCCATATCTTTCTACAGCCTTACAGCCTACAGCCGCCTACAGCCGAATACAGCCCCTACAGCCCTACAGCCTAGCTTACAGCCATACAGCCTACAGCCCTACAGCCTAGTACAGCCATTTACAGCCGCTGTACAGCCGTACAGCCTCTACAGCCTACAGCCTACCCTACAGCCTACAGCCTCGATTACAGCCTACAGCCATTACAGCCTACAGCCCTACAGCCTGTGTACAGCCTTATCAGATAACCTTACAGCCTTACAGCCACGTCCTACAGCCCTATACAGCCACGTACAGCCATACAGCCATACAGCCATACAGCCATATAGAGTACAGCCGTGAACATACAGCCTACAGCCGAGGTTACAGCCTTTTTACAGCCCCTTACAGCCTACAGCCCACGACAAAGGGGGGTACAGCCGTCTATTACAGCCTACAGCCGATTACAGCCTATTACAGCCGTACAGCCTACAGCCTACAGCCTACAGCCATACAGCCCTACAGCCTTACAGCCCATACAGCCTGATACAGCCTACAGCCGTACAGCCTACTACAGCCGCTTCACTATTACAGCCAACATCTACAGCCCCTGGCATGTACAGCCGCGTGGACCAATACAGCCTACAGCCACTACAGCCATTACAGCCTACAGCCCGCAGGGACTTACAGCCACCTACAGCCTACAGCCTACAGCCTACAGCCTGTACAGCCTACAGCCGTACAGCCTTTCCTACAGCCCTACAGCCTACAGCCACGAAACATACAGCCATTTACAGCCACTACAGCCTACAGCCGATACAGCCTACAGCCGGGTGTGTACAGCCCACTAGTGCTACAGCCATCGATACAGCCTATATACAGCCTACAGCCTTACAGCCCCTACAGCCTGTACAGCCGGACTATACAGCCGTACAGCCTTACAGCCTACAGCCAGACTACAGCCAGTATGCTCGTACAGCCAGGTACAGCCACGGTCGTACAGCCCAAAGTACAGCCAGTGTACAGCCTACAGCCCCTACAGCCTCGGTTACAGCCTACAGCCCCTACAGCCTCAGGGAACCCTTACAGCCGGTTACAGCCGGTACAGCCCTACAGCCTACAGCCCCTGCGATACAGCCTACAGCCCACGCATACAGCCTACAGCCGTACAGCCTACAGCCTACAGCCTACAGCCTAGATACAGCCTACAGCCCGGCTACAGCCTTAGGGCTACAGCCCTAGTACAGCCCCTACAGCCAGTACAGCCTTACAGCCGATGTGCCTACAGCCATTACAGCCGTTACAGCCATACAGCCTACAGCCTACAGCCTTACAGCCATACAGCCACACTTACAGCCATACAGCCTACAGCCATACAGCCTTCTACAGCCGTACAGCCGCTACAGCCGATACAGCCCAATACAGCCATACAGCCACTAGGCAACTACAGCCCTATACAGCCAGGTACAGCCCTACAGCCTATACAGCCAAGTTCGAGCGTTACAGCCTACAGCCACTACAGCC";
my $pat = "TACAGCCTA";



while($seq=~m/(?=$pat)/g){
	print pos $seq, " ";
}