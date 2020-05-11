; 2.1.6 Loop
; Joshua Thornton 2017
; In this exercise you should try and utilize the SIB byte of intel's instructions to
; neatly index an array
; NOTE: Addressing-Form specifiers are described in the intel manual. However, nasm will
; handle this for you, you just have to write the instructions in the right format.
%include "macros.asm"

SECTION .text

; Exports
global array_sum

array_sum:
    prologue

    ; "eax" contains an int array pointer
    ; "ebx" contains the number of ints in the array
    ; return the sum of the ints in the array
    ; your code here
    
    xor ecx, ecx            ; zero sum
.loop_cond:
    cmp ebx, 0              ; check if counter zero
    je .finished

.loop_incr:
    dec ebx                 ; decrement counter

.loop_body:
    add ecx, [eax+ebx*4]    ; ecx += ptr + counter * sizeof(int)
    jmp .loop_cond

.finished:
    mov eax, ecx
    
    epilogue
    ret