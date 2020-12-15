from sage.all import *
import enchant
import wordninja

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

def known_plain_text(plainText,cipherText):
	return ((ord(cipherText[0])-97)-(ord(plainText[0])-97))%26

cipher_text=input("Enter cipher text: ")
cipher_text=''.join([i for i in cipher_text if i.isalpha()])
cipher_text=cipher_text.lower()
list=[]
for i in range(26):
	list.append(shift_decryption(cipher_text,i))
print("The most probable plain text: ")
print("By known cipher text attack: ")
decrypted_list=analysis(list)
for i in decrypted_list:
	print(i)
print("To perform known plain text attack: ")
old_plain_text=input("Enter known plain text: ")
old_cipher_text=input("Enter it's cipher text: ")
key=known_plain_text(old_plain_text,old_cipher_text)
print("By known plain text attack: ") 
print(shift_decryption(cipher_text,key))
