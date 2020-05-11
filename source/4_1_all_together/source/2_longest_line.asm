; Longest Line 
; int longest_line( char *buffer, size_t size )
; returns the longest line in the file
; Joshua Thornton 2015

NEW_LINE_CHAR   equ 10
SECTION .text

global longest_line
longest_line:

    ; You have to write it all yourself this time
    ; This is hard!
    ; Here are some tips:
    ; 1. start with function prologue and epilogue
    ; 2. work out what state you need to store
    ; 3. work out what functions you need to call and what their arguments are
    ;   3.1 many solutions won't call any functions
    ; 4. allocate enough stack space for:
    ;   4.1 saving and restoring registers
    ;   4.2 local variables
    ;   4.3 any function arguments
    ; 5. document stack space and register use

    ret
