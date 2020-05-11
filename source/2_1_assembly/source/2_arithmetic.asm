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
global my_remainder

increment:
    prologue

    ; "eax" register contains your value
    ; your code here

    epilogue
    ret

add:
    prologue

    ; "eax" contains first value
    ; "ebx" contains second value
    ; your code here

    epilogue
    ret

negate:
    prologue

    ; "eax" register contains your value
    ; your code here

    epilogue
    ret

subtract:
    prologue

    ; "eax" contains first value
    ; "ebx" contains second value
    ; your code here

    epilogue
    ret

multiply:
    prologue

    ; "eax" contains first value
    ; "ebx" contains second value
    ; your code here

    epilogue
    ret
    
divide:
    prologue

    ; "eax" contains first value
    ; "ebx" contains second value
    ; your code here

    epilogue
    ret
    
my_remainder:
    prologue

    ; "eax" contains first value
    ; "ebx" contains second value
    ; your code here

    epilogue
    ret