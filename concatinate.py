import os
import gzip
import glob
import pandas as pd

def concatinatefiles():
    Filesdir = 'C:/SHAILENDRA/DataLakeFiles/unpack'
    os.chdir(Filesdir)
    fileList = glob.glob("dwh_tr_billing_cancel*.dat")
    dfList=[]
    colnames = [  # "TR_BILLING_CANCEL_ID",
        "ORDER_ID",
        # "LINE_ITEM",
        "CUST_CONTRACT_TERM",
        "CUST_ID",
        # "EVENT_NO",
        "CANCEL_DATE", "CANCEL_TYPE_CD",
        # "SOURCE_CD" 8,	"SOURCE_SYSTEM_ID",
        # "CHARGE_NO",	"CHARGE_IND",
        "TRANS_TYPE_ID", "PMT_AMT",  # ,"CREATE_DATE"	,"CREATED_BY",
        "MP_ID",  # "ETL_BATCH_CTL_ID",	"TR_ORDER_ITEM_REQUEST_ID",
        # "TR_ORDER_REQUEST_ID",	"TR_ORDER_LINE_ID",	"TOKEN",
        # "MAPS_MERCHANT_ORDER_NO",	"MP_TRANS_ID",	"AUTH_CD",	"EXTERNAL_TRANS_ID"
        # , "ASSOCIATED_CHARGE_NO",	"MERCHANT_ORDER_NO"	, "BILLING_SCHEDULE_ID",	"TR_BILLING_SCHEDULE_ID"
    ]
    for a_filename in fileList:
        print(a_filename)
        df=pd.read_csv(a_filename,header=None,usecols= [1,3,4,6,7,12,13,16],parse_dates=False)
        dfList.append(df)

    print("concatDf")
    concatDf=pd.concat(dfList,axis=0) #axis =0 means conact verically
    concatDf.columns=colnames
    concatDf.to_csv("outfile_dwh_tr_billing_cancel.dat",index=None)

def main():
    concatinatefiles()


if __name__ == '__main__':
    print('concatinatefiles Starts ......')
    main()
    print("****DONE concatinatefiles ****")