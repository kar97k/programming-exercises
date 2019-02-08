#!/usr/bin/perl

use 5.010;
use utf8;

=pod
Функция поиска всех множеств анаграмм по словарю.
Входные данные для функции: ссылка на массив - каждый элемент которого - слово на русском языке в кодировке utf8
Выходные данные: Ссылка на хеш множеств анаграмм.
Ключ - первое встретившееся в словаре слово из множества
Значение - ссылка на массив, каждый элемент которого слово из множества, в том порядке в котором оно встретилось в словаре в первый раз.
Множества из одного элемента не должны попасть в результат.
Все слова должны быть приведены к нижнему регистру.
В результирующем множестве каждое слово должно встречаться только один раз.
=cut

sub sort_string {
    my ($str) = @_; 
    my $res;
    for (sort split(//, $str)) { $res .= $_ }
    return $res;
}

sub is_anagram {
    my ($str1, $str2) = @_;
    unless (length($str1) == length($str2)) {return 0}
    elsif (sort_string($str1) eq sort_string($str2)) {return 1}
    else {return 0}
}

sub anagram_hash {
    my $aref = shift;
    my @arr_copy = map {lc} @{$aref};
    my %uniq = ();
    my @uniq_el_arr_copy = grep { !$uniq{$_}++ } @arr_copy;
    my %res_hash;
    while ($#uniq_el_arr_copy != -1) {
        my $curr_word = $uniq_el_arr_copy[0];
        my @set = grep { is_anagram($curr_word, $_) } @uniq_el_arr_copy;
        @uniq_el_arr_copy = grep { !is_anagram($curr_word, $_) } @uniq_el_arr_copy;
        if ($#set) {$res_hash{$set[0]} = \@set}
    }
    return %res_hash;
}

my list = ('пятак', 'ЛиСток', 'пятка', 'стул', 'ПяТаК', 'слиток', 'тяпка', 'столик', 'слиток');
my $result = anagram(\@list);
say "$_: @{$result->{$_}}" for sort keys %$result;
