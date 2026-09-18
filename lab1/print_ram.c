#include<stdio.h>
extern unsigned char ram[];

extern void fill_ram(void);

int main(){

    printf("RAM contents from 50H to 58H\n");
    for(int i = 0x50; i <= 0x58; i++){
        printf("%c", ram[i]);
    }
    printf("\n");
    return 0;
}