.section .data

S:
    .byte 0b01101101

H:
    .byte 0b01110110

E:
    .byte 0b01111001

.section .text

main:

    #initilize device
    mov $0b10000000,%al 
    mov $0x643, %DX 
    out %AL, %DX

    mov $0x640, %DX #puts device address, Configured to send data from data bus to port A
    mov $0, %SI
    
    mov %SI, %AL
    out %AL, %DX #we are now interfacing the first segment
    mov $0, %CX

    jmp .loop_to_left

.refresh_L:
    inc %DI

.loop_to_left:
    cmp $5, %DI
    jnz .refresh_L

    cmp $5, %CX
    jnz .build_left
    
    mov $7, %SI
    mov $0, %DI
    jmp .loop_to_right

.refresh_R:
    inc %DI

.loop_to_right:
    cmp $5, %DI
    jnz .refresh_R

    cmp $10, %CX
    jnz .build_right
    
    mov $0, %SI
    mov $0, %DI
    mov $0, %CX
    jmp .build_left


.build_left:

    mov $0x641, %DX
    mov 0, %AL
    out %AL, %DX

    mov $0x641, %DX
    mov S, %AL
    out %AL, %DX

    mov $0x640, %DX
    mov (%SI), %AL
    out %AL, %DX

    mov $0x641, %DX
    mov H, %AL
    out %AL, %DX

    mov $0x640, %DX
    mov 1(%SI), %AL
    out %AL, %DX

    mov $0x641, %DX
    mov E, %AL
    out %AL, %DX

    mov $0x640, %DX
    mov 2(%SI), %AL
    out %AL, %DX

    inc %CX

    inc %SI

    jmp .loop_to_left

.build_right:

    mov $0x641, %DX
    mov 0, %AL
    out %AL, %DX

    mov $0x641, %DX
    mov S, %AL
    out %AL, %DX

    mov $0x640, %DX
    mov (%SI), %AL
    out %AL, %DX

    mov $0x641, %DX
    mov H, %AL
    out %AL, %DX

    mov $0x640, %DX
    mov -1(%SI), %AL
    out %AL, %DX

    mov $0x641, %DX
    mov E, %AL
    out %AL, %DX

    mov $0x640, %DX
    mov -2(%SI), %AL
    out %AL, %DX
    
    inc %CX

    dec %SI

    jmp .loop_to_right
