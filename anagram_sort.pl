#!/usr/bin/perl

use 5.010;

sub sort_string {
    my ($str) = @_;
    my @arr_frm_str = split(//, $str);
    my @sort_arr_frm_str = sort @arr_frm_str;
    $str = "";
    for (@sort_arr_frm_str) { $str .= $_ }
    say $str;
}

sub is_anagram {
    my ($str1, $str2) = @_;
    unless (length($str1) == length($str2)) {say "not eq len"}
    elsif (sort_string($str1) eq sort_string($str2)) {say "eq!";}
}

is_anagram(@ARGV);
