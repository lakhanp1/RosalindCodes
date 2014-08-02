
#!usr/bin/perl -w
use strict;
use warnings;


=head
Independent Alleles


This problem is solved by Binomial probability. The formula to calculate The probability that at least r Aa Bb organisms will belong to the k-th generation of Tom's family tree (don't count the Aa Bb mates at each level). Assume that Mendel's second law holds for the factors is

= sum over 1 to r( (nCr) * (p**r) * ((1-p)**(n-r)) )

where,
	n = total number of individuals after k generations
	r = atleast these number of organisms of genotype AaBa after k generations
	p = probability of organism with genotype AaBb. as each organism is mating with AaBb, its probability is 1/4, whatever is the genotype of other partner
	
link: http://www.regentsprep.org/Regents/math/algtrig/ATS7/BLesson2.htm

6 16 = 0.547
=cut

my $generation = 7;
my $atleast = 36;

my $probAaBb = 0.25;
my $totalOrganisms = 2**$generation;			#since each organism gives birth to 2 new organisms

my $resultProb = 0;

#print "$totalOrganisms\n\n";

for(my $i = $atleast; $i<= $totalOrganisms; $i++){
	my $nCr = &combination($totalOrganisms, $i);
	
	#print $nCr,"*\t",($probAaBb ** $i),"\t",((1-$probAaBb) ** ($totalOrganisms-$i)),"\n";
	$resultProb += ($nCr * ($probAaBb ** $i) * ((1-$probAaBb) ** ($totalOrganisms-$i)));
}


print sprintf("%.3f", $resultProb);



sub combination{
	my $comb = 1;
	
	#permutation
	for(my $i=$_[0]; $i > ($_[0]-$_[1]); $i--){
		$comb *= $i;
	}
	
	#reducing factor on permutaion i.e. 1/r! gives combination
	for(my $i = $_[1]; $i > 1; $i--){
		$comb /= $i;
	}
	
	return $comb;
	
}
