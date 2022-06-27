import openpyxl
import pandas as pd
import numpy as np

#AccUpd_Tokens.xlsx  AccupTokens col TOKEN
#NSS_Tokens700K.xlsx sheets TokensinNSS1,TokensinNSS2 , cols MAJOR_CARD_CD	CARD_TYPE_DESC	CATEGORY_DESC	CARD_TYPE_CD	CC_TOKEN
#RTB_Amex_60K.xlsx   sheet_name=["RTBToken"],usecols=["TOKEN_RTB"]

#DDict_Upder=pd.read_excel("C:/SHAILENDRA/pandasXL/NSS_TOKEN_Amex_50K.xlsx",sheet_name=["AccUpdToken"],usecols=["TOKEN"],index_col=False)   #Data Dictionary, in a disctionary we have multiple data frame with index 0,1..
DDict_Upder=pd.read_excel("C:/SHAILENDRA/pandasXL/Files/AccUpd_Tokens.xlsx",sheet_name=["AccupTokens"],usecols=["TOKEN"],index_col=False)   #Data Dictionary, in a disctionary we have multiple data frame with index 0,1..
DDict_NSS=pd.read_excel("C:/SHAILENDRA/pandasXL/Files/NSS_Tokens700K.xlsx",sheet_name=["TokensinNSS1","TokensinNSS2"],usecols=["CC_TOKEN","MAJOR_CARD_CD"],index_col=False)
#DDict_NSS=pd.read_excel("C:/SHAILENDRA/pandasXL/RTB_Amex_60K.xlsx",sheet_name=["nssToken1","nssToken2"],usecols=["CC_TOKEN"],index_col=False)

Accupd1_DF=DDict_Upder["AccupTokens"]
Nss1_DF= DDict_NSS["TokensinNSS1"]
Nss2_DF= DDict_NSS["TokensinNSS2"]
DF_union = pd.concat([Nss1_DF, Nss2_DF], ignore_index=True)
TokenMatch=Accupd1_DF.merge(DF_union,how="left",left_on="TOKEN",right_on="CC_TOKEN")
TokenMatch= TokenMatch[TokenMatch['CC_TOKEN'].isnull()]
print("Tokens availableIn AccUp Counts " , Accupd1_DF.count)
print("Tokens Active in NSS1 Counts " , Nss1_DF.count)
print("Tokens Active in NSS2 Counts " , Nss2_DF.count)

print("AvableInAccUpdButNotinNSS Counts " , TokenMatch.count)
excel_file=pd.ExcelWriter("C:/SHAILENDRA/pandasXL/Files/AvableInAccUpdButNotinNSS.xlsx")
TokenMatch.to_excel(excel_file,sheet_name="AvableInAccUpdNoinNSS",index=False)
excel_file.save()
excel_file.close()
print("FIle Saved")

