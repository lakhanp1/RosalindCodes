#!usr/bin/perl -w

use strict;
use warnings;

=head
Approximate Pattern Matching Problem

We say that position i in k-mers p1 … pk and q1 … qk is a mismatch if pi ? qi. For example, CGAAT and CGGAC have two mismatches.
Approximate Pattern Matching Problem

Find all approximate occurrences of a pattern in a string.

Given: Strings Pattern and Text along with an integer d.

Return: All starting positions where Pattern appears as a substring of Text with at most d mismatches.
Sample Dataset

ATTCTGGA
CGCCCGAATCCAGAACGCATTCCCATATTTCGGGACCACTGGCCTCCACGGTACGGACGTCAATCAAATGCCTAGCGGCTTGTGGTTTCTCCTACGCTCC
3

Sample Output

6 7 26 27 78


=cut

my $seq = "CTCTGCCACTAACTTGCGCAATTTTTCTGGCCCGAACATCAACTCAGCAAGTCCGGTCGCAATATACAGTCCTCCCGCGGTTCTTTACGGAAGTCTAAAGATCATATAGGGATGGAGGCATGTGCAGAACACACTGTCGATCGCCAACACAAAATGTCCCTTCCACCTGAGGCCGCAGTACCCATGCCCGGCCTCTTCTTCAGCATAAATCGGGGGACGTGCGGGACGACGAAATAGGTACATATCAACGTTTGCGCGATGAAGAACTATGGTTCAACGCCTCGGTAACTAATGACTAAGCTTAACACAAGTGCCCACGTACGGGTTAGTGGGTTGTATTGCACTCGGGCACTAAAGGACAAAACGATCCGTCGCTGGTATTCTTAAATTGTGCCTGGACCGGTGCGAATCCTCTATGAGAGTACGGGATCATCGGAGCTGGGTTGTCGGAATAAAGAGGGGGATAGAGATTGAAAGGATCGGGATAGAAGCTGCATACATCGTCATGTGAAAAGCCGTAGTGAATACCTCACGCATAGTAATCTTGCATGAGAAATTAGTACTGGTAAGGACGTTGGCATAAATGCTTCCTTTGGTGTTCGCGCATGGGGGCGGGGTTGGTTGTTGTCAAAAAAGAATAAGCCAGACGAGACGTTTACCTAATCCACGAAGGATATTTCTTTAAACGGCCCGCAGGTTAGCGCAAGTGTGGTTCCCTCAACTCGACTGTTGACGTTGTTCGGTGCAAGGTAAAGGTCAGTGAGGGATGTTAAGGACAATGTCGCGATAGCGAATGTATGTGTGTTGTGTGTTCGTAGCGAGCATTCGGGGCGATGACCTGCTGCTGACAAGGGATCCGAGATGCGCACCAACGATACCGGTTTGGCCACACGGTATATGGGAAACCGCAAAGATCCTAGAATCTTGCAACGTAAAGAGGGTTGCCGTTCACGAACTGGAGGGATGTGCTCCACGGGTTCCTCCGTCCGGACTACTACTTATAGAGGACCACCACTAGACGGATTATAAGTGTACGTTGTCAGATGCCGATCCTTCAACAGGGGACGTACTCCGAGGCAACTCCCATGTCATGCTAGCCCACGCCTAAGCTTAGGTTATCGCACTCCCAATGAAAAGCAAACGGCTACAGTTTCCATAAGGGTGGGCAGTTTCGCTGATAACCGGGCCTGTAGATATGCATTGGTAAGGGTCTGTTCCACCTCCGCACTGCGTGGTATCCTTCCAGTGGCCGTTCCACGATCAAGCAGCGGCCTAAATGTATTACACGATCAACGCTTAGACGGCCGACCGCGTGGACAACACGTTTCCTCAGTTTGGGAGGGTTCAAACTGCCTATTTTGTCATCAGGACCACCCGTACGCGCCCCGAGCTTAGCACGTCCAGGGCAATAATTAGTTGTGTAAAGCAGCCTTGGGTGTCATTTCATAACACACTCTTGAGCATCCAGAGTAACTAATCGTCAATATGCGGCATGCCCGCTGGGATCTTTCTCTGTATGTAAAGTGCACAGAGTGAAGTTACACCTATGGAAGTACGCAGCAGCGAACCCGTCACTGACACTGCAGATTCCCGGCTAGATTTGTTCTGGGACGGACCAAAACATTTCGGGAACCGGGCTCATATACCCGGCTCATCGTTAGTTCTACTTAGTCTGCCGCCAGCACTACGGTCATGCTGGTAGACTCGAGTATCTGCTACCGTCCAGGTTTGACTCAGGGCACTCTAGGGTATCATACCGCGAAGCATAGCCTCCAAGTTCTGAGTCTGCGCAATTGATCTGGGAGGTCGGACCGAAGTTAACTGGACGCTCTAGGCGAATTGGCGACCTGTACGCCAGTACAGCAACTAACCAAGTGGCTCCTCGATTGCTTTGCGTGCAACTTATCCCATACTGCTGCTGGGTACCGATACGCGCAATCGAAGAAATATCATCGTACCAGCATAATGCAACCCGAGTTAGATAAGGGGGAAAACTCGGAACATACTGGCTGATGTAAGCGGCAAGAAGAACTTCCGAAAATCCTTAATTCAGCTTGACTCTGCGTTGACTGTTGTAGTCCCCCAATAACTCCTTCCCACATCAGATGCTGCATATAAGCTTTTTATACGAAAGCACCTATCAGGCGACACAAGATTATTTTCATTGGGAGATTATTTCCCCGACCTTGACGATAGGCATTAAAAGCGCGATCTTTACAGAACCCCTTTCCAGTTGGTGTGCCTTCTTACCGGTCTGTGCAGAAACTGACAATCTCCTGGTGATCCGTCTGTACAAATTTCCAACTATATCGTTTGAGGCGTAAGCAAACTATAGACCCTGCTGATTAGGAGAAGCTTACCGGATTCGAGTAACTCTAGAACACTGTGAGGATACGACGCTCCGATAGGATGTATTAATTATCCGATGATGTCGAGTAGAAATCTTAACGGTGCCGATTGACCAAGGTGACTCAGGTAAATCGAGTTTATGACGTCAACTATGACCTGAGACGGGGCAGATCTCAGGGCACTACTGCTCAGCACTAAGTCGAGACAAGCGTATTTCATCGATGTAGAATCTGCTGTCTGTCGAATAGTAGTATCGGACCTGCCAGGTGCTGTACGGGAGCTCGACAGAAAAAATGAAGTGGTATCTGGTACGTAGCTGAGCAGTATAGTTTACATACAGGATTCGCCTAAACTTGACATCTGTTGCACAGATCCAGTAGAATCCCGATTGCCTTATAGCTATTACCCCGGTCAGCGTGAGGATGACGAGATCCAGTGTATAGAGCTTCCCCGCAGATCTACACAGGACAGTCGACACTGCGGGACATCTCGGCGGTAGTGTCATCCACGCAGGCCCATACTTATGCGTCCCGGGTACGAACAATAGGTCGCAATCACACGCACTGCTTAATGAGAAGAAATTCATTACTGGAAGTCCCTTGTTCAAAGGAACGATAGCCCTCCGTCGGGCAACGACCGTTTCCCCAAAGAGATACTCCCCTTTCCGAACCACTAGAGCTACGGCCGGTTACCTCTGGGAGGAATGGCACCTCAAAGGTTAAGTCACGGGGACGGTAGAGGTCCTGCCGTGCTTTTTGTCGGAAAAGGGCTCCCGGTAGTTGTTCATACGAGCACCAGCTCTCGATAAGTGTATGAGTGCCGGCATGCCTTTGACCTGGTACCTTATGCAGCAATGTCGTCTTTTCTATTACTGCCCACCCAGCGCCCAATATTAACAAGCGATAAATGATCTATTACTCCGATGATCCCTGCTAGTTCTAGTAATGCACTTGGTGGAAGCCCATAGTTCTGACTTTGCAAACTCAGACATCTTGGCAAAAACCTGTATACCCGCATTTATCCCCTGGCATAGTTAGTGCAGCGGTCAGTCGTCACCCAGCACCATCTGCTCCCTGTTCGTTGATGCTCCTAGAGCGCCATGGCGAGAGGATGCGGACGTAATTAGGGGATTCAATTGAATTTGGCGGATGGCGTAAGTTTACGTTCCCCGAGTGCTGAATCGACTGCAGCCAAAGGGGATGGAAAAGGGTGGGAGGGCTCTCGGAATGGTCGCTCTTATGACCAAACTCATTACAGCCATCGAGGTCCTCGATGTGGGCGAGCTTCCTCGCCGAGCTATTAAAGTATACCGAGAGATCCAGTGACATGGCTTACTTATAAACCTCCAGGGTCTCGACCAAGTCTTTATAGGCAAGTCTAAAGCGATAAGTCCGTGCTCTTTGAGCCCTTCAACCGTCACTAACGAGTTTAAGATTATAACACTGACTCACTATGCACCATCCGTCCGCACGCTTCAAGGAGAAGAGTCAAAACCTAGGTGTATTTGTTGGCTCTTCAGGTGGTTCTGTGTAGAACTGGAAGCATAGAAATGCCCCGTACAAGAAGGGCATGCGAAGGCCCATTAATAGAATGCAGTCGAGGCCCTTCATGAACGGCTTCACCGCCTGGGGCAAGGAGACAAAGCTGGTTTTTGCGACGGACCGAATCGTTTCTGTCGATGGAAAATAACTCCAATGACAATAGAAACTTGTGGCTGGCCCACTATGTACGTATAAATCAAGACCGAGCTTCATAGTGAATTGCGTGGTTTCTAGGTGGCGCCATTCTCGCCCATGGATACTCGGGTTGAGTGGGATAGATGCCAAGCGATCGGGGACTGGGGCCGCACAGCTGGCTGCTGGTTCGCAATCTGGAACCGCACCTTTCTGCGTACCGCTAAGCAATCCCCCCGTAGGTAGTCTAATACATGGTCGCGGAGACTGTATAAATATCCCAGTGTGCCCTAGGTTCGCGATTGCACCTTTGGGAACTGCACCCACTTATCCGGTCCAGCGGTGCGTTGTGCGATACCTTGACCCAAAGAGCTGGTTTGTCACATACTAACCCTAGAACCTTGATCATCCATACCGCAATTTGTTTACAGTCTTCTTAAGATTCACACTGCTTCAGGGCACCAGAGTCTGTTCCAGCGGAGTTGTACGAGGACGGGTGCTTGTAATATCTCAATTTAATTGTGGGGGAGGGACATCCGAGTATCAAGGCCCTGAGACGAGGAGCCTACCACACGAACCAAACAGGGATCCTATTTAGGAGTACCTAAGTTGGGTTCATATCTTCTCGTATAGGGAGAGCTGCACGTATCTAATGGGAGTTTTCAAGTATCGGCAACCGCATTGGAAAGAACAAGATCCGCAAGGAGGGAAAGGTGTTGGAGACTTTGCATAAGGTCCCTGCCCGAAGTCGCCTAGCGCACGTGCGTCTTGGTGCGACAACGCTCGTGGCGAGCCCGACCGCAGAGTGCGAACCATCCCCTCATATGAGATTATGTATAGCCGGTCGGCCCACACGGGAGGGTGTAGTAGGTGCAGTGCATTTCGAGCAGTCAAGTCGCTTTTGAGATCAAAGAAGGTCTGAGCAATAAGTGGAAAGGGGTGCTCGGTTTTCGAGGAGATAGCAAGGAGGCTGGCCCTTCGGAATTGGGCAGCTGGGCGCAACGAGACGGTGCCATTCTGTTCGTACCGCGAGTACCCACCGGGGCTGATCGATCGAAGACCGCCCGGTTGGCCCAGCGCCGTTTGATGACGTCCCCAGAAATCTACATTCTTGACTATATTCCGACTGCGTGACCAACAATAGCCCCGTACTCTGAGAATTGAAGAACGTAAACGAAGTCTAATCCATGCGAGCGCCTTAGATACAGAGGCGGCTGCGCGCAGCTGCTTCCTACCATAGATGAGAGCGCCGTCCCGAGGCCATCCGTCCACAGAACGTAGTCTCCTGAGCGAAAGCGGATGCTCTGGAATCTGCTATCGTTCCGCCAGATACGGCTCTCTTAAGGTACGGTCACGCAACATAACATCTGGAGGGCTAATAATGCCCTAGATGATACCTCTCGACGAGGAAACATCGAAGGCGTGATACTTGTTGGTGAGTTGACTGTTTTGTAGGTCTCTTTCGCGATTACGTACTGTTGAAACGGTTACTAGTAAAGAGGTCGGGAGAACAGTTACCCGGCGCCATTGCATTCACTCAAGAACATGACAACTCTCTCCTAACACATTACGATAGATGCATAGTATTACCGCACACTAGGCCCTGGCTCTCGAAAATTAACACGCTGCCCAATGTTTGTGAAGTCCTCGAACATCTTGCACGCATGTCGGGTTTCTAATGACTTCGTTCGTGAGCATATACCGTCCTTGCTATATATTTAAAGTCAAGTGATATCGGACGCGTTTGCGAGTTCTTGCATTCGCTCATATTCTCATCCTCGAAATCCTGTGCGGAGCTTGATCATACTGTTACATCGCTTGTGTACTATTGGAGAGCTCGTTTGTGAGGACTCCTCTGAATCTCTCTGCTTACGACTTCTTCATGTCATGAACAACGACATATTCTTGTGGAGAAGCGAGTCCGAGCCTGCTAACCACTCTGTAGCCTGTCTAATAAGGATACCTATGTATGGAGCCAGGCACGACCACTCCACTGCCTAGTGCTCGCGAAGGCGGTTTCCTCGTGGATTGCTACACGCGAACTCGTACTCCTCCTTAGGTACACCTGCATCAGGCAGGGCAAATACCACTTGTTAGGATCGGGCGAAACTTGCGAACCTGAGCCCCAGGTTATGAGCATGTAGTTTCCGAGGAACCTCGCAGCTGCCAAATAACTAGGCGGTTCGAGAGCACACATCGCCAGGCCTCATAGTTACATTCACGTCTTGTAAACTGTCCAGCAGGATTTGAATACTAAACTTACGCGTTTATACTGTCGGCAAGCGTGGGTAATGCACCCTGCCTGCTTGGGCAATCTTTTGCGTACGCCGTTATTTAATGAGCACATCCTTGTTGGCTGTGGGTAAAAGTCACTGATTCACGTTATAGTGTTCGAATGAGTATCATGGTAACTAGCACGAAGAACTAATTCCGCTCTGTTGTGGATCGGATGCACGTCACTTCGGCCGTCGCAGGCACTGGAATTCGGCTGCATATGTATATACGTTGATCTTCTGAGATCTGAGAGCTACGGAGTGATCCCATTCGCTAAGACGTGGATGATTTCTCTAAACCTTACAGTGGCGCCACCCCGACTTTTTTTAGTAGCCGTACTGGCCCTCCAACCAGGAATCCCTGATGAGTTTAACGGCAATGTAATGCCTCAGCTCGAGAAGGATGGATTGGCAAGTGGGCTAGGGTTGGGTTACCGGCTCGTATGCTCCACACGAAGTTTATTGCCCTCGGATAACATCCAGCATTTCGGTCGGTAGAGCAAGAGCATTATTAGTACGCCGCATCAACTGTCACTGAACGAGAAGACGGAAATGCGCTGAGACCATTCATGCCCCATGCGGATTTTCCTTGGAATACTCTTACTGCTTGCGTCCACACTTTAGGAAAATGGTGTCGATCGTATAAAGGCATTCTTCTTAAAATATCATATGGTACAGTAGTCATCCCGCTATAAGTGAAGGTCAGCTGCCCAGGCACGTATCTGTACAAACATCACGAACCTTGTCTGTGGCAAGCCGACAGAGGTCCGGCCCCATTCGCCAACTCAACTGACTCAAAATTTCTCCTCTGCCAGATAGAGTTGCATGAGCTCTACTTTGCCCATAACACATCGGTCCTAACGCATGGCGTAACCGAAACCCGAGTACAAGTGCTATGGATCCGTTGTAAGTGGTGTGGATAAGCCTTAGGACAAAGTATCTAATTCATTCTCTTCGAAAGCGTGCAATCAAGCCACCGTTCGAATCACCCGCCTAGACTAAAGTTTATGACGTTGACAGCCCGCGCACTAGCATCTGGACTAGCCTCGGCGTAGACTGAGTGCGGCTGCGCTCGTGTGGTGATGTCACATTTACTGGATATAACTCTGTTCTCCAGCGACGGCACAGTAACCAATTTGGGCTTGCTGTTTGGAGTTGCTCATTGTAGACCTGGACTTTATTGAAGCCGCTCCCTCGGGGTTAGCCGCATACGACTTCCCTCTCTGTCTCCTCTGTTTTTTTTCCGCCTAACATATGCGAGTTCATAGGGCGCGCGCTACTCGATGAGCATAAACACAGGAAGTTGCTGGCGGAGGGCTAAGGGTGTATAGACAGGCCTGCCAGCAAAATTACTATCCCTCCTGACTAAGCCTCCAAGTCAGTATCTAGCCATTGGCTGTCCGCGCGTTTGACGTGTTTGAAGTAGACATGTCGTACTCTACCGAAAGCCGATGATACGGTTGTAAGTAGAACCTCTTTCGTAGTAACCCCAGGACGAATGTCTACGATAGTACTGACACTCTAGGAGTGAGCACAAAGGCTTCGTCCTTGTCCCATTTAACCGACTCGCAGCCGGCCTGTAGTGTTCCCTAACCCCGAAGCCTTCAGTTTCATCCTCGACGCACTTGACCAAGGCGTAACACTGCGGATTCCCGGCTGATGGGCAGGTTTGCCGACGTTATAGGTTGGGATCTTAAGACTGCGACAGGTTAAGTCAAGAACACTTAGATCAATGTTTCTAGTGTTAATTCAAGGTCCACACCCGCATATCCTGTCATGTAGCTTGTAGAGACGACCACCCTTCCCGAACCATCCCTCGCCGTTCTTTGTACTATGTGGCGAAGAGTGGGGATCCTCCGCTGTCCAGATCCGCCTGTCGCTAACCTCGACATGCCTCTCTAAAAGTGTTGGAGGGATTACATCATTAGTGAAAAAAGTGGCCGAAACAATTACATTGCGGTGAGACTATCATACGCTCGTTCTAGTCGACCGCCGGAAGCGACCAGGCCGGATGCCTCCCGGGGGACCAGAGGTTGAGCAACGGCACAATATTGGTTACGGAAAGCAGAAGCTGAAATGAGTTGCGCACACGTGCGCACCCTCCGCGTTAAAGACACTCACAATATGGACTCTGGCGCGTATGCGCACGGGATGTGAATTTCCGGTAATGGAACACAATCTCTTGACACCTTCCTCGAATGTAACCTGGCTGGGTCCAGCAATTACTTTCCCTTGGGCGTCTTCGTCTTACACAAACAGGCTCGATCCTAGGTCGATTGGAGATGAGACAATAGGTGGCTGAGGTGCTGCCTCAATCGAATTGTTTACCCCACCACCGTGTCTGAATTCGCGGCACTTAACCCAGAAACGGGTTAAACCATCCTAGGAGAATATTTTGCTCACGTCGCGAAGCAAAAATCGCCAGGGATGAACCTTCCAGAAACGACTCCTGGTGACTCGGATACAGTCTGCCTGTCCACCAGGCAATACCTCGGAAATTTATCTCATTTATTCCCCCCGCCCTGGGTCGACATCAGCAGTGGAAGCTACCGCGACTCTTTGCTAGACTCTTGGAGTGACTCCATTTGTTCCCTACGGAGCGCGACTAGAAGATCATCCCCTAGTGTTCGGGACGATATGCGTCATAACCTGACTATCTTCGTGCGAAACCCTGACACGGCTTAAAGACACCATAAGATAGACACGCCTGGACCGCTTGGAATAAGATGGATACACCACCCACAAACCAGACAGCAAATCTACAGTAGGTGGTTTGGCTCCTATCAGTTCCAAGACCTGCAGATGCAAGATCTCCGTAAGACTTGACACCTTTAGTGCTTTTTCGAATTTTAGGATCATCGTAGACTCTCGGCTGCGCGTCCCGCTAGTTTACATGAGGTCGTTGAGACGGCCTCTATGTACATTGGTAGACTTACCGTGAGTTACGGCTCGTATTGTACGTTTCCATTTTCCAACATACGTCCCGACTACGGCCGGGACGCCCGACTTGCATTCTTGGGACAAGGGAAAGTTTCTATGGCTCAAGATGGTGAACACAAAGGGCAGCGCGCCCCTAGGATATCTAGTAGTTACCACGCAGACACCTATGATTAGTGACCGAGATGTTTAGGACACGGTGGGTTCAGAACTAACGTGCTTACAGGAGATGACCAATCACTTAGGATTTTTTACACGACAGTGGTCGCGAATTATATTTCCTCAAACTTACCGAGAACGGTCCTCTAAGGGACGCATATTTCACGCTCCAGCTAGGGATTCATATGGAATCACTTTACTGATCTAGGTTGTTGCCAACCCGGTACGCCAGCCGGTGCAACTAGAGCCGGATACCTTGCCTAGGATTACCCAGCGTCGCGAGTGAGGTTCCTTAAAGCCACGCTGGCGCATCAGCCTCCGGGGGAACCACTTGCTCACGGCGAGACATATCATATCTCGGGAAACGGCCAGGTTTTACGGGGAAACCCCTGCGTCATAATCCTTCAGGCGTGTTGGCCGTTACAACGATGAACCAACCCACGCAAGAGCGGCGATCATCGCGTCGAAGAATGGGCTCCTTTATCGCTAGTCTGGTAGTCTCAATAATTTTCGCATTCACTTCCCTTGTAAATTGCATGAATCCAACCCTAGGGAAGTTTGGATATCAACTAAATCGCAGTTTCATGCCCTTGGGATTTTATGCGGCGGTGCGCTCAGGAATGAATTAGTACTATTAACACGTTTCCACAGCGGACCGAGCGTCGTGTGGGTGCTAGTTTGCACTTCTGGCGGCTCATTTCGTCTCTAAGTGATTTCACTATTTGGAGCACAGTCAACAAACTCGGCGAGGTACCGTAATGACATAACCTGGAGAGGACAAAGCTTGTGAAGTTATCGATAAAGTGATGTGGCAATTGGGAAAGGTCTAACTACGGATGAAGCTAGTCGTATGCGTGATTGCATATAAACGTATCACCTAAAGCTAGGCCTTGCGCGCGGCGTGCAACTGAGGCCAGCTCCCAACAATGCCGAAGCCGGAACCCTGGGTGACCCGACTTAAGTTCCGCGAATCTACGCCCTAAAGATTGACAAACGTCAACTTGATTAATAATGTACCGACAGGCACCGCATTTGGAGAAAGTTAACTATCGAAAATGCCAAGTTAGAATCGCGTGTATTCTGGTAAACCTACGGACTCACACCAATACCCTGTAAACAAAGCACAAGGCCATAGAGGCACCGCATGAGCCGATGCGTAACCCATACGCAATGCAACAACTACGAGCCAGACCTGGCACCGAGTGTTGCTGTTTATTTTGTCCTTGTTTGCCATGCCCATGATTAGACCCAGCAAACAGAGAACCAGCCTCTCTACGTGTTGAGTTATCTCTTACGACCTCTATACCGGGTGGTCGGTCTAAAGATTCTGGATACTCCTTTGGCCATGCTCACCGCATCGTGGGTTTCCACTGTACGGGTATAGCCAGAATCTAGTGGACCAGTTCCTCCTCGGACTGTCTTATGGTAGATGAGCTAGCAACGACGCCCTACTAGGCCATGGGTGATGAGTAACCGGACATTTTACGTCAAATGAATTCGACCACGTCGAGGATCGTAGACCGGCCCACGTTAATATATGCGACGCAACGGCTTCAAAAGGCTGGGAGGGATACGAAAACGGAGAGGTCGCTTACGGAACTAGCTTTTTGGTCGTACTGGAACAATTTCCCCACTCATCAAATCTTGGAGCGCCCAACCTGCATTGGAGTTGACCTGCATGAATTGACACCGTGTGTGAGAGGACCGGCGCCATTTCGACGATGGAATAGGGCTAGCGATCGAAGAGGAATAGCAACATAGGAGGATGTCGCGCTACCTTGCGGTTGGATGCAAATAGTAGATTTGCGTTGACGAGGGGTAACGGTGCACGCCACAGCGCAACTATATAGTTGTATGAGGACTGTTGGTGAAGCGCATGTTACGTAGACTACCACGACACATAGAGTATACGACTTTATGGACCACATCGGCAAAAGATGCCTGCCAGCGACTACGCGGATATACGAACGCTAGTGCTTGCGTGTTCTGAGCCCTAGTATTCGGCATGCGTTAAGCAGTAAGCAAGCTGCCCTTGTCCTTGTAAAAAATGTCTTAGCGAGCCTCTCGAGATCGCCAACATATGCGAAGGCAGTAACTTTGACTCAACGCTAGCGGACCCTCTACGGGATTCACAGTCATCCCTGCGAAACATAAATGCTTACAGAAGTTTCCCCACTAGCCTGTGGACCTCTCAAGGCTTATGACGCTGATCTTCACATGTCCGCCCATGTGGATACACGGGCGACATAGGCCAATTGACGCGGTGCAGTCACAGGCCAGGCCTACGGACCACCTGTAGGAATAACCATTAAAGTCTGCGGGAGGTCTCCTCAGTGCTCAGCGGCCTCACGATCGCCACTACCCAGATAAGGGCGGACTCGCGAGCATAGACCCCGGGTTTACTAGTATCGCACTTAACCAGATGCCTTTTCTTGTCATTCAGGGTGAAAATCGCATGCGAATTTTTTGAGTGTCTACCGTAACACGGGGGGCAGCAATCGTCTGATGTACAGTCAGCCTCCAGGATGCAAGCTTAGTGAATTTGTATACGTAGTGATTGTGTATCTCCGTGGTCATCACGTCTTATTAGGTTGCCCCTTAAAATAACCCAAATTCTATTTAGATTGTGTAGTACTGGCAATATACTAATCCACAGGCATATGTTAAGCACTCTTAAAGGACATGGGATACCTTATGAAGCATTCCCTAAGTTGCGGGTGCTGTAATTGGCAGTGACGTCCCCACCTAGGGAGAAGCGATGGCTGGCGTCGCGCTAAGCTCCTATATTGAGAACTAGACTGTACAACTAAGTCGTTGAGGAACGTGGTATTGCTAGTACGGGCAAAGACTACCGGACTGCCACGATAACCCCCCGTTTGCACCGTTAGACAGTTCGCACCCATATACTACCCAAGAACTGTCGGGACCGACCCGCTGCAAAGGGGTCATCCGCGCCAACGGTTGGCCTATCTCCCCCATTAGCGGATCCGGTCTGCTGACCGTAAGCGCTCGAACTGAGCAGGGATAGAAATGAATAAGGGTTATGACGCGCCGGCGACGGCCGTTCGACCGTAATTACAACCTTGTATGCTCATCTTCTGCATACTCTAGTCTCTGCCATCAGGGACCGGAATGCGCTTCCCATTAAACTCATGGGGCGCTCGCAAAGCCGTCCGCCGATCAGGGCCACTTACTGATAACAACGGTACAAGCATGACGCATTAAAGAGCCCTTGCGGCGATTGAGTCCTTAAGAAAGGGAATCCAAGTAGCAAAGCAAGTTCCAATTTTAACACCTGCAGACGGGCCACTGAGCCGTGGCTGAGAGGATCGGCGATTGAAATCCGCTAGTCTGTCGCATGGTCTTCGTGTTATGGTATATGTCCCAGCGGCTACTTTAGCAGGTCAAATGAACTATTTCATGCGTTGAACCATCTGTACTTCAGCTAGAACTGGGGGGGTTATCGGCCAGGAGCCACCACCGGCATGACTGTATTAGCTCCATCAGGTAGTTCGAACCGGTAACCGACCCCTAGCCAGCGAGTGACTCGGACCGGTCGTGGATTCTGAACTCACGCTCCTCTGTTTTGAGTCCCTTGAATCAATAGAATAAGTCCTCATCTCCATGCGGTGTGCCTCTCGCAAGTCGTACCAAAACGAGGCGAATGCGTATTAGCATGGTTTTGATCACGGAGATGCTGCATATAACTAGACTTTGATCGATGGGTCACGAAATACTCGATTACGGCGCAGATCTGTGGGGAGAGAACCGAGTCCCAAGTGAGGTGGTGTCCTGCTGCCGGTTCTCACCAATGATGGCCACATAGGAAACGTTCGTCCGAAACTGGCCATTCCCACCGGTAGCATTTGAGATTAAATAGATAGTCTGCAAGCACACCCGGCCAACACCGGCTACCCGGTTGCCCTTATTGCGAGCAGGACGATTGTCCAGTCTGGCTTTTCAAACGATTAAGTACTGTCGGACTCCCCATCGACATCAATTATACACCGCGTAGCAGGAGCGAAGTGGGCGTAGTTGTAATCATAGGTCGAAGCCAAGTTCGGACGTGGATAGTAACCAACTAAGATGTCCTCAATCACCTAACAGACCTCTCTAGGTTAATCCCCGGTATTTTCACGCCCCTCGTCATCGCAAAAAGGCCCGGGAACAAATCTTATTAAAGTCATCTGCTTAACGGTACGGAACTTTGGTGAGGGTGGGTCGGCGAAGCGCTGGTTAACGAAGCGGCGGATCAGTGCTGGCTCGCTTTATAGAACCAGCGCGCGTAAGTTCTAGAGGGCGGTTGTTCTTATGTACACCGGCCATGAACCCCGCTGCTCACCATGCTCTAACAGTACGCGTAGTGTAAGTAACATGATGCATAATCCGGATTGGTATGCCACAACCTCCACTAAGCGAGTGTCCGCAACGATGTGAATCTCGTGTGTAATAGGGTTTTGATTGCCGCCCCTTATTCCTTACCGGAATACGTCTGGATGCGGAGACAATTAGACTACAAGGGAAACTGAGCATGTCGAGTTTCGCTGTGGCTTTTTTAGCCAGATGGCTTGTTTTACTTGGGCTCACGACCTTGCAGGTTGTTCACGGACAACCAAACTGAGGTCATGTAACCCAGCTTTAGACAATCGGACGAGAAGTCTGAGGGGCAACACCTTAATATAGTAATTAGCGTAGGACGCATGACAGAATAGGGGAAGGTAATTGCATAGATTCTCTAGACTTGATGTAGCAGGCGCACACGCTGAGGCCTGATACAGCTATCACGAAACCGCGCAAGACGAATTTAGGATTTAAGGTGTACCCAAACCGGGAGCACTGTGGTACGGCGCGTACCGGCAAAGGATCCACGGCGTCCTCCATGTTTCCTACCGGCCTGCGGCCGTTTCCTTCGGTGAGCGGAGCATTCGTTTCTTTCAAAAGACGAATAATACCAATATATGGGTCTTACCGTTCACATCGTATCATAGTTGTTGCTGTTAGGGCACAACTTGAACGGGTGATCTATAGCGACCTGCTAGGGGTAAGACGGGTCTGCTATATAGTCAGTTTAGGGTTACCCCCCGTCACAGACCACTCGCAAAACTCCCCCGAGTAGGCCTATGGAAGACGATAGCCGCCCTGTCTAAACTACGTTCCACCTCAATCAGGCTCTAATGAGCCGTATTCAAACTCGTGAGGGTGAATATACTAGTTGTCTAAGGCCTCCGGCAAGGGCTGAGCGGGTGTATTAAAAGCGAATTATTGATTTAAGACGCGGGATCAAGCGCAATGGGGCCTCGTAGACCGTCCTGTTACTAAAACTATTGCAGTCGCTGAAACAGAGTGGTGGATAACACGCTATTAGCAGCTTCAGACATCGATTTAATACGGGAGACTTGCTGCTCTTAACTGGCGTAATGTTTGTACGGAGAGGAGCAATGCCTGAACAAAAGCGCGCGTGATAGCTTTAAAAGTATTTCACAGATAAAACAGTGCATGTATTTAAGAAAGTGGGCAGCGGGTCTTTAAATTTAACACGTCCGCAAGGATTGCCCACTTTTACCCAAAAGAATTCCGGTGACCGGTCTTGAATATACTTCGTACACTGCTGCTATGGCAAGGGTTCTTCAACATGACTAGCTTTAGTTTAGCAAGCGGTCCACCGGGGTTCTATTACATACGGTTGTACGTCCTAGGAATAAGACCCAGAGAAGGCTTAGGGTCGTCCGGTTAGTCGTATGGGTGGTAGGGGTAACGCACAACGGTGCGCTTCGCGGGACCAGGCGTGGTGCTGTCCATGACTAGCGTCTTCCTCTTGCACCGAACATTGGTATCTACACAAAACGGTTAGTCAAGTAATTTGGACTTAGACCTATGCGGCCGCGACTGGGTCCTAACTTTTATGGTTTTTCTCTTCCTCGAGCCCTAAGGGCTGACATTAGGAGGCAATTCTTCGGCTGCCTGGGATTCCAGACACTTTCGAAGCATATTAGTTAGCCCAAGCCACATCCAACCTTAGTGTGAAAACCAGCCGGTCTACAATTCACGCCCGGTATAGAGGAACAGCAATCGTGTCGAGTGTACAAGGAAAGGTGACGTAACGAGGCTTCCTGGTTAACGTTTGACGGACCGTCGCGGCAGGAAGCATCAAGATGAACTGACACAATTATTTAGGGCATATACAGTACGTGCACTACCCCAGTCTTTTATGTCATCATGCTTCACTCATCCCGGCAGTGTTCACAGCCGGAAGTTGATGCGTCTGGTTTGTATTCAAGGCGTGCTTTCGCCGCGGCCGGTGGATCGTCTTCTCTCCGTTCCTGGGGCGAGAAGGTTTTCAAGGTTACATTGGTGGGTATCTACTCGCTGCCCTCTGCTATGAGATTCCTCGGAGAGACGATAGTTAGCGGTGAATAATCTCAGATTTTCTCTGAGTGTTGCGAAGCGAGTTGGTATTTCAAATGGCGGCGATTGTAGTAATCGCCCGCGTCCTGAGGACTGTAAAACTGTCGTGATTTTGGCACCCTGCTGCTACTAAAATCGACTACCGGCCTCTTCGGAAGATGTCCGTATAAACGCTACGGAACTCGGACGCTTCAATAATGACCTTCGGCACTCCTCACTGATGCAGCAGGGTAGGAGTCTATCGACGTTAGACTGGATCGAGATTAGCCGGGGGTCATTTGCGCCTTCGCTATGCGGTTTTACTTGATCGCGAACTGGGTTTCCGTGGATGAATGATAAACGAATTAGTCGTCGAAGACTGAAGTAGAGTGTAGGTAGAATAGTGTGGTACCTTAGCCATTCGGTCTTCACTCTGCCGACCTTAGTAGTACCGGTTAGGCCTCCATGTGTGTTCCCTAGTTAAAGTGTGCTAGAGGGGCAACATATCGGCGCCCGCTATGTTCGCGAAACGGTTTGGGAGCGTGTATAAGATATTCTGAGTCGGGCAAAGCGGAATTACTTCGACAAGCACTTTACAAGCCAGTCGATGTGGAGTGGGGCGAGAGTAACCAGCTTGGTTGCAGACCAGTCCCCCTTAGGATGTTACTGCGATGCGTCTTGATACTGCCGTGTTACACTGTACAGTCGGGTTACGCCCATAACCCGATGTCTGTACTTTTGCTCTCGGCCACCCTTCGCGTCATATCCGCAAACATTGAGCGCTCGTCACTCCGCGCACCGTTCTCCTACAGGGTTTCGCGTTTGACAAGCTCGCGCAATTTTGTCTGACTTACCTTAGACCGAGGCTCCGAGACGTCTTAGGATTCCCAGACCTTGCAAGCATCAAACAACGCCTCCGGACGGAGCGCCCCAGACTATTGAGCCTACATGAGTCACAGGCCTGACTTGTGATGTACGTCAATTCTACCCGTAGTAGTTTCATGCCTAACAAGGTTTCGGATGACTAGAACATTTTGAGGTTCCTTGACTCAATGTAGCACCAGCTAGCGATTTCTATTCACACTCTTTCCGTTAGGTGCCAGTGTAAAGGCACGATGCATAGTTTCTATCC";
my $pattern = "GATGTGTTTC";
my $len = length $pattern;
my $mismatches = 5;

while($seq =~m/(?=(.{$len}))/g){
	my $position = pos $seq;
	my $str = $1;
	
	my $matches = 0;
	for(my $i=0; $i<$len; $i++){
		if(substr($str, $i,1) eq substr($pattern, $i,1)){
			$matches++;
		}
	}
	
	if($matches >= ($len - $mismatches)){
		print $position," ";
	}
}
