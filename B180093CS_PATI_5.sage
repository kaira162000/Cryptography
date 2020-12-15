from sage.all import *
import random

def transposition_encryption(plain_text,key1,key2):
	length=len(plain_text)
	rows=int(length/key1)
	if(length%key1!=0):
		rows+=1
	while(length!=rows*5):
		plain_text+="z"
		length+=1
	temp=[]
	for i in range(length):
		temp.append(ord(plain_text[i])-97) 
	plain_text_matrix=matrix(Zmod(26),rows,temp)
	#print(plain_text_matrix)
	column_lists=[]
	temp_list=[]
	shuffled_column_list=[]
	for i in range(key1):
		temp_list=[]
		for j in range(rows):
			temp_list.append(plain_text_matrix[j][i])
		column_lists.append(temp_list)
	for i in range(key1):
		#print(key2[i])
		shuffled_column_list.append(column_lists[key2[i]])
	#print(column_lists)
	encrypted_matrix=column_matrix(shuffled_column_list)
	#print(encrypted_matrix)
	encrypted_text=""
	for i in range(key1):
		for j in range(rows):
			encrypted_text+=chr(int(encrypted_matrix[j][i])+97)
	return encrypted_text

def transposition_decryption(encrypted_text,key1,key2):
	length=len(encrypted_text)
	rows=int(length/key1)
	temp=[]
	for j in range(rows):
		i=0
		while(i<key1):
			temp.append(ord(encrypted_text[i*rows+j])-97)
			i+=1
	encrypted_text_matrix=matrix(Zmod(26),rows,temp)
	column_lists=[]
	temp_list=[]
	shuffled_column_list=[]
	for i in range(key1):
        	temp_list=[]
        	for j in range(rows):
                	temp_list.append(encrypted_text_matrix[j][i])
        	column_lists.append(temp_list)
	for i in range(key1):
		j=key2.index(i)
		shuffled_column_list.append(column_lists[j])
	decrypted_matrix=column_matrix(shuffled_column_list)
	#print(decrypted_matrix)
	decrypted_text=""
	for i in range(rows):
		for j in range(key1):
			decrypted_text+=chr(int(decrypted_matrix[i][j])+97)
	return decrypted_text

print("TRANSPOSITION CIPHER")
number=26
key1=5
key2=[0,1,2,3,4]
random.shuffle(key2)
plain_text=input("Enter plain text: ")
plain_text=''.join([i for i in plain_text if i.isalpha()])
plain_text=plain_text.lower()
plain_text=plain_text.replace(" ","")
encrypted_text=transposition_encryption(plain_text,key1,key2)
print("Encrypted text: ",encrypted_text)
decrypted_text=transposition_decryption(encrypted_text,key1,key2)
print("Decrypted text: ",decrypted_text)
print("Keys used: ")
print(key1)
print(key2)
