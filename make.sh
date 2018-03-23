#!/bin/bash

elf_name="${1%.*}"

echo '[+] Assembling with Nasm ...'
nasm -f elf32 -o $elf_name.o $1

echo '[+] Linking ...'
ld -o $elf_name $elf_name.o

echo '[+] Removing object file ...'
rm $elf_name.o

echo '[+] Moving executable into current folder ...'
mv $elf_name . 

elf_name=$(basename $elf_name)


echo '[+] Preparing shellcode ...'
shellcode=$(objdump -d $elf_name |grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-6 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/";/g')

echo '[+] Dumping shellcode into executor program ...'
cat > $elf_name.executor.c <<EOL

#include<stdio.h>
#include<string.h>

unsigned char shellcode[] = $shellcode

int main()
{
    printf("Shellcode Length: %d\n", strlen(shellcode));
    int (*ret)() = (int(*)())shellcode;
 
    ret();
}

EOL

echo '[+] Compiling ...'
gcc -fno-stack-protector -z execstack $elf_name.executor.c -o $elf_name.executor

rm $elf_name.executor.c

echo '[+] executor file '$elf_name.executor' ready to rock!'
