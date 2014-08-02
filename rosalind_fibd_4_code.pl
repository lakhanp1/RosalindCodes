#!usr/bin/perl -w

use strict;
use warnings;
use bignum;

=head
Mortal Fibonacci Rabbits

Problem

Recall the definition of the Fibonacci numbers from “Rabbits and Recurrence Relations”, which followed the recurrence relation Fn=Fn-1+Fn-2 and assumed that each pair of rabbits reaches maturity in one month and produces a single pair of offspring (one male, one female) each subsequent month.

Our aim is to somehow modify this recurrence relation to achieve a dynamic programming solution in the case that all rabbits die out after a fixed number of months. See Figure 4 for a depiction of a rabbit tree in which rabbits live for three months (meaning that they reproduce only twice before dying).

Given: Positive integers n=100 and m=20.

Return: The total number of pairs of rabbits that will remain after the n-th month if all rabbits live for m months.
Sample Dataset

6 3

Sample Output

4


=cut

my $period = 90;
my $life = 16;

my @population = (1,1);

for(my $i = $#population+1; $i<$period; $i++){
	my $generation = $i+1;
	if($generation <= $life){
		push(@population, $population[$i-1]+$population[$i-2]);
	}
	else{
		my $sum = 0;
		#print join(" + ", @population[$i-$life..$i-2]),") == ";
		map{$sum += $_}@population[$i-$life..$i-2];
		#print $sum,"\n";
		push(@population, $sum);
	}
	
}

print "@population\n";

#printf '<%f>',$population[-1];
