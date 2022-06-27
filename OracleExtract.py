import gzip

import cx_Oracle
import datetime
import OracleDbWallet
import pandas as pd1

#import OracleDbConnect as dbConnectwollet

#print(dbConnect.DbUser,dbConnect.DbTns,dbConnect.DbPassword)
#DwhdbConnect=cx_Oracle.connect(OracleDbWallet.Dbuser,OracleDbWallet.DbPassword,OracleDbWallet.DbTns)
# Create the session pool
#mydbConnectPool=cx_Oracle.SessionPool('dwh','$dwh123','syndwd:1591/SYNDW.INT.SYNAPSEGROUPINC.COM',min=1,max=2,increment=1, encoding="UTF-8")
mydbConnectPool=cx_Oracle.SessionPool(OracleDbWallet.DbUser,OracleDbWallet.DbPassword,OracleDbWallet.DbTns,min=1,max=2,increment=1, encoding="UTF-8")

#print('Database version',mydbConnectPool.version)
# Acquire a connection from the pool
dbConnect=mydbConnectPool.acquire()

#print(dbConnect.version)

# Use the pooled connection
cursor = dbConnect.cursor()

chunk_file = 'dwh_tr_billing_recycle_ss_1.'+ datetime.datetime.now().strftime("%Y%m%d") + '_' + datetime.datetime.now().strftime("%H%M%S")
#dwh_tr_billing_recycle_ss_1.20210222_002240.dat.gzip
#dwh_tr_billing_recycle_ss_1.3_20210219_185429.dat.gz
print(chunk_file)

SQL="select TR_BILLING_RECYCLE_ID, NVL2( ORDER_ID,'%'||ORDER_ID||'%' ,null), LINE_ITEM, CUST_CONTRACT_TERM,CUST_ID, EVENT_NO, NVL2(ACT_MERCHANT_CD,'%'||ACT_MERCHANT_CD||'%',null ), APPROVAL_STATUS_ID,APPROVAL_STATUS_DATE, NVl2(DEPOSIT_FLAG,'%'||DEPOSIT_FLAG||'%',null), nvl2(ADVICE_CD,'%'||ADVICE_CD||'%',null), NVL2(SOURCE_CD, '%'||SOURCE_CD||'%',null) , SOURCE_SYSTEM_ID , CHARGE_NO,NVL2(CHARGE_IND,'%'||CHARGE_IND||'%',null), BILL_ATTEMPT_NO, RECYC_ATTEMPT_NO, TRANS_TYPE_ID,PMT_AMT, CREATE_DATE, NVL2(CREATED_BY,'%'||CREATED_BY||'%',null), MP_ID , 12345678 ,nvl2(MAPS_MERCHANT_ORDER_NO,'%'||MAPS_MERCHANT_ORDER_NO||'%',null) ,MP_TRANS_ID,BILLING_SCHEDULE_ID,TR_BILLING_SCHEDULE_ID,NVL2(AUTH_CD,'%'||AUTH_CD||'%',null),nvl2(EXTERNAL_TRANS_ID,'%'||EXTERNAL_TRANS_ID||'%',null),ASSOCIATED_CHARGE_NO, nvl2(MERCHANT_ORDER_NO,'%'||MERCHANT_ORDER_NO||'%',null) from TR_BILLING_RECYCLE  WHERE ROWNUM<=98"
cnt=1

for df1 in pd1.read_sql(SQL,dbConnect,chunksize=50):
 chunk_file = 'dwh_tr_billing_recycle_ss_1.' + datetime.datetime.now().strftime(  "%Y%m%d") + '_' + datetime.datetime.now().strftime("%H%M%S") + '.dat.gz'
 cnt  = cnt + 1
 file_name= "C:/SHAILENDRA/data" + '/'+ str(chunk_file)
 df1.to_csv(file_name,index=False,header=False,compression="gzip")
 index2=df1.index
 print(index2)


#for result in cursor.execute("select TR_BILLING_RECYCLE_ID, NVL2( ORDER_ID,'%'||ORDER_ID||'%' ,null), LINE_ITEM, CUST_CONTRACT_TERM, CUST_ID, EVENT_NO, NVL2(ACT_MERCHANT_CD,'%'||ACT_MERCHANT_CD||'%',null ), APPROVAL_STATUS_ID, APPROVAL_STATUS_DATE, NVl2(DEPOSIT_FLAG,'%'||DEPOSIT_FLAG||'%',null), nvl2(ADVICE_CD,'%'||ADVICE_CD||'%',null), NVL2(SOURCE_CD, '%'||SOURCE_CD||'%',null) , SOURCE_SYSTEM_ID , CHARGE_NO, NVL2(CHARGE_IND,'%'||CHARGE_IND||'%',null), BILL_ATTEMPT_NO, RECYC_ATTEMPT_NO, TRANS_TYPE_ID, PMT_AMT, CREATE_DATE, NVL2(CREATED_BY,'%'||CREATED_BY||'%',null), MP_ID , 12345678 ,nvl2(MAPS_MERCHANT_ORDER_NO,'%'||MAPS_MERCHANT_ORDER_NO||'%',null) ,MP_TRANS_ID,BILLING_SCHEDULE_ID,TR_BILLING_SCHEDULE_ID,NVL2(AUTH_CD,'%'||AUTH_CD||'%',null), nvl2(EXTERNAL_TRANS_ID,'%'||EXTERNAL_TRANS_ID||'%',null),ASSOCIATED_CHARGE_NO, nvl2(MERCHANT_ORDER_NO,'%'||MERCHANT_ORDER_NO||'%',null) from TR_BILLING_RECYCLE  WHERE ROWNUM<=100"):
#for result in cursor.execute("select TR_BILLING_RECYCLE_ID, ORDER_ID, LINE_ITEM, CUST_CONTRACT_TERM, CUST_ID, EVENT_NO, ACT_MERCHANT_CD, APPROVAL_STATUS_ID, APPROVAL_STATUS_DATE, DEPOSIT_FLAG, ADVICE_CD, SOURCE_CD, SOURCE_SYSTEM_ID , CHARGE_NO, CHARGE_IND, BILL_ATTEMPT_NO, RECYC_ATTEMPT_NO, TRANS_TYPE_ID, PMT_AMT, CREATE_DATE, CREATED_BY, MP_ID , 12345678 ,MAPS_MERCHANT_ORDER_NO,MP_TRANS_ID,BILLING_SCHEDULE_ID,TR_BILLING_SCHEDULE_ID,AUTH_CD, EXTERNAL_TRANS_ID,ASSOCIATED_CHARGE_NO, MERCHANT_ORDER_NO from TR_BILLING_RECYCLE  WHERE ROWNUM<=100 order by 1"):
# print(result)

# Release the connection to the pool
mydbConnectPool.release(dbConnect)

#cursor.close()

mydbConnectPool.close()

