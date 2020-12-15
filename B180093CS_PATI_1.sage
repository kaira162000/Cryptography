from sage.all import *
import random

def Affine_encryption(key1,key2,plain_text):
        length=len(plain_text)
        encrypted_text=""
        for i in range(length):
                number=ord(plain_text[i])-97
                if((number>25) or (number<0)):
                        encrypted_text+=plain_text[i]
                else:
                        #number=mod(number,26)
                        temp=key1+key2*number
                        encrypted_text+=chr(int(temp)+97)
        return encrypted_text

def Affine_decryption(key1,key2,encrypted_text):
        length=len(encrypted_text)
        decrypted_text=""
        for i in range(length):
                number=ord(encrypted_text[i])-97
                if((number>25) or (number<0)):
                        decrypted_text+=encrypted_text[i]
                else:
                        number=mod(number,26)
                        temp=(number-key1)/key2
                        decrypted_text+=chr(int(temp)+97)
        return decrypted_text


number=26
R=Zmod(number)
k1=random.randint(0,25)
key1=mod(k1,number)

temp1=number.coprime_integers(number)
key2=random.choice(temp1)
key2=mod(key2,number)

print("AFFINE CIPHER")
plain_text=input("Enter plain text: ")
temp=""
plain_text=''.join([i for i in plain_text if i.isalpha()])
plain_text=plain_text.lower()
encrypted_text=Affine_encryption(key1,key2,plain_text)
decrypted_text=Affine_decryption(key1,key2,encrypted_text)

print("Encryped text: ",encrypted_text)
print("Decryped text: ",decrypted_text)
print("keys used to Add:",key1," to multiply: ",key2)

