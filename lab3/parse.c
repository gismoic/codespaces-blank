#include<stdio.h>

unsigned char containter[999];
unsigned int integers[99];

extern int _Sum(int *ints, int count);

static int powO(int base, int power){
    int tmp = 1;

    for(int i = 0; i < power; i++){
        tmp *= base;
    }
    return tmp;
}

int main(int argc, char **argv){

    FILE* file = fopen("data.txt", "r");
    if(!file){printf("Something is wrong\n"); return 1;}

    unsigned int file_size = 0;
    fseek(file ,0, SEEK_END);
    file_size = ftell(file);
    
    rewind(file);
    fread(containter, 1, file_size, file);

    int num_of_places = 0;
    int integer_index = 0;
    int tmp_index = 0;
    int tmp[9999];

    printf("FILE SIZE: %d", file_size);

    for(int i = 0; i < file_size+1; i++){

        if((i == file_size) || (containter[i] == '\n')){
            int new_Num = 0;
            
            for(int j = 0; j <= num_of_places; j++){
                new_Num += tmp[tmp_index + j]*(powO(10,num_of_places-j-1));
            }

            tmp_index += num_of_places;

            integers[integer_index] = new_Num;
            integer_index++;
            num_of_places = 0;
        }else{
            tmp[num_of_places + tmp_index] = ((int)containter[i]-48);
            num_of_places++;
        }
    }

    int intCount = 0;
    for(int i = 0; integers[i] != 0; i++){intCount++;};
    

    printf("\nCOUNT:%d SUM:%d\n", intCount, _Sum(integers, intCount));

    return 0;
}