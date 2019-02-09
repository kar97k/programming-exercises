#!/usr/bin/perl

use 5.010;
use Data::Dumper;

=pod
Напишите функцию parse_url. В качестве единственного аргумента функция получает url, в качестве значения она возвращает хеш из элементов, содержащихся в данном url.
Пример:
%hash = parse_url("http://mail.ru:8080/r/p?s=10&z=11#text");

%hash = (
    schema         => 'http',
    domain         => 'mail.ru',
    port           => '8080',
    path           => '/r/p',
    query_string   => 's=10&z=11',
    anchor         => 'text',
);
=cut

sub parse_url {
    my $url = shift;
    my %hash;
    if ($url =~ m"(?<schema>^\w+)://(?<domain>[\w.]+)(?<port>:*\d*)/(?<path>[\w/]*)(?<query_string>\??[\w=&]*)(?<anchor>#?\w*)") {%hash = %+};
    for (keys %hash) {
        say "$_:$hash{$_}";
    }
    for (keys %hash) {
        unless ($hash{$_}) {delete $hash{$_}}
    }
    if ($hash{'port'}) {$hash{'port'} =~ tr/://d}
    if ($hash{'query_string'}) {$hash{'query_string'} =~ tr/?//d}
    if ($hash{'anchor'}) {$hash{'anchor'} =~ tr/#//d}
    $hash{'path'} = '/'.$hash{'path'};
    return %hash;
}

my %a = parse_url("http://mail.ru/r/p?s=10&z=11#text");
say Dumper \%a;
