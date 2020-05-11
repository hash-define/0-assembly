; 2.1.5 Conditional
; Joshua Thornton 2017
; In these exercises you should use the cmp, test and jcc instructions
%include "macros.asm"

SECTION .text

; Exports
global is_equal
global is_greater_than
global is_less_than
global is_bit_set

is_equal:
    prologue

    ; "eax" contains first value
    ; "ebx" contains second value
    ; return 1 if equal else 0
    ; your code here

    epilogue
    ret

is_greater_than:
    prologue

    ; "eax" contains first value
    ; "ebx" contains second value
    ; return 1 if greater than else 0
    ; your code here

    epilogue
    ret
    
is_less_than:
    prologue

    ; "eax" contains first value
    ; "ebx" contains second value
    ; return 1 if less than else 0
    ; your code here

    epilogue
    ret

is_bit_set:
    prologue

    ; "eax" contains the value
    ; "ebx" contains the bit mask
    ; return 1 if the any of the masked bits are set else 0
    ; your code here

    epilogue
    ret