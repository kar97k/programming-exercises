#!/usr/bin/env perl

use strict;
use warnings;
use 5.018;

sub is_anagram {
    my ($s1, $s2) = @_;
    my $curr_char;
    if (length($s1) != length($s2)) {say "Strings are not anagrams!"; exit 1;};
    while ($s1) {
        $curr_char = substr $s1, 0, 1;
        #match $curr_char in both strings. if num of $curr_char in s1 and s2 not equal, strings are not anagrams;
        #also replases all matched chars with '' in purpose to encrease speed of processing string in next iterations
        if ($s1 =~ s/$curr_char//g != $s2 =~ s/$curr_char//g) {say "Not anagrams"; exit 1;};
    }
    say "Anagrams!";
    return 1;
}

is_anagram(@ARGV);
