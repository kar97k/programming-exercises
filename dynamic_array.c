#include <stdio.h>
#include <string.h>
#include <stdlib.h>

//ломается, когда в realloc второй аргумент больше 8 или меньше, чем было ранее
int main() {

int *start_p;
start_p = (int *) malloc(0);
int *end_p = start_p;
int current_arr_size = 0;
int size_of_bytes_to_add = 0;
int iteration = 1;

while ( size_of_bytes_to_add != 3 ) {
    printf("Input size of bytes to add to array:\n");
    scanf("%d", &size_of_bytes_to_add);


    current_arr_size += size_of_bytes_to_add;
    printf ("Going to realloc: %d\n", current_arr_size);
    start_p = (int *) realloc (start_p, current_arr_size);
    printf("%p\n", start_p);

/*
    //Error! Condition tmp_p + size_of... incremets after every iteration!
    for ( int *tmp_p = p; tmp_p < tmp_p + size_of_bytes_to_add; tmp_p++ ) {
        *tmp_p = iteration;
        printf("%p : %d \n", tmp_p, *tmp_p); 
    }
*/

    for ( int *tmp_p = end_p; tmp_p != end_p + size_of_bytes_to_add; tmp_p++ ) {
        *tmp_p = iteration;
        printf("%p : %d\n", tmp_p, *tmp_p); 
    }
    printf("--------\n");
    //may be overwrite second condition as tmp_p != end_p += size_of_bytes_to_add ???    
    end_p += size_of_bytes_to_add;

    for ( int *tmp_p = start_p; tmp_p != end_p; tmp_p++ ) {
        printf("%p : %d \n", tmp_p, *tmp_p); 
    }
    iteration++;


    printf ("%d\n", current_arr_size);
}

}
