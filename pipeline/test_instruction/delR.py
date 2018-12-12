#删除文件中的R
import fileinput
for line in fileinput.input("新建文本文档.txt", backup='.bak',inplace = True):
    print(line.rstrip().replace('R',''))