#!/usr/bin/env BASH
#Developed by JOHN MELODY ME 
cd
echo RUN THIS at 'home' 
cd /home
wget https://raw.githubusercontent.com/magnumripper/JohnTheRipper/bleeding-jumbo/run/office2john.py
#Replace the 'dummy.docx' with the file
echo Done
python office2john.py dummy.docx > hash.txt
echo Cat
cat hash.txt
echo John
john --wordlist=/usr/share/wordlists/nmap.lst hash.txt
john --show hash.txt
clear
hashcat --help
hashcat -a 0 -m 9400 --username -o cracked_pass.txt hash.txt /usr/share/wordlists/nmap.lst
