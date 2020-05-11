; 2.1.1 Type Conversion
; Joshua Thornton 2017
; In these exercises you should use the movsx, movzx and cdq instructions.
%include "macros.asm"

SECTION .text

; Exports
global sign_extend
global zero_extend
global doubleword_to_quadword

sign_extend:
    prologue
    
    ; "al" register contains your value
    ; your code here

    epilogue
    ret

zero_extend:
    prologue

    ; "al" register contains your value
    ; your code here

    epilogue
    ret

doubleword_to_quadword:
    prologue

    ; "eax" register contains your value
    ; your code here

    epilogue
    ret
