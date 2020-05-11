; simple_stack_frame.asm
; Joshua Thornton 2018

SECTION .text

global simple_stack_frame
simple_stack_frame:

.prologue:
    push ebp
    mov ebp, esp
    ; +0x04: ret address
    ;  0x00: caller's EBP

    ; Stuff around with ESP and let epilogue clean-up
    push 1
    push 2
    push 3
    push 4

.epilogue:
    mov esp, ebp
    pop EBP
    ret