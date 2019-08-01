import hashlib

key = [0x12, 0x34, 0x56, 0x78] # no longer than 4 bytes

intkey = 0
for i in range(0,4):
    print(hex(key[3-i] << i*8))
    intkey |= key[3-i] << i*8

with open("./build/kernel.bin", "rb") as f:
    s = f.read()
    md5 = hashlib.md5(s)
    hexstream = md5.digest()
h=int.from_bytes(hexstream, byteorder='big', signed=False)
fwriteb = open("./build/kernel.bin", "ab")

for i in range(0,16):
    hh = (h>>(128-8*(i+1)))%(2**8)
    hh=(hh**239)%64507
    print(hex(hh))
#    fwriteb.write(bytes([hh//(2**32),hh//(2**24)%256,hh//(2**16)%256,hh%256]))
    fwriteb.write(bytes([hh%256,(hh//(2**8))%256]))
    
'''
for i in range(0,4):
    j = 0
    while j < 4:
        byte_to_w = hexstream[i*4 + j]
        xored = byte_to_w ^ key[3 - j]
        print("%s, %s" % (hex(byte_to_w), hex(xored)))
        fwriteb.write(bytes([xored]))
        j += 1
'''        
fwriteb.close()

with open("./include/secure-boot.autogen.inc","w") as f:
    f.write(";---- This file is automatically generated during build time ----\n")
    f.write(";---- Please DO NOT try to modify it, see digital_signing.py ----\n")
    f.write(";---- for more informations -------------------------------------\n\n")
    f.write("KERN_BIN_SIZE equ %d\n" % (len(s)))
    f.write("EFUSE_KEY:\n")
    f.write("\tdd %s\n" % hex(intkey))
    
