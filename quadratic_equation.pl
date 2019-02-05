#!/usr/bin/perl

use strict;
use warnings;

sub solve_equation {
    my ($a_value, $b_value, $c_value) = @_;
    my ($x1, $x2, $D) = (undef, undef, undef);
    my $result="";
    #if no $a_value given or $a_value=0 it is not quadric equation
    #False: 0, undef
    unless ($a_value) {
        $result="No solution!";
    }
    else {
        #if second and third argument is given or at least one of them, then should solve ordinary quadratic equation
        if ($b_value || $c_value)   {
            $D = $b_value ** 2 - 4 * $a_value * $c_value ;
            if ($D > 0) {
                $x1 = -$b_value - $D ** 0.5;
                $x1 /= 2*$a_value;
                $x2 = -$b_value + $D ** 0.5;
                $x2 /= 2*$a_value;
                my @res_arr = ($x1, $x2);
                @res_arr = sort {$x1 <=> $x2} (@res_arr);
                $"=', ';
                $result = "@res_arr";
            }
            elsif ($D = 0) {
                $x1=-$b_value/2*$a_value;
                $result="$x1";
            }
            else {$result="No solution!";}
        }
        #if there is no second and third argument, equation is a*x^2 = 0; x = 0
        else    {
            $x1 = 0;
            $result ="$x1";
        }
    }
    print "$result\n";
}

solve_equation (@ARGV);
