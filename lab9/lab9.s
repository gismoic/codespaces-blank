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
    mov $0x643, %dx 
    out %al, %dx

    mov $0x640, %dx #puts device address, Configured to send data from data bus to port A
    mov $0, %si
    
    mov %si, %al
    out %al, %dx #we are now interfacing the first segment
    mov $0, %cx

    jmp .loop_to_left

.refresh_L:
    inc %di

.loop_to_left:
    cmp $5, %di
    jnz .refresh_L

    cmp $5, %cx
    jnz .build_left
    
    mov $7, %si
    mov $0, %di
    jmp .loop_to_right

.refresh_R:
    inc %di

.loop_to_right:
    cmp $5, %di
    jnz .refresh_R

    cmp $10, %cx
    jnz .build_right
    
    mov $0, %si
    mov $0, %di
    mov $0, %cx
    jmp .build_left


.build_left:

    mov $0x641, %dx
    mov 0, %al
    out %al, %dx

    mov $0x641, %dx
    mov S, %al
    out %al, %dx

    mov $0x640, %dx
    mov (%si), %al
    out %al, %dx

    mov $0x641, %dx
    mov H, %al
    out %al, %dx

    mov $0x640, %dx
    mov 1(%si), %al
    out %al, %dx

    mov $0x641, %dx
    mov E, %al
    out %al, %dx

    mov $0x640, %dx
    mov 2(%si), %al
    out %al, %dx

    inc %cx

    inc %si

    jmp .loop_to_left

.build_right:

    mov $0x641, %dx
    mov 0, %al
    out %al, %dx

    mov $0x641, %dx
    mov S, %al
    out %al, %dx

    mov $0x640, %DX
    mov (%si), %al
    out %al, %dx

    mov $0x641, %dx
    mov H, %al
    out %al, %dx

    mov $0x640, %dx
    mov -1(%si), %al
    out %al, %dx

    mov $0x641, %dx
    mov E, %al
    out %al, %dx

    mov $0x640, %dx
    mov -2(%si), %al
    out %al, %dx
    
    inc %cx

    dec %si

    jmp .loop_to_right
