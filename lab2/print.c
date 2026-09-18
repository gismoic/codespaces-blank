#include<stdlib.h>
#include<stdio.h>

extern unsigned char out[];

int main(void){

    printf("HELP\n");
    printf("%02x", out[0]);

    return 0;
}