#!/usr/bin/perl

use 5.010;

sub sort_string {
    my ($str) = @_; 
    my $res;
    for (sort split(//, $str)) { $res .= $_ }
    return $res;
}

sub is_anagram {
    my ($str1, $str2) = @_;
    unless (length($str1) == length($str2)) {say "not equal length"}
    elsif (sort_string($str1) eq sort_string($str2)) {say "anagrams!";}
    else {say "strigs are not anagrams"}
}

is_anagram(@ARGV);
