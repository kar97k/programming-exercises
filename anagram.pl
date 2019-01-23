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
    #counts how many $char in $str
    my ($char, $str) = @_;
    my $count = 0;
    #make array of chars from string
    my @arr_from_str = split(//, $str);
    for my $current_char (@arr_from_str) {
        if ($char eq $current_char) { $count++; }
    }
    return $count;
}

sub is_anagram {
    my ($s1, $s2) = @_;
    if (length($s1) != length($s2)) {say "strings are not anagrams!"; exit 1;};
    my @arr_from_s1 = split(//, $s1);
    my @arr_from_s2 = split(//, $s2);
    #get char from first string, count. Count how many times the same char appears in other string
    for my $char_from_first_string (@arr_from_s1) {
        if ( char_count($char_from_first_string, $s1) != char_count($char_from_first_string, $s2) ) {say "strings are not anagrams!"; exit 1;}
    }
    say "strings are anagrams!";
    #Boolean true
    return 1;
}

is_anagram(@ARGV);
