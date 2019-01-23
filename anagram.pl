#!/usr/bin/perl

# Даны две строки. Написать функцию, которая проверяет, являются ли одна анаграммой другой, 
# т.е. содержат одни и те же символы но возможно в разном порядке. 
# Например, abcdef и abdcfe - анаграммы, а abcdef и abcddef - нет.

# abba - baab YES
# abba - abbb NO (лишний b, нету a)

# Если бы мы писали на Python:
#
# def is_anagram(s1: str, s2: str) -> bool:

use strict;
use warnings;
use 5.018;

sub char_count {
    my ($char, $str) = @_;
    my $count = 0;
    my @arr_from_str = split(//, $str);
    for my $i (0..$#arr_from_str) {
        if ("$char" eq "$arr_from_str[$i]") { $count++; }
    }
    return $count;
}

sub is_anagram {
    my ($s1, $s2) = @_;
    if (length($s1) != length($s2)) {say "strings are not anagrams!"; exit 1;};
    my @arr_from_s1 = split(//, $s1);
    my @arr_from_s2 = split(//, $s2);
    for my $i (0..length($s1)-1) {
        if ( char_count($arr_from_s1[$i], $s1) != char_count($arr_from_s2[$i], $s1) ) {say "strings are not anagrams!"; exit 1;}
    }
    #Boolean true
    say "strings are anagrams!";
    return 1;
}

my $s1="bbba";
my $s2="baba";
is_anagram($s1,$s2);
