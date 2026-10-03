.global _Sum

_Sum:
    xor %r10, %r10 #stores base index
    xor %r9, %r9  #stores current sum
    xor %r8, %r8  #stores loop index

loop:
    cmp %r8d, %esi #compare loop index with passed value
    je done

    add (%rdi, %r10), %r9d #derefs address and adds value in r9
    add $4, %r10 #add to index reg
    inc %r8d #increment loop index
    jmp loop

done:
    mov %r9d, %eax
    ret

.section .note.GNU-stack, "", @progbits

