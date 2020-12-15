from sage.all import *
import enchant
import wordninja

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

def chosenPlainText(PlainText,CipherText):
	matrix1=matrix(Zmod(26),2,[ord(PlainText[0])-97,1,ord(PlainText[1])-97,1])
	matrix2=matrix(Zmod(26),2,[ord(CipherText[0])-97,ord(CipherText[1])-97])
	key_matrix=matrix1.inverse()*matrix2
	key=[]
	key.append(key_matrix[0][0])
	key.append(key_matrix[1][0])
	print("The key is: ",key)
	return key
		
cipher_text=input("Enter cipher text: ")
number=26
R=Zmod(number)
list1=[]
for i in range(number):
	temp=mod(i,number)
	list1.append(i)

list2=number.coprime_integers(number)
list=[]
count1=len(list1)
count2=len(list2)
for i in range(count1):
	for j in range(count2):
		list.append(Affine_decryption(list1[i],list2[j],cipher_text))
print("The most probable plain texts would be: ")
decrypted_text_list=analysis(list)
print("By Known cipher text attack: ");
for i in decrypted_text_list:
	print(i)
chosen_plain_text=print("et")
old_cipher_text=input("Encrypt the above plain text and enter corresponding cipher text: ")
key=chosenPlainText("et",old_cipher_text)
print("By chosen plain text attack: ")
print(Affine_decryption(key[1],key[0],cipher_text))


