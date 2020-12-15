from sage.all import *
import random

def random_key_generator(n):
	number=26
	list=Integers(number)
	list_co_primes=number.coprime_integers(number)
	determinent=0
	exists=0
	while(determinent==0 or (not exists)):
        	matrix=random_matrix(list,n,n)
        	determinent=matrix.determinant()
        	if determinent in list_co_primes:
                	exists=1
	return matrix

def hill_encryption(plain_text,key):
	rows=int(len(plain_text)/5)
	remainder=len(plain_text)%5
	if(remainder!=0):
		rows+=1	
	i=len(plain_text)
	while(rows*5!=i):
		plain_text+='z'
		i+=1
	temp=[]
	for i in range(len(plain_text)):
        	temp.append(ord(plain_text[i])-97)
	matrix1=matrix(Zmod(26),rows,temp)
	encrypted_matrix=matrix1*key
	encrypted_text=""
	for j in range(rows):
		for i in range(5):
        		encrypted_text+=chr(int(encrypted_matrix[j][i])+97)
	return encrypted_text

def hill_decryption(encrypted_text,key):
	temp=[]
	length=len(encrypted_text)
	for i in range(length):
       		temp.append(ord(encrypted_text[i])-97)
	rows=int(len(encrypted_text)/5)
	matrix1=matrix(Zmod(26),rows,temp)
	decrypted_matrix=matrix1*(key.inverse())
	decrypted_text=""
	for j in range(rows):
		for i in range(5):
        		decrypted_text+=chr(int(decrypted_matrix[j][i])+97)
	return decrypted_text

print("HILL CIPHER")
plain_text=input("Enter plain text: ")
plain_text=''.join([i for i in plain_text if i.isalpha()])
plain_text=plain_text.lower()
key=random_key_generator(5)
encrypted_text=hill_encryption(plain_text,key)
decrypted_text=hill_decryption(encrypted_text,key)
print("Encrypted text is: ",encrypted_text)
print("Decrypted text is: ",decrypted_text)
print("Key used: ")
print(key)
