; Count Words
; int count_words( char *buffer, size_t size )
; returns the number of words in the buffer
; words printable characters delimeted by whitespace or non-printable characters
; Joshua Thornton 2015

; External Imports
extern SreLibIsSpace 
extern SreLibIsPrint

SECTION .text

global count_words
count_words:

    ; Again you have to write everything yourself.
    ; This function is tough because you are forced to use local variables in 
    ; addition to registers to store state. You are also forced to call a
    ; number of functions.
    
    ret