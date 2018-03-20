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

__This won't work for egg hunting shellcodes!__

Please, use custom executors I store in assignment_3 folder.

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

## Hacks
__XOR Encoder__

Allow you to perform xor encoding of your shellcode to avoid bad characters. It will find XOR key for you, just run it with this command:

~~~
german@slae-lab:~/shellcoding/encoder$ python xor-encoder.py "\xcc\xcc\x00" "\x00"

Suitable key found: \x01
Encoded: "\xeb\x0d\x5e\x31\xc9\xb1\x03\x80\x36\x01\x46\xe2\xfa\xeb\x05\xe8\xee\xff\xff\xff\xcd\xcd\x01"
~~~

Also, there is decoder asm file. You can try to optimize it, but don't forget to change decoder shellcode in the python script
