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

.global out
.lcomm out, 256


.section .text

.global begin

begin:
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
    mov $10, %r10
    xor %r9, %r9

    jmp ._Xoring

._Xoring:
    
    mov (%rdi), %al
    cmp $10, %al        #checks for '\n' in the first byte, the end of s1           
    je .exit

    mov (%rdi), %al
    mov (%rsi), %dl

    xor %dl, %al
    mov $8, %r10 
.bit_manip:
    mov %al, %r8b

    and $1, %r8

    add %r8, %r9
    shr $1, %al
    dec %r10
    jnz .bit_manip

    inc %rdi
    inc %rsi
    jmp ._Xoring

.exit:
    
    mov %r9b, out
    ret


.section .note.GNU-stack, "", @progbits









    

