#!/usr/bin/python
# Python Semi-Esoteric XOR Encoder

import sys

# Attempting to find proper XOR key to hide bad chars
def find_key(bad_bytes):
    for key in range(0, 256):
        suitable = True

        for bad_byte in bad_bytes:
            encoded_byte = bad_byte ^ key

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

shellcode = "\x90" + shellcode
plain_bytes = bytearray(shellcode)
shellcode_length = len(plain_bytes)

bad_bytes = bytearray(bad_chars)

key = find_key(bad_bytes)

encoded_c = ""
positions = ""
for i in range(0, len(plain_bytes)):
    current_byte = plain_bytes[i]

    if current_byte in bad_bytes:
        positions += '\\x%02x' % i
        current_byte = current_byte ^ key
    
    encoded_c += '\\x%02x' % current_byte
    

final = "\\xeb\\x1a\\x5e\\x89\\xf7\\x31\\xc0\\xb0" + "\\x%02x" % shellcode_length + "\\x01\\xc7\\x31\\xc9\\x3a\\x0f\\x75\\x04\\x80\\x36" + "\\x%02x" % key + "\\x47\\x46\\x41\\x48\\x74\\x07\\xeb\\xf1\\xe8\\xe1\\xff\\xff\\xff" + encoded_c + positions

print '"' + final + '";'
