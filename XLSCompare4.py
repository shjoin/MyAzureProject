import openpyxl
import pandas as pd
import numpy as np
import datetime



file_xls_1 = 'NSS_TOKENS.xlsx' #Total Tokens 263,675 are in NEWS but not Enrolled in AMEX in ACCUP
sheet_1_1 = 'ALL_NSS_TOKENS'
#sheet_2_2 = 'TokensinNSS2'
colname_1_1 ='CC_TOKEN'

file_xls_2='All_AMEX_TOKEN_NSS.xlsx'
sheet_2='NSSTOKENS'
Colname_2='TOKEN'


dir='C:/SHAILENDRA/pandasXL/Files'


fileOutput= 'ResultOutput_NOTAMEXENROLLED'
sheetOutput= 'NOTEnrollAccUpd'

print("FIle 1 Reading ... ")
DDict_1 = pd.read_excel(dir + '/'+ file_xls_1,sheet_name=[sheet_1_1],usecols=[colname_1_1],index_col=False)   #Data Dictionary, in a disctionary we have multiple data frame with index 0,1..
print("FIle 2 Reading ... ")
DDict_2 = pd.read_excel(dir + '/'+ file_xls_2,sheet_name=[sheet_2],usecols=[Colname_2],index_col=False)

DF_1 =  DDict_1[sheet_1_1]
DF_2_1 = DDict_2[sheet_2]
#DF_2_2 = DDict_2[sheet_2_2]

#DF_2 = pd.concat([DF_2_1, DF_2_2], ignore_index=True)

DF_2 = DF_2_1
print("FIles Mearging  ... ")
ColValMatch=DF_1.merge(DF_2,how="left",left_on=colname_1_1,right_on=Colname_2)
ColValMatch= ColValMatch[ColValMatch[Colname_2].isnull()]   # isnull() and notnull()
#print("Tokens (AMEX) Enrolled In" +  sheet_1_1 + " Counts " , DF_1.count)
#print("Tokens Active in "+ sheet_2 + " Counts " , DF_2.count)
#print("Avable In AccUpd But Not in NSS Counts " , ColValMatch.count)
fileName = fileOutput + '_' + datetime.datetime.now().strftime("%Y%m%d") + '_' + datetime.datetime.now().strftime("%H%M%S") + '.xlsx'
excel_file = pd.ExcelWriter(dir + '/' + fileName)
ColValMatch.to_excel(excel_file,sheet_name=sheetOutput,index=False)
excel_file.save()
excel_file.close()
print("FIle Saved at " ,dir+fileName)