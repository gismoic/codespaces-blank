.section .data

Numbers:
        .long 1
        .long 15
        .long 4
        .long 2
        .long 7
        .long 9
        .long 23
        .long 7
        .long 3
        .long 11
len:
    .long 10

    .section .text
    .global begin

begin:
    movl $0,%ecx #keeps track of loop count
    movl Numbers,%ebx #first value from the beginning of the array

test:
    cmpl len, %ecx
    jge end

    movl    Numbers(,%rcx,4), %eax  
    cmpl    %ebx, %eax              
    jle     skip
    movl    %eax, %ebx              

skip:
    inc %ecx
    jmp test

end:
    movl %ebx, %eax             
    ret

.section .note.GNU-stack, "", @progbits
