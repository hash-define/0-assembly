; 2.1.0 Return
; Joshua Thornton 2017
%include "macros.asm"

SECTION .text

; Exports
global return_zero
global return_neg_one
global return_cafebabe

return_zero:
    prologue

    ; your code here

    epilogue
    ret

return_neg_one:
    prologue

    ; your code here

    epilogue
    ret

return_cafebabe:
    prologue

    ; your code here

    epilogue
    ret
