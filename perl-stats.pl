#!/usr/bin/perl

use warnings;
use strict;
use Time::HiRes qw(time sleep);
$|++;




print "Test,Initialize,Count Variance,Sort,Q10000,Total\n";
for (1..10) {
	my (@array, @result, $tm_end);
	
	push @result, 11-$_;
	my $tm_start = time;
	for (1..1E6) {
		push @array, int(rand()*100);
	}
	$tm_end = time;
	push @result, sprintf "%.3f", $tm_end - $tm_start;
	$tm_start = $tm_end;

	my ($sum, $variance) = (0, 0);
	$sum += $_ for @array;
	my $avg = $sum / @array;
	$variance += ($_ - $avg)**2 for @array;
	$variance /= @array;
	$tm_end = time;
	push @result, sprintf "%.3f", $tm_end - $tm_start;
	$tm_start = $tm_end;

	my @tmp = sort@array;
	$tm_end = time;
	push @result, sprintf "%.3f", $tm_end - $tm_start;
	$tm_start = $tm_end;

	my $alen = @array - 1;
	my @quantiles;
	my $qn = 10000;
	for my $quantile (0..$qn) {
		my $alq = $alen * $quantile / $qn;
		my $idx = int $alq;
		my $diff = $alq - $idx;
		
		my $qvalue =
			$diff < 0.001 ?
			$tmp[$idx] :
			int($tmp[$idx] * (1 - $diff) + $tmp[$idx+1] * $diff +.5); ## rounding to int too just for CPU touch;
		
		push @quantiles, $qvalue;
	}
	$tm_end = time;
	push @result, sprintf "%.3f", $tm_end - $tm_start;
	$tm_start = 0; $tm_start += $_ for @result[1..$#result];
	push @result, sprintf "%.3f", $tm_start;
	print join(',', @result), "\n";
	sleep .1;
}



