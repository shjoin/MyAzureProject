import arguments,runsqlplus_SP
import sys
import logging, socket
import datetime
import connectOracle
import OracleDbWallet

def main():
    # parse command line arguments and save them to args
        args = arguments.get_arguments(sys.argv)

        '''for arg in range(0, len(args)):
            if arg == 0:
              GV_WALLET_USER1 = args[0]
              print("Arguments for 0 ")
            elif arg == 1:
              GV_APP_ENV = args[1]
              print("Arguments for 1 ")
            elif arg == 2:
              GV_USER = args[2]
              print("Arguments for 2 ")
            elif arg == 3:
              GV_NEXT_STEP = args[3]
              print("Arguments for 3 ")
            elif arg == 4:
              GV_LAST_STEP = args[4]
              print("Arguments for 4 ")'''

        print(args.WALLET,args.SCHEMA,args.DBENV,args.first_step,args.last_step)
        GV_CURRENT_STEP="STEP000"
        GV_RESTART_STEP="STEP000"
        GV_CONNECTION_TYPE = "WALLET"
        GV_ERROR = 0
        GV_LAST_STEP=args.last_step

         # --- Environment Setup ---
        #source $GV_HOME / util / env / env $KSHname GV_APP_ENV
        # $HOME/dtm/ksh/dtmk007.ksh syndw_dtmstg dtmstg dtm   DWHDHSTG dtmstg dtm STEP010 STEP030
        dir = 'C:/SHAILENDRA/pandasXL/DBOBJECTS'

        if args.first_step != None:
           GV_RESTART_STEP = args.first_step
           GV_NEXT_STEP=args.first_step
           print('**********************************************************')
           print("**** JOB RESTARTED AT " ,GV_RESTART_STEP ," ***")
           print('**********************************************************')
        elif args.first_step == None:
             GV_NEXT_STEP ='STEP010'


        while GV_NEXT_STEP!= 'LASTSTEP':
          if GV_NEXT_STEP == 'STEP010':
             GV_CURRENT_STEP = 'STEP010'
             GV_RESTART_STEP = 'STEP010'
                #SQLname =DBOBJECTS/dtm_alter_table_v4
             STMT = "Proc_Test_Py"
             print("******************************************************"  )
             print ( GV_CURRENT_STEP ,' : ', STMT, 'date ',datetime.datetime.now().strftime(  "%Y%m%d") + '_' + datetime.datetime.now().strftime("%H%M%S")  )
             #oracle=connectOracle.Oracle(OracleDbWallet.DbUser, OracleDbWallet.DbPassword, OracleDbWallet.DbTns)
             connstring = 'dtm/$dtm123@syndwd:1591/SYNDW.INT.SYNAPSEGROUPINC.COM'
             GV_HOME = 'C:/Users/sjoshi2/Documents/PythonShjo/MyProject'
             sqlscript = GV_HOME + '/' + args.SCHEMA + '/' + 'dtms002.sql'
             print("*** ", args.DBENV, args.WALLET, args.SCHEMA)
             #runsqlplus.runSqlPlusQuery(args.DBENV, oracle, STMT)
             runsqlplus_SP.runSqlPlusQuery_SP(args.DBENV, connstring, sqlscript)
             #process_name = 'LOCAL TEST2'
             #curr=oracle.connect()
             #curr.callproc(STMT, [process_name])
                 #callproc(STMT, [process_name])
                 #connectString.callproc(sqlscript, [process_name])
             if GV_NEXT_STEP == GV_LAST_STEP:
                GV_NEXT_STEP = 'LASTSTEP'
             elif GV_NEXT_STEP != GV_LAST_STEP:
                  GV_NEXT_STEP = 'LASTSTEP' # need to add new step
                  print("****NEXT is last step****")




# ---- Global Application Environment Setup ----
#GV_HOME =HOME


# Run main() by default
if __name__ == "__main__":
    main()
    print("****DONE MAIN****")