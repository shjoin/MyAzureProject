import re

mystr='THis ia a Python3.9.54 and it @ is 78 very easy languang_@ 4  4567 543 8765 190.343.678.121'
mypartrn1='[@a]'
mypartrn2='i[ts]'
mypartrn3='[a-z]'
mypartrn4='[a-zA-Z0-9]'# from a to z or A to Z or 0 to 9
mypartrn5='\w\w'# from a to z or A to Z or 0 to 9
mypartrn6='\w\w\w'# three chars combination
mypartrn7='\W'# just opposite of \w ,like spaces @ , Matches any character not part of \w
mypartrn8='\d'# matches decimal digit 0-9
mypartrn9='Python\d'# matches decimal digit 0-9
mypartrn10='\d\d'# matches decimal digit 0-9
print(re.findall(mypartrn1,mystr))#['a', 'a', 'a', '@', 'a', 'a', 'a']
print(re.findall(mypartrn2,mystr))#['is', 'it', 'is']
print(re.findall(mypartrn5,mystr))#['Th', 'is', 'ia', 'Py', 'th', 'on', 'an', 'it', 'is', 've', 'ry', 'ea', 'sy', 'la', 'ng', 'ua', 'ng']
print(re.findall(mypartrn6,mystr))#['Thi', 'Pyt', 'hon', 'and', 'ver', 'eas', 'lan', 'gua', 'ng_']
print(re.findall(mypartrn7,mystr))#[' ', ' ', ' ', ' ', ' ', ' ', '@', ' ', ' ', ' ', ' ', '@']
print(re.findall(mypartrn8,mystr))#['3', '9', '5', '4', '4']
print(re.findall(mypartrn9,mystr))#['Python3']
print(re.findall(mypartrn10,mystr))#['54', '78']
mystr='THis ia a Python3.9.54 and it @ is 78 very easy languang_@ 4  190.343.678.121 1234565677567567123 4567 543 1234 8765  sdfsdfsdfsdfsdf uyudfgetdf4weww4334'
mypartrn11='\d\d\d'# matches decimal digit 0-9
mypartrn12='\d\d\d.\d\d\d.\d\d\d.\d\d\d'# mypartrn12 ['190.343.678.121', '123456567756756']
mypartrn13='\d\d\d\.\d\d\d\.\d\d\d\.\d\d\d'#mypartrn13 ['190.343.678.121'] .- matches any single char except newline char
mypartrn14='\w\w\w.\w\w\w.\w\w\w.\w\w\w'#mypartrn13 ['190.343.678.121'] .- matches any single char except newline char
print(f"digit pattern  {re.findall(mypartrn11,mystr)}")
print(f'mypartrn12 {re.findall(mypartrn12,mystr)}') #mypartrn12 ['190.343.678.121', '123456567756756']
print(f'mypartrn13 {re.findall(mypartrn13,mystr)}') #['190.343.678.121']
print(f"pattern mypartrn14 {re.findall(mypartrn14,mystr)}") #digit pattern ['190.343.678.121', 'sdfsdfsdfsdfsdf', 'uyudfgetdf4weww']
mystr='is it a learn Python3.9.54 and learn'
mypartrn15='^i[st]'
print(re.findall(mypartrn15,mystr))#['is']
mypartrn16='learn$'
print(re.findall(mypartrn16,mystr))#['learn']
mystr='is it a learn Python 3.9.54learn and learn  learn'
mypartrn16='\\blearn' #checking left space
print(f"blearn {re.findall(mypartrn16,mystr)}")#['learn', 'learn', 'learn']
mypartrn16=r'\blearn' #raw string ,checking space (not a back space) Best practice
print(f"blearn2 {re.findall(mypartrn16,mystr)}")#['learn', 'learn', 'learn']
mystr='is it a learn Python 3.9.54learn and learnis  learn'
mypartrn16=r'\blearn\b' #raw string ,checking complete word (both side should have space)
mystr='is it a learn Python 3.9.54learn and alearnis asd alearn'
print(f"BlearnB4 {re.findall(mypartrn16,mystr)}")#['learn', 'learn']
mypartrn17=r'\Blearn\B' # find complete word who has no spaces (without space
print(re.findall(mypartrn17,mystr))#['learn']

mypartrn18=r'\blearn\b' # find complete word
#print(re.findall(mypartrn17,mystr))#['learn', 'learn']


