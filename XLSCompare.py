import openpyxl
import pandas as pd
import numpy as np
import datetime

dir='C:/SHAILENDRA/pandasXL/Files'
file_xls_1='ACCTPD_Tokens700K.xlsx'
sheet_1='AccupTokens'
Colname_1='TOKEN'

file_xls_2 = 'NSS_Tokens700K.xlsx'
sheet_2_1 = 'TokensinNSS1'
#sheet_2_2 = 'TokensinNSS2'
colname_2_1 ='CC_TOKEN'
colname_2_2 ='MAJOR_CARD_CD'

fileOutput= 'ResultOutput'
sheetOutput= 'EnrolledInAccUpdNOTinNSS'

DDict_1 = pd.read_excel(dir + '/'+ file_xls_1,sheet_name=[sheet_1],usecols=[Colname_1],index_col=False)   #Data Dictionary, in a disctionary we have multiple data frame with index 0,1..
DDict_2 = pd.read_excel(dir + '/'+ file_xls_2,sheet_name=[sheet_2_1],usecols=[colname_2_1,colname_2_2],index_col=False)

DF_1 =  DDict_1[sheet_1]
DF_2_1 = DDict_2[sheet_2_1]
#DF_2_2 = DDict_2[sheet_2_2]

#DF_2 = pd.concat([DF_2_1, DF_2_2], ignore_index=True)

DF_2 = DF_2_1

ColValMatch=DF_1.merge(DF_2,how="left",left_on=Colname_1,right_on=colname_2_1)
ColValMatch= ColValMatch[ColValMatch[colname_2_1].isnull()]
print("Tokens (AMEX) Enrolled In" +  sheet_1 + " Counts " , DF_1.count)
print("Tokens Active in "+ sheet_2_1 + " Counts " , DF_2.count)
print("Avable In AccUpd But Not in NSS Counts " , ColValMatch.count)
fileName = fileOutput + '_' + datetime.datetime.now().strftime("%Y%m%d") + '_' + datetime.datetime.now().strftime("%H%M%S") + '.xlsx'
excel_file = pd.ExcelWriter(dir + '/' + fileName)
ColValMatch.to_excel(excel_file,sheet_name=sheetOutput,index=False)
excel_file.save()
excel_file.close()
print("FIle Saved at " ,dir+fileName)