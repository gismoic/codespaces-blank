#include<stdlib.h>
#include<stdio.h>

extern unsigned char out[];
extern void begin(void);

int main(void){

    begin();
    printf("%d\n", out[0]);

    return 0;
}