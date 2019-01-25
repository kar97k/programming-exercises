#!/usr/bin/perl

use 5.018;
use Math::BaseCalc;

my $a = 3;
my $b = 3;

my $binary = new Math::BaseCalc (digits => [0..1]);

#got binary format of digit
my $bin_a = $binary->to_base($a);
my $bin_b = $binary->to_base($b);

#Solution.
#Addition operation generaly:
#
#	   11
#   110001 
#	------+
#	001011
#	------
#	111100
#
#going to process addition of every pair of digits in reversre order
#
#instead of ariphmethic operators use logic operators
#(00 + 00) = 00 ---> if a = 0 and b = 0 then sum = 0
#(00 + 01) = 01 ---> if a = 0 and b = 1 then sum = 1
#(01 + 00) = 01 ---> if a = 1 and b = 0 then sum = 1
#(01 + 01) = 10 ---> if a = 1 and b = 1 then sum = 0 and somehow save 1 to use in next addition operation

sub align_bin_digits {
	#if digits has different length, need aligment short to long, appending zeroes
	#get 2 strings "101110" "101" return "101110" "000101"

	my ($str_a, $str_b) = @_;
	my @bin_str_a = split(//, $bin_a);
	my @bin_str_b = split(//, $bin_b);

	my $compare_result = (scalar @bin_str_a <=> scalar @bin_str_b); 
	# 3 <=> 3 ---> 0 (False)
	unless ($compare_result) {}
	# 1 <=> 3 ---> -1
	elsif ($compare_result == -1) {
		while (scalar @bin_str_a != scalar @bin_str_b) {
			unshift @bin_str_a, 0;
		}
	}
	# 3 <=> 1 ---> 1
	elsif ($compare_result == 1) {
		while (scalar @bin_str_b != scalar @bin_str_a) {
			unshift @bin_str_b, 0;
		}
	}
	$str_a = join("", @bin_str_a);
	$str_b = join("", @bin_str_b);
	return ($str_a, $str_b); 
}

say "Before aligment:";
say "a: $bin_a";
say "b: $bin_b";

($bin_a, $bin_b) = align_bin_digits ($bin_a, $bin_b);

say "After aligment:";
say "a: $bin_a";
say "b: $bin_b";

#Addition realization

#process every symbol, so format string to array of chars
my @bin_a_str = split(//, $bin_a);
my @bin_b_str = split(//, $bin_b);

#have to procces digits in reverse order
my @reverse_bin_a_str = reverse @bin_a_str;
my @reverse_bin_b_str = reverse @bin_b_str;
my @reverse_bin_sum_str;
my $overhead_digit = 0;

for my $i (0..$#reverse_bin_a_str) {
	if ($overhead_digit == 0) {
		#00+00=00
		if ($reverse_bin_a_str[$i] == 0 && $reverse_bin_b_str[$i] == 0) {push @reverse_bin_sum_str, 0;}
		#01+01=10
		#digit 1 from result go to overhead variable
		elsif ($reverse_bin_a_str[$i] == 1 && $reverse_bin_b_str[$i] == 1) {push @reverse_bin_sum_str, 0; $overhead_digit = 1;}
		#01+00=01; 00+01=01;
		else {push @reverse_bin_sum_str, 1;}
	}
	else {
		#(1) is overhead from privious operation
		#00+00+(1)=01
		if ($reverse_bin_a_str[$i] == 0 && $reverse_bin_b_str[$i] == 0) {push @reverse_bin_sum_str, 1; $overhead_digit = 0;}
		#01+01+(1)=11
		elsif ($reverse_bin_a_str[$i] == 1 && $reverse_bin_b_str[$i] == 1) {push @reverse_bin_sum_str, 1;}
		#01+00+(1)=10, 00+01+(1)=10
        else {push @reverse_bin_sum_str, 0;}
	}
}
if ($overhead_digit == 1) {push @reverse_bin_sum_str, 1;}

my @bin_sum_str = reverse @reverse_bin_sum_str;
$"="";
say "r: @bin_sum_str"; 

my $bin_sum = join("", @bin_sum_str);

my $dec_sum = $binary->from_base($bin_sum);
say "$a + $b = $dec_sum"
#my @digit_arr = (0..15);
#$"="\t";
#say "@digit_arr";
