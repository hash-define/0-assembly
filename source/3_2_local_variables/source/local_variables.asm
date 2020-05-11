; 1_local_variables.asm
; A simple loop utilizing local variables
; Joshua Thornton 2018

SECTION .text

global main
main:

.prologue:
    push ebp        ; preserve the caller's EBP before we overwrite it
    mov ebp, esp    ; setup a base pointer to be the start of our stack frame
    sub esp, 0x04   ; subtract some amount from ESP to make the end of the stack frame
    ; +0x04: ret address
    ;  0x00: caller's EBP
    ; -0x04: <some variable>

    ; The following assembly implements a loop that might look like this in C:
    ; sum = 0
    ; for (int i = 0; i < 10; i++)
    ;   sum += i

    ; Register choices
    ; ecx = counter
    ; eax = sum

    .loop_init:
        xor ecx, ecx    ; zero counter
        xor eax, eax    ; zero sum

    .loop_cond:
        cmp ecx, 10     ; check loop bounds
        jge .loop_end   ; continue if less than (exit if greater than or equal)

    .loop_body:
        add eax, ecx    ; add counter variable to sum variable

    .loop_incr:
        inc ecx         ; increment our loop counter
        jmp .loop_cond  ; loop back to condition label

    .loop_end:

    ; YOUR TASK:
    ; Modify this function to use local variables to store the counter and the sum instead of
    ; using registers .
    ; 1. Subtract enough from ESP during the prologue for 2 integers
    ; 2. Document the stack layout with variables relative to EBP (started for you on line 16)
    ; 3. replace ECX and EAX throughout loop with local variables
    ; NOTE: You should only store data in the local variables, but some instructions will
    ;       temporarily require you to move a value to a register

.epilogue:
    mov esp, ebp    ; restore esp, thus cleaning up any allocated local variables
    pop ebp         ; restore caller's EBP
    ret