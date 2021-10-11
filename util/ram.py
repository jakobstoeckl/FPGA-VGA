import random
import string

ar = ["0"]*0x1000
ar[0] = "3E"

#for random character generation
#counter = 0
#for item in ar:
    #ar[counter] = (format(ord(random.choice(string.ascii_letters)), "x"))
    #counter = counter + 1

with open("ram.mem", "w") as out:
    for item in ar:
        out.write("%s\n" % item)
out.close()
