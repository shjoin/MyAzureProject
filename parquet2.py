import pandas as pd
import pyarrow.parquet as pq

def write_parquet_file():
   # file ='C:/Users/shail/Documents/python/dwh_tr_billing_cancel_ss1.1_20210420_023405.dat.gz'
    dfCancelType=pd.read_csv('C:/Users/shail/Documents/python/dwh_tr_billing_cancel.csv')
    dfCancelType.to_parquet('C:/Users/shail/Documents/python/dwh_tr_billing_cancel_main20.parquet')


def main():
 write_parquet_file()


if __name__ == '__main__':
    print('generate parquet Starts ......')
    main()
    print("****DONE generate parquet ****")