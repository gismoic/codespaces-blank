.section .data

msg1: 
.ascii "Please input your first string\n"
len1 = . - msg1

msg2: 
.ascii "Please input your second string\n"
len2 = . - msg2

.section .bss
.lcomm s1, 256
.lcomm s2, 256
.lcomm out, 256


.section .text

.global _start

_start:
    #write the first message
    mov $1, %rax
    mov $1, %rdi
    mov $msg1, %rsi
    mov $len1, %rdx
    syscall
    
    #read first string
    mov $0, %rax
    mov $0, %rdi
    mov $s1, %rsi
    mov $256, %rdx
    syscall

    #write the second message
    mov $1, %rax
    mov $1, %rdi
    mov $msg2, %rsi
    mov $len2, %rdx
    syscall
    
    #read second string
    mov $0, %rax
    mov $0, %rdi
    mov $s2, %rsi
    mov $256, %rdx
    syscall

    mov $s1, %rdi
    mov $s2, %rsi
    mov $0, %r10

    jmp ._Xoring


._Xoring:
    
    mov (%rdi), %al
    mov (%rsi), %bl

    xor %bl, %al

    inc %r10
    inc %rdi

    mov %al, %r8b
    add %r8, %r9

    cmp $10, %r10
    jnz ._Xoring

    mov %r9, out+1

    mov $60, %rax
    mov $0, %rdi
    syscall

.section .note.GNU-stack, "", @progbits









    

