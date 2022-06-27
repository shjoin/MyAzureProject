import pyarrow.csv as pv
import pyarrow.parquet as pq

def write_parquet_file():
   # file ='C:/Users/shail/Documents/python/dwh_tr_billing_cancel_ss1.1_20210420_023405.dat.gz'
    table = pv.read_csv('C:/Users/shail/Documents/python/dwh_tr_billing_cancel2.csv')
    pq.write_table(table,'C:/Users/shail/Documents/python/dwh_tr_billing_cancel_main4.parquet')


def main():
 write_parquet_file()


if __name__ == '__main__':
    print('generate parquet Starts ......')
    main()
    print("****DONE generate parquet ****")