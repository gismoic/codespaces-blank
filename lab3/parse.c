#include<stdio.h>

unsigned char containter[99];

int main(int *argc, char **argv){

    FILE* file = fopen("data.txt", "r");
    if(!file){printf("Something is wrong\n"); return 1;}

    unsigned int file_size = 0;
    fseek(file ,0, SEEK_END);
    file_size = ftell(file);
    
    rewind(file);
    fread(containter, 1, file_size, file);

    for(int i = 0; i < file_size; i++){
        printf("%c", containter[i]);
    }

    return 0;
}