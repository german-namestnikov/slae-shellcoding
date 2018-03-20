# slae-shellcoding

## How to run this code
I have written a small bash script that creates executable file from .asm file, generates shellcode based on this executable and embed this shellcode into 'executor' C-program that calls shellcode like it was exploited with stack-based buffer overflow.

Here is a small usage example:
```
german@slae-lab:~/slae-shellcoding$ ./make.sh assignment_1/bind_shell.asm 
[+] Assembling with Nasm ...
[+] Linking ...
[+] Removing object file ...
[+] Moving executable into current folder ...
[+] Preparing shellcode ...
[+] Dumping shellcode into executor program ...
[+] Compiling ...
[+] executor file bind_shell.executor ready to rock!

german@slae-lab:~/slae-shellcoding$ ls
assignment_1  bind_shell  bind_shell.executor  make.sh  README.md
```

'Make.sh' script will give you two executable ELF-binaries:
* 'bind_shell' - translated, compiled and linked nasm code (shellcode itself).
* 'bind_shell.executor' - specially crafted binary that changes its execution flow to run your shellcode.

## Code
__Assignment 1__
> Create a Bind TCP Shell shellcode that binds to a port and executes shell on incoming connection.
> Port number should be easily configurable.

Read more [here](https://illegalbytes.com/2018-03-17/slae-assignment-1-tcp-bind-shell).

__Assignment 2__
> Create a Shell_Reverse_TCP shellcode that reverse connects to conﬁgured IP and Port	and execs shell on successful connection.	
> IP and Port should be easily conﬁgurable.

Read more [here](https://illegalbytes.com/2018-03-18/slae-assignment-2-tcp-reverse-shell)

__Assignment 3__
> Study about the Egg Hunter shellcode and create a working demo of the Egghunter.
> Should be configurable for different payloads.

Read more [here](https://illegalbytes.com/2018-03-20/slae-assignment-3-linux-x86-egghunting)

