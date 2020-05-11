; preservation.asm
; Register preservation exercise
; Joshua Thornton 2017

EXIT_SUCCESS equ 0
SECTION .text
global main 
main:

    push ebp
    mov ebp, esp
    
    ; This function might look like this in C.
    ; 1. int main() {
    ; 2.    int sum = 0;
    ; 3.    for(int i = 0; i < 10; i++)
    ; 4.        sum = sum_function(sum, i);
    ; 5. }
    
    ; HINT: subtract enough space from esp to store any local variables
    ; HINT: some local variables you may want to store: "i" and "sum"
    ; HINT: if you want to use persistent registers: ebx, edi, esi you
    ;       will need to save them to your stack first
    ; HINT: you may also want to subtract enough space to store any
    ;       arguments to the sum function
    sub esp, 0x10
    ; Document your stack layout
    ; +0x04: ret address
    ;  0x00: previous ebp               <--- EBP POINTS HERE
    ; -0x04: i                          | 
    ; -0x08: sum                        |
    ; --- End Locals / Start Args ---   |
    ; +0x04: arg1                       |
    ; +0x00: arg0                       <--- ESP POINTS HERE
    
.loop_init:
    ; Initialize a loop counter here
    mov dword [ebp-0x04], 0     ; zero "i"
    mov dword [ebp-0x08], 0     ; zero "sum"

.loop_cond:
    ; Compare your loop counter here
    cmp dword [ebp-0x04], 10    ; compare "i" to 10
    jge .loop_end               ; exit if i >= 10
    
.loop_body:
    ; Call the sum function
    ; HINT: remember that the contents of eax, ecx, edx can be
    ;       freely overwritten inside any function you call. 
    mov eax, [ebp-0x4]  ; get "i" into eax
    mov ecx, [ebp-0x8]  ; get "sum" into ecx
    
    mov [esp+0x04], eax ; pass "i" into arg1
    mov [esp+0x00], ecx ; pass "sum" into arg0
    call sum_function
    
    ; Store result back into sum
    mov [ebp-0x8], eax

.loop_incr:
    ; Increment your loop counter here and jump back to the condition
    add dword [ebp-0x04], 1
    jmp .loop_cond
    
.loop_end:

.epilogue:
    mov eax, EXIT_SUCCESS
    mov esp, ebp
    pop ebp
    ret
    

sum_function:
    push ebp
    mov ebp, esp
    ; Stack Layout:
    ; +0x0C: arg1
    ; +0x08: arg0
    ; +0x04: ret address
    ; +0x00: previous ebp
    
    ; move arguments into ecx and edx
    mov ecx, [ebp+0x8]  ; arg0
    mov edx, [ebp+0xC]  ; arg1
    
    ; zero sum
    xor eax, eax
    
    ; add arguments
    add eax, edx
    add eax, ecx
    
    ; clear ecx and edx for good measure
    xor ecx, ecx
    xor edx, edx
    
    mov esp, ebp
    pop ebp
    ret
