; 2.1.2 Arithmetic
; Joshua Thornton 2017
; In these exercises you should use the inc, add, neg, sub, imul and idiv instructions.
%include "macros.asm"

SECTION .text

; Exports
global increment
global add
global negate
global subtract
global multiply
global divide
global remainder

increment:
    prologue

    ; "eax" register contains your value
    ; your code here
    inc eax

    epilogue
    ret

add:
    prologue

    ; "eax" contains first value
    ; "ebx" contains second value
    ; your code here
    add eax, ebx

    epilogue
    ret

negate:
    prologue

    ; "eax" register contains your value
    ; your code here
    neg eax

    epilogue
    ret

subtract:
    prologue

    ; "eax" contains first value
    ; "ebx" contains second value
    ; your code here
    sub eax, ebx

    epilogue
    ret

multiply:
    prologue

    ; "eax" contains first value
    ; "ebx" contains second value
    ; your code here
    imul ebx

    epilogue
    ret
    
divide:
    prologue

    ; "eax" contains first value
    ; "ebx" contains second value
    ; your code here
    cdq
    idiv ebx

    epilogue
    ret

remainder:
    prologue

    ; "eax" contains first value
    ; "ebx" contains second value
    ; your code here
    cdq
    idiv ebx
    mov eax, edx    

    epilogue
    ret