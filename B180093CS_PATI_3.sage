from sage.all import *
import random

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


number=26
key=random.randint(1,25)
print("SHIFT CIPHER")
plain_text=input("Enter plain text: ")
plain_text=''.join([i for i in plain_text if i.isalpha()])
plain_text=plain_text.lower()
encrypted_text=shift_encryption(plain_text,key)
print("Encrypted text: ",encrypted_text)
decrypted_text=shift_decryption(encrypted_text,key)
print("Decrypted text: ",decrypted_text)
print("Key used: ",key)
                        
