#!/usr/bin/env python
# -*- coding: utf-8 -*-

#Для двух строк напишите метод, определяющий, являeтся ли одна строка
#перестановкой другой.

a = 'abba'
b = 'abbb'

copy_a = a
copy_b = b
curr_length = len(copy_a)
anagrams = True

#remove identical symbols from string, try to reach perfprmance gain 
#
#get first symbol of first string. Count, how many times it appears. Remove such symbols from string
#process such way second string
#Example:
#from:   abdadfa    ffwarad    #curr_char='a'
#to:     bddf       ffwrd
#
#string will be shorteer and shorter after every iteration
#repeat until first string became zero

if len(a) == len(b):
    while curr_length:
        curr_char = copy_a[0]
        char_count_a = char_count_b = 0
        curr_length = len(copy_a)
        new_length = 0
        copy_copy_a = ''
        copy_copy_b = ''
        j = 0
        for i in range(curr_length):
            if copy_a[i] == curr_char: char_count_a += 1
            else:
                copy_copy_a[:j] + copy_a[i]
                j += 1
        new_length = len(copy_copy_a)
        j = 0
        for i in range(curr_length):
            if copy_b[i] == curr_char: char_count_b += 1
            else:
                copy_copy_b[:j] + copy_b[i]
                j += 1
        if not char_count_a == char_count_b:
            anagrams = False
            break
        curr_length = new_length
        copy_a = copy_copy_a
        copy_b = copy_copy_b
else: anagrams = False
print (anagrams)
