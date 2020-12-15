from sage.all import *

def shift_encryption(plain_text,key):
    length=len(plain_text)
    encrypted_text=""
    for i in range(length):
        temp=ord(plain_text[i])-97
        if(temp>=0 and temp<=26):
            encrypted_text+=chr((key+temp)%26+97)
        else:
            encrypted_text+=plain_text[i]
    return encrypted_text

def shift_decryption(encrypted_text,key):
    length=len(encrypted_text)
    decrypted_text=""
    for i in range(length):
        temp=ord(encrypted_text[i])-97
        if(temp>=0 and temp<=26):
            decrypted_text+=chr((temp-key)%26+97)
        else:
            decrypted_text+=encrypted_text[i]
    return decrypted_text

def vigenere_encryption(plain_text,key):
    length=len(plain_text)
    i=0
    encrypted_text=""
    temp_key=0;
    for i in range(length):
        temp=ord(plain_text[i])-97
        if(temp>=0 and temp<=25):
            encrypted_text+=shift_encryption(plain_text[i],ord(key[temp_key])-97)
            temp_key+=1
        else:
            encrypted_text+=plain_text[i]
    return encrypted_text

def vigenere_decryption(encrypted_text,key):
    length=len(encrypted_text)
    i=0
    decrypted_text=""
    temp_key=0;
    for i in range(length):
        temp=ord(encrypted_text[i])-97
        if(temp>=0 and temp<=25):
            decrypted_text+=shift_decryption(encrypted_text[i],ord(key[temp_key])-97)
            temp_key+=1
        else:
            decrypted_text+=encrypted_text[i]
    return decrypted_text

print("VIGENERE CIPHER")
number=26
key="randomkey"
plain_text=input("Enter plain text: ")
plain_text=plain_text.lower()
temp=key
while(len(key)<len(plain_text)):
        key=key+temp
encrypted_text=vigenere_encryption(plain_text,key)
print("Encrypted text: ",encrypted_text)
decrypted_text=vigenere_decryption(encrypted_text,key)
print("Decrypted text: ",decrypted_text)
print("Key used: ",key)
