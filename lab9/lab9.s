.section .data

S:                          
    .byte 0b01101101

H:                          
    .byte 0b01110110

E:                          
    .byte 0b01111001

BaseIndex:                  # one-hot digit mask for the digit that holds 'E' (the rightmost letter)
    .byte 1                 # 1 = dig-0; H is one digit left (mask<<1), S two digits left (mask<<2)

.section .text
.global main

main:

    #initilize device
    mov $0b10000000,%al     # control word: bit7=1 (mode set), bits6-5=00 group A mode 0,
                            # bit4=0 port A output, bit3=0 port C upper output,
                            # bit2=0 group B mode 0, bit1=0 port B output, bit0=0 port C lower output
    mov $0x643, %dx         # control register address (A1 A0 = 11)
    out %al, %dx

    mov $1, BaseIndex      # start with 'E' on dig-0, so SHE occupies dig-2..dig-0

.loop_to_left:              # scroll toward dig-7 (E mask goes 0x01 -> 0x20)
    mov $300, %si           # redraw the whole word 300 times per scroll step (persistence of vision)
.pulse_left:
    call .build
    dec %si
    jnz .pulse_left

    shl $1, BaseIndex      # move the word one digit left
    cmp $0x40, BaseIndex   # 0x40 means S would have passed dig-7
    jne .loop_to_left

    movb $0x10, BaseIndex   # turn around one step in so the end position isn't shown twice

.loop_to_right:             # scroll toward dig-0
    mov $300, %si
.pulse_right:
    call .build
    dec %si
    jnz .pulse_right

    shr $1, BaseIndex      # move the word one digit right
    jnz .loop_to_right      # mask shifted out to 0 means E passed dig-0

    mov $2, BaseIndex      # turn around one step in
    jmp .loop_to_left

.refresh:
    #refresh logic has to clear data on all digits
    mov $0x640, %dx
    mov $0, %al
    out %al, %dx            #no digit selected, so nothing is lit while port B changes
    ret

.delay:                     # delay function
    mov $200, %di
1:  dec %di
    jnz 1b
    ret

.show:                      
    mov %al, %ah            #store bit pattern for character in upper 8 bits (refresh clears it)
    call .refresh           
    mov $0x641, %dx
    mov %ah, %al
    out %al, %dx            #put the pattern on port B (shared by all digits)
    mov $0x640, %dx
    mov %bl, %al
    out %al, %dx            #select just one digit via port A
    call .delay
    ret

.build:                     # by shifting %bl, each character is placed on a separate digit
    mov BaseIndex, %bl      # building E
    mov E, %al
    call .show

    shl $1, %bl             # next digit to the left
    mov H, %al
    call .show

    shl $1, %bl             # and the next one for S
    mov S, %al
    call .show
    ret