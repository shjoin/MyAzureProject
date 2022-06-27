import openpyxl
import pandas as pd
import numpy as np

#wb= openpyxl.load_workbook('C:\SHAILENDRA\pandasXL\TESTTOKEN.xlsx')
#sheet1 = wb.get_sheet_by_name('NssToken')
#sheet2 = wb.get_sheet_by_name('acctupToken')
#sheet.title = 'df data'
#wb.save('H:/df_out.xlsx')

#xlr = pd.ExcelWriter('df_out.xlsx')
#df.to_excel(xlr, 'df data')
#xlr.save()



#data=pd.read_excel("TESTTOKEN.xlsx",sheet_name="NssToken")
#pd.read_excel("TESTTOKEN.xlsx",sheet_name="acctupToken")
#data=pd.read_excel("TESTTOKEN.xlsx",sheet_name=["NssToken","acctupToken"])  # stores in python dictionay
#print(type(data))
#print(data["acctupToken"])

#dataSet=pd.read_excel("C:/SHAILENDRA/pandasXL/TESTTOKEN2.xlsx",sheet_name=["AccUpdToken","nssToken1","nssToken2"],usecols=["AccUpdToken".TOKEN,"nssToken1".CC_TOKEN,"nssToken2".CC_TOKEN])  # stores in python dictionay all sheet
#print(data)

##DF_Upder=pd.read_excel("C:/SHAILENDRA/pandasXL/TESTTOKEN2.xlsx");   #pandas.core.frame.DataFrame
#NSS_TOKEN_Amex_50K.
#accupd sheet AccUpdToken AccUpdToken2
#TESTTOKEN2.
#RTB_Amex_60K.xlsx,RTBToken col TOKEN_RTB
#NOT_IN_NSS_Tokens.xlsx  TokensNotinNSS col TOKEN_Accup


#DDict_Upder=pd.read_excel("C:/SHAILENDRA/pandasXL/NSS_TOKEN_Amex_50K.xlsx",sheet_name=["AccUpdToken"],usecols=["TOKEN"],index_col=False)   #Data Dictionary, in a disctionary we have multiple data frame with index 0,1..
DDict_Upder=pd.read_excel("C:/SHAILENDRA/pandasXL/NOT_IN_NSS_Tokens.xlsx",sheet_name=["TokensNotinNSS"],usecols=["TOKEN_Accup"],index_col=False)   #Data Dictionary, in a disctionary we have multiple data frame with index 0,1..
DDict_NSS=pd.read_excel("C:/SHAILENDRA/pandasXL/RTB_Amex_60K.xlsx",sheet_name=["RTBToken"],usecols=["TOKEN_RTB"],index_col=False)
#DDict_NSS=pd.read_excel("C:/SHAILENDRA/pandasXL/RTB_Amex_60K.xlsx",sheet_name=["nssToken1","nssToken2"],usecols=["CC_TOKEN"],index_col=False)
##print(type(DF_Upder))
#df_Upder = pd.DataFrame(dataSetUpder,columns= ['TOKEN'])
#Nss1_DF= dataSetNSS["nssToken1"]
#df_Nss = pd.DataFrame(dataSetNSS,columns= ['CC_TOKEN'])
##print(dataSetUpder["TOKEN"] )
#print(dataSetNSS)
#print("Fsghi")

#print(dataSetUpder)
#AccUpdToken ,AccUpdToken2
Accupd1_DF=DDict_Upder["TokensNotinNSS"]
Nss1_DF= DDict_NSS["RTBToken"]
print("Tokens availableIn AccUp Counts " , Accupd1_DF.count)
print("Tokens Active in RTB Counts " , Nss1_DF.count)
#Nss2_DF=DDict_NSS["nssToken2"]
#DF_union = pd.concat([Nss1_DF, Nss2_DF], ignore_index=True)
#print(DF_union)
#TokenMatch=Accupd1_DF.merge(DF_union,how="left",left_on="TOKEN",right_on="CC_TOKEN")
TokenMatch=Accupd1_DF.merge(Nss1_DF,how="left",left_on="TOKEN_Accup",right_on="TOKEN_RTB")
TokenMatch= TokenMatch[TokenMatch['TOKEN_RTB'].notnull()]

print("ActiveInRTBNOTinNSS Counts " , TokenMatch.count)
excel_file=pd.ExcelWriter("ActiveInRTBNOTinNSS_3.xlsx")
TokenMatch.to_excel(excel_file,sheet_name="ActiveButNotinNSS",index=False)
excel_file.save()
excel_file.close()
print("FIle Saved")


##print(Accupd1_DF.info(),Nss1_DF.info(),Nss2_DF.info())
#TokenMatch=Accupd1_DF.where(Accupd1_DF["TOKEN"] == "9AOR2PAJKGE7BP4JJ8MM")
#TokenMatch= np.where(Accupd1_DF["TOKEN"] == Nss1_DF["CC_TOKEN"], 'True', 'False')  #create new column in df1 to check if  match
#NSS_DF=Nss1_DF.add(Nss2_DF)
# #Nss1_DF.add(Nss2_DF)




#TokenMatch2=Accupd1_DF.query('TOKEN == "9AOR2PAJKGE7BP4JJ8MM3"')
#TokenMatch= np.where(Accupd1_DF["TOKEN"] == Nss1_DF["CC_TOKEN"], 'True', 'False')  #create new column in df1 to check if  match

##print(TokenMatch)

##TokenMatch2=TokenMatch.where(TokenMatch["CC_TOKEN"] == "NaaN")

#print(TokenMatch)


#Accupd1_DF["TOKEN"]

#Accupd1_Token_DF=Accupd1.TOKEN  # extracting one column name from a data Frame

#Nss1_Token_DF=Nss1.CC_TOKEN
#notMatch=Accupd1_DF["TOKEN"] != Nss1_DF["CC_TOKEN"]

#Nss1["CC_TOKEN"]
#print(notMatch)
'''
#read a csv file and create 2 xls files 

file_token_DSET=pd.read_csv("C:/SHAILENDRA/pandasXL/TESTTOKEN_CSV.csv")
#print(file_token_DSET.head())

#creare two data frames

SE=file_token_DSET[file_token_DSET["APPLICATION_NAME"] == "subscription"]

NSS=file_token_DSET[file_token_DSET["APPLICATION_NAME"] == "standard"]

#print(SE)
print("shailendra" )
excel_file=pd.ExcelWriter("ALL_Toekns.xlsx")
SE.to_excel(excel_file,sheet_name="SETokens",index=False)
NSS.to_excel(excel_file,sheet_name="NEWSTokens",index=False,columns=["AMEX_ENROL_ID",	"TOKEN",	"CUSTOMER_NUMBER",	"EXPIRY_DATE"])
excel_file.save()
'''
