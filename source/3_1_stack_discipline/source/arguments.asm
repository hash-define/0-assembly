; stack_discipline.asm
; Joshua Thornton 2018

SECTION .text

global arguments
arguments:

.prologue:
    push ebp
    mov ebp, esp
    ; +0x0C: int arg1
    ; +0x08: int arg0
    ; +0x04: ret address
    ;  0x00: caller's EBP

    .read_in_args:
    mov ecx, [ebp+0x08]
    mov eax, [ebp+0x0C]


.epilogue:
    mov esp, ebp
    pop EBP
    ret