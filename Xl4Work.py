import openpyxl
import pandas as pd
import numpy as np

#AccUpd_Tokens.xlsx  AccupTokens col TOKEN
#NSS_Tokens700K.xlsx sheets TokensinNSS1,TokensinNSS2 , cols MAJOR_CARD_CD	CARD_TYPE_DESC	CATEGORY_DESC	CARD_TYPE_CD	CC_TOKEN
#RTB_Amex_60K.xlsx   sheet_name=["RTBToken"],usecols=["TOKEN_RTB"]

#DDict_Upder=pd.read_excel("C:/SHAILENDRA/pandasXL/NSS_TOKEN_Amex_50K.xlsx",sheet_name=["AccUpdToken"],usecols=["TOKEN"],index_col=False)   #Data Dictionary, in a disctionary we have multiple data frame with index 0,1..
DDict_AvableInAccUpdNoinNSS = pd.read_excel("C:/SHAILENDRA/pandasXL/Files/AvableInAccUpdButNotinNSS.xlsx",sheet_name=["AvableInAccUpdNoinNSS"],usecols=["TOKEN"],index_col=False)   #Data Dictionary, in a disctionary we have multiple data frame with index 0,1..
DDict_RTB=pd.read_excel("C:/SHAILENDRA/pandasXL/Files/RTB_Amex_60K.xlsx",sheet_name=["RTBToken"],usecols=["TOKEN_RTB"],index_col=False)
#DDict_NSS=pd.read_excel("C:/SHAILENDRA/pandasXL/RTB_Amex_60K.xlsx",sheet_name=["nssToken1","nssToken2"],usecols=["CC_TOKEN"],index_col=False)

AvableInAccUpdNoinNSS_DF=DDict_AvableInAccUpdNoinNSS["AvableInAccUpdNoinNSS"]
RTB_DF= DDict_RTB["RTBToken"]
TokenMatch=AvableInAccUpdNoinNSS_DF.merge(RTB_DF,how="left",left_on="TOKEN",right_on="TOKEN_RTB")
TokenMatch= TokenMatch[TokenMatch['TOKEN_RTB'].notnull()]

print("Available In AccUpd but Not in NSS Counts " , AvableInAccUpdNoinNSS_DF.count)
print("Active in RTB Counts " , RTB_DF.count)
print("Active in RTB & and Accupd But Not available in NSS Counts " , TokenMatch.count)

excel_file=pd.ExcelWriter("C:/SHAILENDRA/pandasXL/Files/ActiveInRTBButNotinNSS.xlsx")
TokenMatch.to_excel(excel_file,sheet_name="ActiveInRTBButNotinNSS",index=False)
excel_file.save()
excel_file.close()
print("FIle Saved")

