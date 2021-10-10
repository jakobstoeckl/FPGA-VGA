import random
import string

ar = ["0"]*0x1000

counter = 0
for item in ar:
    #ar[counter] = (format(ord(random.choice(string.ascii_letters)), "x"))
    ar[counter] = 0x00
    counter = counter + 1

with open("ram.txt", "w") as out:
    for item in ar:
        out.write("%s\n" % item)
out.close()
