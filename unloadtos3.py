import psycopg2
import time
import sys
import datetime
from datetime import date
datetime_object = datetime.datetime.now()

print ("Starts ...")
#Obtaining the connection to RedShift
con=psycopg2.connect(dbname= 'dev', host='shjo-redshift-cluster-1.cgllce8gfpoz.us-east-2.redshift.amazonaws.com',
port= '5439', user= 'awsuser', password= 'Welcome12#')

unload_command="unload ('select * from dev.ocivm19cdmsjoshi.vw_tb_dwh_data ') to 's3://shjos3/datalake-parquet-from-redshift/tb_dwh_data_"+str(datetime.datetime.now())+"' FORMAT PARQUET iam_role 'arn:aws:iam::816279759224:role/shjo-redshift-role';"

#Opening a cursor and run unload query
cur = con.cursor()
cur.execute(unload_command)
#cur.execute('select * from dev.ocivm19cdmsjoshi.vw_tb_dwh_data')
#print( cur.fetchone())
#all = cur.fetchall()


#Close the cursor and the connection
cur.close()
con.close()
print ("End")
