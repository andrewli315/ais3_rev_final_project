import hashlib
import binascii
import struct
key = [0x12, 0x34, 0x56, 0x78] # no longer than 4 bytes

N = 44377
e = 5
d = 35165



with open("./build/kernel.bin", "rb") as f:
    s = f.read()
    md5 = hashlib.md5(s)
    hexstream = md5.digest()

md5_byte_arr = bytearray(hexstream)
sig = list()
with open("./build/kernel.bin", "ab") as fwriteb:
    for i in range(0,16):
        print('----------------')
        num = int(md5_byte_arr[i])
        print(hex(num))
        cipher = pow(num, d, N)
        print("%s" % (hex(cipher)))
        #plaintext = pow(cipher, e, N)
        #print(struct.pack(">H",cipher))
        sig.append(struct.pack("<H", cipher))
        fwriteb.write(struct.pack("<H", cipher))

with open("./build/kernel2.bin", "ab") as fwriteb:
    for i in sig:
        fwriteb.write(i)

with open("./include/secure-boot.autogen.inc","w") as f:
    f.write(";---- This file is automatically generated during build time ----\n")
    f.write(";---- Please DO NOT try to modify it, see digital_signing.py ----\n")
    f.write(";---- for more informations -------------------------------------\n\n")
    f.write("KERN_BIN_SIZE equ %d\n" % (len(s)))
    f.write("PUB_KEY:\n")
    f.write("\tdd %s\n" % hex(e))
    f.write("N:\n")
    f.write("\tdd %s\n" % hex(N))
