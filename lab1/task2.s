.section .bss
.global ram
.lcomm ram, 256

.section .text
.global fill_ram

fill_ram:

    mov $ram+0x50, %rax
    jmp .indirect
    
.indirect:
    
    movb $0xFF, (%rax)
    inc %rax

    cmp $ram+0x59, %rax
    jnz .indirect
    
    ret

.section .note.GNU-stack, "", @progbits
