# -*- coding: utf-8 -*- 
#此脚本将instr内的伪指令编码为十六进制代码，输出到控制台
import binascii
import re
insnum={"add":"000000","sub":"000010","and":"010001","or":"010010","xor":"010100","slt":"000100",
        "sw":"100110","lw":"100111","beq":"110000","jmp":"110010"}
if(__name__=="__main__"):
    instrf = open("instrf")
    for eachline in instrf:
        blk=re.split("\s+",eachline.rstrip())
        #print(blk)
        instr=blk[0].lower()
        base="0b"+insnum[instr]
        if(instr=="jmp"):
            for key in blk[1:]:
                base=base+str(bin(int(key))).replace("0b","").zfill(26)
        elif(instr=="lw" or instr=="beq" or instr=="sw"):
            for key in [blk[2],blk[1]]:
                base=base+str(bin(int(key))).replace("0b","").zfill(5)
            base=base+str(bin(int(blk[3]))).replace("0b","").zfill(16)
        else:
            for key in blk[1:4]:
                base=base+str(bin(int(key))).replace("0b","").zfill(5)
            base=base+"0"*11
        #print(base)
        print(hex(int(base,2)).replace("0x","").zfill(8))
