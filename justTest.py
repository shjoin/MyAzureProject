import pandas
import pymsteams
from pypika import Query ,Table,functions as fn,analytics as an

def iAmAFunction():
    vals={}
    vals['dev_pool']= 'cache'
    vals['total_lives']={'total_members':10,'total_employees':20}
    print('shjo',vals['total_lives'])
    return vals

def lambda_func(pg):
    x=2024
    g=lambda x: pg in x[1]
    #print(x)
    return g

def lambda_func3(spg):
    x=2024
    g=lambda x: x['name']==spg
    #print(g)
    return g    

def lambda_func2(pg):
    return lambda x: 3*x +1

def func(x):
    return 3*x+1
      #g=lambda x: 3*x +1


if __name__ == "__main__":
    value=iAmAFunction()
    #print(type(value))
    #print(value)#{'dev_pool': 'cache', 'total_lines': {'total_members': 10, 'total_emploees': 20}}
    #print(value['dev_pool']['total_members'])#TypeError: string indices must be integers
    #print(value['total_lives']['total_members'])

    #print('lambda function',lambda x: 3*x +1)
    g=lambda x: 3*x +1
    #print('lambda function output',g(2))
    pg_list=[2021,2022]
    k=lambda_func(pg_list)
    var_1 =10000
    var_2='Joshi'
    print(f" Shailendr {var_2} print tetsing {var_1} ")
    #print(k)
    #print(func(2))
    #print(2021 in pg_list)
    mylist=['name','name2']
    #print(mylist[0][0])
    h=lambda_func3(mylist)
    #print(h([1]))
    l=lambda x:x['name'] == mylist
    dic={'name':'name'}
    #print(l(dic))ILENDRA
    str1='["INSERT INTO misc_credit SHAILENDRA"'
    str2='name2'
    mylist=[str1,str2]
    #result_bool=False
    #print(mylist)
    for statement in mylist:
      if "INSERT INTO misc_credit" in statement:
          result_bool=True
          break         

    #print(result_bool)  
    '''
    print("INSERT INTO misc_credit" in mylist)
    ls = ["Hello from AskPython", "Hello", "Hello boy!", "Hi"]
 
    for match in ls:
       if "Hello" in match:
            print(match)
    '''
    myteamsmsg=pymsteams.connectorcard("<Microsoft Webhook URL>")
    myteamsmsg.title("d1- Americas Virtual Stand-up")
    #print(myteamsmsg.title())
    #print('pymsteams.connectorcard object at' in myteamsmsg)
    #print('tuple')
    my_tuple=('Microsoft Webhook URL','Hello from AskPython',10000022)
    #print(my_tuple)
    mylist2=[1,'shailendra jsohi',[1,2]]
    mylist2[2].append('t')
    #print(mylist2) #[1, 'shailendra jsohi', [1, 2, 't']]
    #mylist2[1].append('T')#AttributeError: 'str' object has no attribute 'append' because mylist2[1] is a not a list
    generic= 'INSERT INTO tablename fdsfdsfdsfsdf,' +\
              'sadad, ewqrew ,werf ,wer, werewrwerwerwe, ewrwerwer, '+\
              'fdsfdsfsdf, fdsfdsfsdfdsfsdfsdf ,sdfdsfsdfsd) '
    #for idx,row in enumerate(generic):
     #   endline_char=';' if idx == len(generic)-1 else ', '
     #   print(idx,row)
        #generic =generic + \
         #f'(Insert("{row[0]}",{row[1]}, '\
    
    #print(generic)
    req={'reqweer':100,
    'ertt':34343,
    'ttttt':98}
    print(req)
