from sage.all import *

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

def KnownPlainText(plainText,cipherText):
	dict={}
	for i in range(len(plainText)):
		dict[cipherText[i]]=plainText[i]
	return dict	
	
cipher_text=input("Enter cipher text: ")
cipher_text=''.join([i for i in cipher_text if i.isalpha()])
cipher_text=cipher_text.lower()
frequencies = {} 
for char in cipher_text: 
   if char in frequencies: 
      frequencies[char] += 1
   else: 
      frequencies[char] = 1
for i in frequencies:
	frequencies[i]=frequencies[i]*100/len(cipher_text)
sorted_freq = dict(sorted(frequencies.items(),
                           key=lambda item: item[1],
                           reverse=True))
list=['e','t','a','o','i','n','s','h','r','l','d','c','u','m','w','f','g','y','p','b','v','k','j','x','q','z']
list1=[]
for i in sorted_freq:
	list1.append(i)
dict_key1={}
for i in range(len(list1)):
	dict_key1[list1[i]]=list[i]
key=[]
j=0
for i in range(26):
	key.append(0)
for i in list1:
	key[ord(i)-97]=list[j]
	j+=1
while(j!=26):
	position=key.index(0)
	key[position]=list[j]
	j+=1
decrypted_text=substitution_decryption(cipher_text,key)
print("The probable plain text would be: ",decrypted_text)
print("The key used: ",dict_key1)
print("By known plain text attack: ")
string=input("Enter known plain text: ")
known_plain_text=''.join([i for i in string if i.isalpha()])
known_plain_text=known_plain_text.lower()
string=input("Enter it's cipher text: ")
known_cipher_text=''.join([i for i in string if i.isalpha()])
known_cipher_text=known_cipher_text.lower()
dict=KnownPlainText(known_plain_text,known_cipher_text)
decryptedtext=""
for i in range(26):
	j=chr(i+97)
	if(not j in dict):
		if(j in dict_key1):
			dict[j]=dict_key1[j]	
for i in cipher_text:
	decryptedtext+=dict[i]
print(decryptedtext)
