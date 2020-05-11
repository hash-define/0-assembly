; 1_local_variables.asm
; A simple loop utilizing local variables
; Joshua Thornton 2018

SECTION .text

global main
main:

.prologue:
    push ebp        ; preserve the caller's EBP before we overwrite it
    mov ebp, esp    ; setup a base pointer to be the start of our stack frame
    sub esp, 0x08   ; subtract some amount from ESP to make the end of the stack frame
    ; +0x04: ret address
    ;  0x00: caller's EBP
    ; -0x04: counter
    ; -0x08: sum

    ; The following assembly implements a loop that might look like this in C:
    ; sum = 0
    ; for (int i = 0; i < 10; i++)
    ;   sum += i

    ; Register choices
    ; [ebp-0x04] = counter
    ; [ebp-0x08] = sum

    .loop_init:
        mov dword [ebp-0x04], 0     ; zero counter
        mov dword [ebp-0x08], 0     ; zero sum

    .loop_cond:
        cmp dword [ebp-0x04], 10    ; check loop bounds
        jge .loop_end               ; continue if less than (exit if greater than or equal)

    .loop_body:
        mov ecx, [ebp-0x04]         ; get counter into register
        add [ebp-0x08], ecx         ; add counter variable to sum variable

    .loop_incr:
        inc dword [ebp-0x04]        ; increment our loop counter
        jmp .loop_cond              ; loop back to condition label

    .loop_end:

.epilogue:
    mov esp, ebp    ; restore esp, thus cleaning up any allocated local variables
    pop ebp         ; restore caller's EBP
    ret