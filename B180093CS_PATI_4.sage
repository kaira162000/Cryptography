from sage.all import *
import random

def substitution_encryption(plain_text,key):
        length=len(plain_text)
        encrypted_text=""
        for i in range(length):
                index=ord(plain_text[i])-97
                if(index>=0 and index<26):
                        encrypted_text+=key[index]
                else:
                        encrypted_text+=plain_text[i]
        return encrypted_text

def substitution_decryption(encrypted_text,key):
        length=len(encrypted_text)
        decrypted_text=""
        for i in range(length):
                index=ord(encrypted_text[i])-97
                if(index>=0 and index<26):
                        decrypted_text+=chr(key.index(encrypted_text[i])+97)
                else:
                        decrypted_text+=encrypted_text[i]
        return decrypted_text

number=26
print("SUBSTITUTION CIPHER")
plain_text=input("Enter plain text: ")
plain_text=''.join([i for i in plain_text if i.isalpha()])
plain_text=plain_text.lower()

key=[]
for i in range(number):
        key.append(chr(i+97))
random.shuffle(key)
encrypted_text=substitution_encryption(plain_text,key)
print("Encrypted text: ",encrypted_text)
decrypted_text=substitution_decryption(encrypted_text,key)
print("Decrypted text: ",decrypted_text)
print("key used is: ",key)
