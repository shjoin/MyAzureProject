from pyspark.sql import SparkSession

def write_parquet_file():
    print('SparkSession.builder ......')
    spark = SparkSession.builder \
        .master("local") \
        .appName("parquet_example") \
        .getOrCreate()
    print('spark.read.csv ......')
    df = spark.read.csv('C:/Users/shail/Documents/python/dwh_tr_billing_cancel2.csv', header=True)
    df.repartition(1).write.mode('overwrite').parquet('C:/Users/shail/Documents/python/dwh_tr_billing_cancel_main5.parquet')


def main():
 print('write_parquet_file ......')
 write_parquet_file()
 print('write_parquet_file1 ......')


if __name__ == '__main__':
    print('generate parquet Starts ......')
    main()
    print("****DONE generate parquet ****")