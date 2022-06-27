# This is a  main Python script for processing the dataLake files
import sys,os
import logging, socket
import datetime
import patoolib
import gzip
import glob
import pandas as pd
import pandasql as ps
import pysqldf as pys
#from pandasql import sqldf

# Press Shift+F10 to execute it or replace it with your code.
# Press Double Shift to search everywhere for classes, files, tool windows, actions, and settings.


def billingCancel():
    # Use a breakpoint in the code line below to debug your script.
    #Filesdir = 'C:/SHAILENDRA/DataLakeFiles/'
    Filesdir =  os.getcwd()     #'/home1/syndw
    env = 'dwh'
   # unzipFilesdir = 'C:/SHAILENDRA/DataLakeFiles/UnZip/'
    FilePattern1 = 'dwh_tr_billing_cancel'
    fileCancelType = 'ref_cf_cancel_type.dat.gz'
    fileTransType = 'dwh_cf_trans_type.dat.gz13042021_032335082'

   # patoolib.extract_archive(Filesdir + "dwh_tr_billing_cancel_ss1.1_20210413_023412.dat.gz",outdir=unzipFilesdir)
    print(os.chdir(os.getcwd() + '/'+ env + '/' + 'data/'))

    #print("Read Access ",os.access(fileCancelType,os.R_OK))

    dfCancelType = pd.read_csv(fileCancelType, compression='gzip', header=None,usecols= [0,1])
    dfCanTypeList = []
    #print("pd.read_csv")
    dfCanTypeList.append(dfCancelType)
    #print("dfList.append(df)")
    concatDFCanType = pd.concat(dfCanTypeList, axis=0)
    colnamesCancelType = ["CANCEL_TYPE_CODE",	"CANCEL_TYPE_DESC"]
    concatDFCanType.columns = colnamesCancelType


    dfTransType = pd.read_csv(fileTransType, compression='gzip', header=None, usecols=[0, 1])
    dfTransTypeList = []
    # print("pd.read_csv")
    dfTransTypeList.append(dfTransType)
    # print("dfList.append(df)")
    concatDFTransType = pd.concat(dfTransTypeList, axis=0)
    colnamesTransType = ["TRANS_TYPE_ID", "TRANS_TYPE_DESC"]
    concatDFTransType.columns = colnamesTransType


    #SqlCanType = ps.sqldf(
     #   "select CANCEL_TYPE_CODE,CANCEL_TYPE_DESC from concatDFCanType")
    #print("SqlCanType table ", SqlCanType.head(4))
    #print(concatDFCanType.CANCEL_TYPE_DESC)
    #if not os.path.exists("unzipFilesdir"):
    #    os.makedir("UnZip")
    #files=os.listdir("UnZip")
    fileList = glob.glob("*" + FilePattern1 + "*.gz")
    dfList = []
    #print(fileList)
    colnames=[#"TR_BILLING_CANCEL_ID",
              "ORDER_ID",
        #"LINE_ITEM",
              "CUST_CONTRACT_TERM",
              "CUST_ID",
              # "EVENT_NO",
              "CANCEL_DATE",	"CANCEL_TYPE_CD",
              #"SOURCE_CD" 8,	"SOURCE_SYSTEM_ID",
              #"CHARGE_NO",	"CHARGE_IND",
              "TRANS_TYPE_ID", "PMT_AMT",	#,"CREATE_DATE"	,"CREATED_BY",
              "MP_ID", # "ETL_BATCH_CTL_ID",	"TR_ORDER_ITEM_REQUEST_ID",
              #"TR_ORDER_REQUEST_ID",	"TR_ORDER_LINE_ID",	"TOKEN",
              #"MAPS_MERCHANT_ORDER_NO",	"MP_TRANS_ID",	"AUTH_CD",	"EXTERNAL_TRANS_ID"
             # , "ASSOCIATED_CHARGE_NO",	"MERCHANT_ORDER_NO"	, "BILLING_SCHEDULE_ID",	"TR_BILLING_SCHEDULE_ID"
    ]
    for a_filename in fileList:
        df=pd.read_csv(a_filename, compression='gzip',header=None,usecols= [1,3,4,6,7,12,13,16],parse_dates=False)
        dfList.append(df)
        #print("dfList.append(df)")
        concatDF = pd.concat(dfList,axis=0)
        #print("FileName", a_filename)
        concatDF.columns = colnames
        concatDF['Cancle_Year'] =pd.DatetimeIndex(concatDF["CANCEL_DATE"]).year
        concatDF['Cancle_Month'] = pd.DatetimeIndex(concatDF["CANCEL_DATE"]).month

        #concatDF['Cancle_Year'] =  concatDF["CANCEL_DATE"].dt.year
        #concatDF['Cancle_Month'] = concatDF["CANCEL_DATE"].dt.month
        concatDF=concatDF.drop(columns=["CANCEL_DATE"])
        concatDF=pd.DataFrame.drop_duplicates(concatDF)

        #print(concatDF.head(10))
        # Execute your SQL command against the pandas frame
        dfBillCancel = concatDF.merge(concatDFCanType, how="left", left_on="CANCEL_TYPE_CD", right_on="CANCEL_TYPE_CODE")
        dfBillCancelmain= dfBillCancel.merge(concatDFTransType, how="left", left_on="TRANS_TYPE_ID", right_on="TRANS_TYPE_ID")

        #Sql= ps.sqldf("select count(*),B.CANCEL_TYPE_DESC,strftime('%Y', CANCEL_DATE) AS Year,strftime('%m', CANCEL_DATE) AS month "
        #              "from concatDF AS A INNER JOIN concatDFCanType AS B ON A.CANCEL_TYPE_CD=B.CANCEL_TYPE_CODE "
        #              "group by B.CANCEL_TYPE_DESC,strftime('%Y', CANCEL_DATE),strftime('%m', CANCEL_DATE)")
        #print(Sql.head(10))
        #print(ColValMatch.groupby("CANCEL_TYPE_DESC"))
        #print(pd.DatetimeIndex(ColValMatch['CANCEL_DATE']).year)
        #print(pd.to_datetime(ColValMatch['CANCEL_DATE']).dt.to_period('M'))
        dfBillCancelmain = dfBillCancelmain.drop(columns=["TRANS_TYPE_ID","CANCEL_TYPE_CD","CANCEL_TYPE_CODE"])
        dfBillCancelmain = dfBillCancelmain.replace('%', '', regex=True)
        dfBillCancelmain.to_csv(os.getcwd() + '/'+ env + '/' + 'data' + '/' + 'OutputBefore.csv')
        dfGrpByBillCancel= dfBillCancelmain.groupby(["CANCEL_TYPE_DESC","Cancle_Year","Cancle_Month","CUST_CONTRACT_TERM","MP_ID","TRANS_TYPE_DESC"])

        dfResult=dfGrpByBillCancel["PMT_AMT"].sum()
        dfResult = dfGrpByBillCancel.agg({"PMT_AMT" : "sum",
                                          "ORDER_ID": "count"
                                          })
                                  #,pd.DatetimeIndex(ColValMatch['CANCEL_DATE']).year,pd.DatetimeIndex(ColValMatch['CANCEL_DATE']).month))
        dfResult.to_csv(os.getcwd() + '/'+ env + '/' + 'data' + '/' + 'Output.csv')

       # gzip.open(a_file, "rb")
       # contents = a_file.read()

def main():
   billingCancel()

if __name__ == '__main__':
   print('main Starts ......')
   main()
   print("****DONE MAIN****")


