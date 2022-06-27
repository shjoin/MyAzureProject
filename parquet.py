import pandas as pd
import pyarrow.parquet as pq

def write_parquet_file():
    file ='C:/Users/shail/Documents/python/dwh_tr_billing_cancel_ss1.1_20210420_023405.dat.gz'
    dfCancelType = pd.read_csv(file, compression='gzip', header=None)
    dfCancelType.rename(columns={0: 'TR_BILLING_CANCEL_ID', 1: 'ORDER_ID', 2: 'LINE_ITEM', 3: 'CUST_CONTRACT_TERM'
                                , 4: 'EVENT_NO'
                                , 5: 'CANCEL_DATE'
                               ,  6: 'CANCEL_TYPE_CD'
                               ,  7: 'SOURCE_SYSTEM_ID'
                               ,  8: 'CHARGE_NO'
                                , 9: 'CHARGE_IND'
        , 10: 'TRANS_TYPE_ID'
        , 11: 'PMT_AMT'
        , 12: 'CREATE_DATE'
        , 13: 'CHARGE_IND'
        , 14: 'TRANS_TYPE_ID'
        , 15: 'PMT_AMT'
       # ,16: 'CREATE_DATE'
        # ,17: 'CREATED_BY',
       # 18: 'MP_ID',
        #19: 'ETL_BATCH_CTL_ID',
       # 20: 'TR_ORDER_ITEM_REQUEST_ID',
      #  21: 'TR_ORDER_REQUEST_ID',
       #                          22: 'TR_ORDER_LINE_ID',	23: 'TOKEN',
      # 24: 'MAPS_MERCHANT_ORDER_NO',	25: 'MP_TRANS_ID'
        #,	26: 'AUTH_CD',	27: 'EXTERNAL_TRANS_ID'
         #, 28: 'ASSOCIATED_CHARGE_NO',	29: 'MERCHANT_ORDER_NO'	, 30: 'BILLING_SCHEDULE_ID',
                                 #31: 'TR_BILLING_SCHEDULE_ID'
                                 }, inplace=True)
    dfCancelType.to_csv('C:/Users/shail/Documents/python/dwh_tr_billing_cancel2.csv', index=False)
    df = pd.read_csv('C:/Users/shail/Documents/python/dwh_tr_billing_cancel2.csv')
    df.to_parquet('C:/Users/shail/Documents/python/dwh_tr_billing_cancel_main6.parquet')


def main():
 write_parquet_file()


if __name__ == '__main__':
    print('generate parquet Starts ......')
    main()
    print("****DONE generate parquet ****")