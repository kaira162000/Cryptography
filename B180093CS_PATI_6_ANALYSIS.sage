from sage.all import *
import wordninja
import enchant
import itertools

def keys_combo(length):
	iterable=[]
	for i in range(26):
		iterable.append(i)
	keys=list(itertools.permutations(iterable, length))
	return keys

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

def vigenere_decryption(encrypted_text,key):
        length=len(encrypted_text)
        decrypted_text=""
        for i in range(length):
                decrypted_text+=shift_decryption(encrypted_text[i],key[i])
  
def analysis(list):
        d = enchant.Dict("en_US")
        length=len(list)
        list3=[]
        list4=[]
        for i in range(length):
                count=0
                list3.append(wordninja.split(list[i]))
                for j in range(len(list3[i])):
                        if d.check(list3[i][j]):
                                if len(list3[i][j])!=1 or list3[i][j]=='i' or list3[i][j]=='a':
                                        count+=1
                list4.append(count)
        probable_length=len(cipher_text)/3
        i=2
        decrypted_text_list=[]
        while(i<=probable_length):
                indices = [index for index, element in enumerate(list4) if element == i]
                for j in indices:
                        set=0
                        for k in range(len(list3[j])):
                                if(len(list3[j][k])==1):
                                        if((list3[j][k]!='i') and (list3[j][k]!='a')):
                                                set=1
                                                break
                        if(set==0):
                                decrypted_text_list.append(" ".join(list3[j]))
                i+=1
        return decrypted_text_list

cipher_text=input("Enter cipher text: ")
cipher_text=''.join([i for i in cipher_text if i.isalpha()])
cipher_text=cipher_text.lower()
probable_key_length=int(input("Enter the key length if you are aware: "))
start_text=cipher_text[probable_key_length]
keys=keys_combo(probable_key_length)
length=len(keys)
decrypted_text=[]
for i in range(length):
	decrypted_text.append(vigenere_decryption(cipher_text[:probable_key_length],list(keys[i])))
probable_plain_text=analysis(decrypted_text)
print("The probable plain text: ")
for i in probable_plain_text:
	print(i)
