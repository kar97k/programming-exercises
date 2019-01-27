#!/usr/bin/env python
# -*- coding: utf-8 -*-

#Для двух строк напишите метод, определяющий, являeтся ли одна строка
#перестановкой другой.

a = 'abba'
b = 'baba'

anagrams = True

def char_count(string, char):
    num_of_chars = 0
    for curr_char in string:
        if curr_char == char: num_of_chars += 1
    return num_of_chars

if len(a) == len(b):
    for i in a:
        if char_count(a, i) != char_count(b, i):
            anagrams = False
            break
else: anagrams = False

if anagrams:  print "Anagrams!"
else: print "Strings are not anagrams"
