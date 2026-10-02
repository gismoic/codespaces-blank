#include<stdio.h>

unsigned char containter[99];
unsigned int integers[99];

static int pow(int base, int power){
    int tmp = 0;
    for(int i = 0; i < power; i++){
        tmp *= base;
    }
    return tmp;
}

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

    int num_of_places = 0;
    int integer_index = 0;
    char tmp[5];

    for(int i = 0; i < file_size; i++){
        if(containter[i] == '\n'){
            int new_Num = 0;
            for(int j = 0; j < num_of_places; j++){
                new_Num += tmp[j]*(pow(10,num_of_places-j));
            }
            integers[integer_index] = new_Num;
            integer_index++;
            num_of_places = 0;
        }else{
            tmp[num_of_places] = (int)containter[i];
            num_of_places++;
        }
    }

    return 0;
}