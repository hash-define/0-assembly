; stack_discipline.asm
; Joshua Thornton 2018

SECTION .text

extern arguments
extern simple_stack_frame

global main
main:

.prologue:
    push ebp        ; preserve the caller's EBP before we overwrite it
    mov ebp, esp    ; setup a base pointer to be the start of our stack frame

    ; A function call
    call simple_stack_frame

    ; A function call with arguments
    push 2
    push 1
    call arguments

.epilogue:
    mov esp, ebp    ; restore esp, thus cleaning up any allocated local variables
    pop ebp         ; restore caller's EBP
    ret