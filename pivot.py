import pandas as pd
import os
import numpy

def pivot():
    Filesdir = 'C:/SHAILENDRA/DataLakeFiles/DataFiles/'
    os.chdir(Filesdir)
    filename = "OutputCancle5.csv"
    df=pd.read_csv(filename)
   # df=df.replace(-9999,numpy.nan)
    table = pd.pivot_table(df, index=["CANCEL_TYPE_DESC"], columns=["Cancle_Year","CUST_CONTRACT_TERM"], values=["ORDERS"])
    #,"MP_ID","TRANS_TYPE_DESC"
    table.to_csv("pivot5.csv")
    table = pd.pivot_table(df, index=["CANCEL_TYPE_DESC"], columns="CUST_CONTRACT_TERM",
                           values="ORDERS")
    table.to_csv("pivot6.csv")


def main():
    pivot()


if __name__ == '__main__':
    print('pivot Starts ......')
    main()
    print("****DONE pivot ****")