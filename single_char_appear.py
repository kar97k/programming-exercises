#!/usr/bin/env python3

#Реализуйте алгоритм, определяющий, все ли символы в строке встречаются
#только один раз

a = '1231'

char_repeated = False
for i in a:
    if char_repeated: break
    char_count = 0
    for j in a:
        if i == j: char_count += 1
        if char_count == 2: char_repeated = True
if char_repeated: print ("Equal chars in string!")
else: print ("Unique chars in string!")
