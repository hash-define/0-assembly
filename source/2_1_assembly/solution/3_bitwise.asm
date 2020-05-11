; 2.1.3 Bitwise
; Joshua Thornton 2017
; In these exercises you should use the and, or, xor, shl, and shr instructions
%include "macros.asm"

SECTION .text

; Exports
global bitwise_and
global bitwise_or
global bitwise_xor
global shift_left
global shift_right

bitwise_and:
    prologue

    ; "eax" contains first value
    ; "ebx" contains second value
    ; your code here
    and eax, ebx

    epilogue
    ret

bitwise_or:
    prologue

    ; "eax" contains first value
    ; "ebx" contains second value
    ; your code here
    or eax, ebx

    epilogue
    ret

bitwise_xor:
    prologue

    ; "eax" contains first value
    ; "ebx" contains second value
    ; your code here
    xor eax, ebx

    epilogue
    ret
    
shift_left:
    prologue

    ; "eax" contains first value
    ; "bl" contains second value
    ; your code here
    mov cl, bl
    shl eax, cl

    epilogue
    ret

shift_right:
    prologue

    ; "eax" contains first value
    ; "bl" contains second value
    ; your code here
    mov cl, bl
    shr eax, cl

    epilogue
    ret