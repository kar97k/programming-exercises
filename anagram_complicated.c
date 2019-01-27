#include <stdio.h>
#include <string.h>

int main() {

/*
remove identical symbols from string, try to reach perfprmance gain

get first symbol of first string. Count, how many times it appears. Remove such symbols from string
process such way second string
Example:
from:   abdadfa    ffwarad    //curr_char='a'
to:     bddf       ffwrd
repeat until first string became zero

string will be shorteer and shorter after every iteration
repeat until first string became zero
*/

char a[] = "aabca"; 
char b[] = "bcaaa";
int is_anagram = 1; //True

if (strlen(a) == strlen(b))   {
    char curr_symb;
    int char_count_a;
    int char_count_b;
    int curr_length = strlen(a);
    int new_length;
    int j;
    while (curr_length) {
        curr_symb = a[0];
        char_count_a = 0;
        char_count_b = 0;
        new_length = curr_length;
        j = 0;
        //process first string
        for (int i = 0; i < curr_length; i++) {
            if (a[i] == curr_symb) {
                char_count_a++;
                new_length--;
            }
            else {
                /*rewrite current string with symbols not equal to curr_symb
                from:   aabca       new_length = 5
                to:     bcbca       new_length = 2
                variable new_length help to ignore rest of string in next interation
                string "bc" will be processed
                */
                a[j] = a[i];
                j++;
            }
        }
        j = 0;
        //process second string
        for (int i = 0; i < curr_length; i++) {
            if (b[i] == curr_symb) {char_count_b++;}
            else {
                b[j] = b[i];
                j++;
            }
        }
        if (char_count_a != char_count_b) {
            printf("Strings are not anagrams!\n");
            is_anagram = 0; //False
            break;
        }
        curr_length = new_length;
    }
}
else {
    printf("Not equal length, not anagrams\n");
    is_anagram = 0;
}
if (is_anagram) {
    printf("Anagrams!\n");
    return is_anagram;
}
else {return is_anagram;}
}
