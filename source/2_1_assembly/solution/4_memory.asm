; 2.1.4 Memory
; Joshua Thornton 2017
; In these exercises you should use various stos, scas and movs instructions.
; In the final exercise you should try and utilize the SIB byte of intel's instructions to
; neatly index an array
; NOTE: Addressing-Form specifiers are described in the intel manual. However, nasm will
; handle this for you, you just have to write the instructions in the right format.
; The instruction prefixes "rep" and "repne" may also be useful
%include "macros.asm"

SECTION .text

; Exports
global memory_set
global memory_scan
global memory_copy
global int_array_index

memory_set:
    prologue

    ; "eax" contains the dst pointer
    ; "bl" contains the value to set
    ; "ecx" is the size of the buffer
    ; your code here
    mov edi, eax
    mov al, bl
    rep stosb

    epilogue
    ret

memory_scan:
    prologue

    ; "eax" contains the haystack pointer
    ; "bl" contains the needle value
    ; "ecx" is the size of the haystack buffer
    ; return the pointer to the needle
    
    ; NOTE: you can assume the haystack always contains the needle
    
    ; your code here
    mov edi, eax
    mov al, bl
    repne scasb
    lea eax, [edi-1]

    epilogue
    ret

memory_copy:
    prologue

    ; "eax" contains the dst pointer
    ; "ebx" contains the src pointer
    ; "ecx" is the size to copy
    ; your code here
    mov edi, eax
    mov esi, ebx
    rep movsb

    epilogue
    ret

int_array_index:
    prologue

    ; "eax" contains a pointer to an int array
    ; "ebx" contains the index to derefence
    ; your code here
    mov eax, [eax + ebx * 4]

    epilogue
    ret