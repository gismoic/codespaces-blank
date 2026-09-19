.section .bss
.global ram
.lcomm ram, 256

.section .text
.global fill_ram

fill_ram:
    mov $0, %rax
    mov $10, %rdi

    jmp .Loop

.Loop:
    inc %eax
    cmp %rdi, %rax
    jne .Loop

    mov %eax, ram+50

    ret

.section .note.GNU-stack, "", @progbits
