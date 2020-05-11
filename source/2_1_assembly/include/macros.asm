%macro prologue 0
    ; 2.1 Prologue
    ; Joshua Thornton 2017
    pushad
    mov ebp, esp

    ; 0x2C: arg2
    ; 0x28: arg1
    ; 0x24: arg0
    ; 0x20: ret
    ; 0x1C: eax
    ; 0x18: ecx
    ; 0x14: edx
    ; 0x10: ebx
    ; 0x0C: esp
    ; 0x08: ebp
    ; 0x04: esi
    ; 0x00: edi

    ; Extract arguments for students
    mov eax, [ebp + 0x24] ; arg0
    mov ebx, [ebp + 0x28] ; arg1
    mov ecx, [ebp + 0x2C] ; arg2
%endmacro

%macro epilogue 0
    ; 2.1 Epilogue
    ; Joshua Thornton 2017

    ; place eax and edx into stack positions
    ; 0x1C: eax
    ; 0x18: ecx
    ; 0x14: edx
    ; 0x10: ebx
    ; 0x0C: esp
    ; 0x08: ebp
    ; 0x04: esi
    ; 0x00: edi
    mov [ebp+0x1C], eax
    mov [ebp+0x14], edx

    ; Hope ebp hasn't been modified
    mov esp, ebp
    popad
%endmacro