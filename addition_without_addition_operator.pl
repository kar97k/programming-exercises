#!/usr/bin/perl

use 5.018;
use Math::BaseCalc;

my $a = 17;
my $b = 7;

#my $decimal = Math::BaseCalc->new( digits => [0..9] );
my $binary = new Math::BaseCalc (digits => [0..1]);

#got binary format of digit
my $bin_a = $binary->to_base($a);
my $bin_b = $binary->to_base($b);

#gonna process every symbol, so format string to array of chars
my @bin_a_str = split(//, $bin_a);
my @bin_b_str = split(//, $bin_b);

#Solution.
#instead of ariphmethic operators gonna use logic operators
#(00 + 00) = 00 ---> if a = 0 and b = 0 then sum = 0
#(00 + 01) = 01 ---> if a = 0 and b = 1 then sum = 1
#(01 + 00) = 01 ---> if a = 1 and b = 0 then sum = 1
#(01 + 01) = 10 ---> if a = 1 and b = 1 then sum = 0 and somehow save 1 to use in next addition operation

#if digits has different length then need aligment short to long, appending zeroes
#need refactoring to subfunction: 
#get 2 strings "101110" "101" return "101110" "000101"
#process string in normal order, not reverse

say "before aligment:";
say "a: @reverse_bin_a_str";
say "b: @reverse_bin_b_str";
# 3 <=> 3 ---> 0 (False)
my $compare_result = (scalar @reverse_bin_a_str <=> scalar @reverse_bin_b_str); 
say "compare result $compare_result";
unless ($compare_result) {say "Equal! ";}
elsif ($compare_result == -1) {
	say "From first elsif hello! compare result: $compare_result";
	while (scalar @reverse_bin_a_str != scalar @reverse_bin_b_str) {
		unshift @reverse_bin_a_str, 0;
		say @reverse_bin_a_str;
	}
}
elsif ($compare_result == 1) {
	say "From else $compare_result";
	while (scalar @reverse_bin_b_str != scalar @reverse_bin_a_str) {
	unshift @reverse_bin_b_str, 0;
	say @reverse_bin_b_str;
	}
}
say "compare result after cycle: $compare_result";
say "after aligment:";
say "a: @reverse_bin_a_str";
say "b: @reverse_bin_b_str";

#sum

#have to procces digits in reverse order
my @reverse_bin_a_str = reverse @bin_a_str;
my @reverse_bin_b_str = reverse @bin_b_str;



#my @digit_arr = (0..15);
#$"="\t";
#say "@digit_arr";
