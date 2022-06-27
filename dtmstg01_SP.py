import sys,os
import logging, socket
import datetime
from dtm.env import runsqlplus_SP
from dtm.env import util
from dtm.env import arguments

def main():
        # parse command line arguments and save them to args
        print('Starts ......')
        args = arguments.get_arguments(sys.argv)
        print(args.WALLET,args.SCHEMA,args.DBENV,args.first_step,args.last_step)       #   SYNDWD_DTMTM DTM dtm
        GV_CURRENT_STEP="STEP000"
        GV_RESTART_STEP="STEP000"
        GV_CONNECTION_TYPE = "WALLET"
        GV_ERROR = 0
        GV_LAST_STEP=args.last_step
        GV_SCHEMA = args.SCHEMA
        GV_ENV=args.DBENV
        PYname='dtmstg01_SP'
        IBS_SUCCESS_GROUP='shailendra.joshi@meredith.com'
        # Email Initialization
        # the below variables control the email functionality for the err_chk function
        GV_SEND_MAIL = "Y"  # Y/N | If a batch process; always N
        GV_EMAIL_GROUP =IBS_SUCCESS_GROUP  # where should the emails go to
        GV_EMAIL_SUBJECT = PYname  # description/KSHname
        GV_SEND_LOG_FILE = "Y"  # Y
        GV_EXIT_FLAG = "Y"  # Y/N
         # --- Environment Setup ---
        #source $GV_HOME / util / env / env $KSHname GV_APP_ENV
        # $HOME/dtm/ksh/dtmk007.ksh syndw_dtmstg dtmstg dtm   DWHDHSTG dtmstg dtm STEP010 STEP030
        dir = 'C:/SHAILENDRA/pandasXL/DBOBJECTS'

        log_file = 'dtmk079._' + datetime.datetime.now().strftime("%m%d%y") + '-' + datetime.datetime.now().strftime(
            "%H%M%S") + '.log'
        logging.basicConfig(level=logging.INFO,
                            #format='%(asctime)s %(name)-12s %(levelname)-8s %(message)s',
                            format='%(message)s',
                            datefmt='%m-%d %H:%M',
                            filename=log_file,
                            filemode='w')
        #logging.info("********************************")
        GV_HOME = 'C:/Users/sjoshi2/Documents/PythonShjo/MyProject'
        PYpath = GV_HOME + '/' + GV_SCHEMA + '/' + '/' + 'py'
        hostname = socket.gethostname()
        #logging.info(hostname)
        #logging.info(PYpath + '/%s' %  PYname)

        if args.first_step != None:
           GV_RESTART_STEP = args.first_step
           GV_NEXT_STEP=args.first_step
        elif args.first_step == None:
             GV_NEXT_STEP ='STEP010'

        while GV_NEXT_STEP!= 'LASTSTEP':
          if GV_NEXT_STEP == 'STEP010':
             GV_CURRENT_STEP = 'STEP010'
             GV_RESTART_STEP = 'STEP010'
             STMT = "pkg_pot_remit_dm.prc_ins_ft_pot_remit_summary(500," + "'" + PYname + "'" + ",'prc_ins_ft_pot_remit_summary')"
             sqlpluspath = 'C:/Oracle/app/client/product/12.1.0/client_64bit/BIN/sqlplus.exe'
             connstring = 'dtm/$dtm123@syndwd:1591/SYNDW.INT.SYNAPSEGROUPINC.COM'

             sqlscript = GV_HOME + '/' + args.SCHEMA + '/' +'sql' + '/'+ 'dtms001.sql'
             Error,Errcode = util.chk_file_exists(sqlscript, IBS_SUCCESS_GROUP, PYname,
                                          GV_CURRENT_STEP)  # need to check the file exists ort not and all fies should be not null
             if Error == 1:
                 print('Error out')
                 logging.info(Errcode)
                 sys.exit()

             logging.info('******************************************************************************')
             logging.info('%s' % GV_CURRENT_STEP + ' : %s' % sqlscript + ' date %s ' % datetime.datetime.now().strftime(  "%Y-%m-%d") + '-%s' % datetime.datetime.now().strftime("%H:%M:%S"))
             print(GV_CURRENT_STEP, ' : ', sqlscript, 'date: ',datetime.datetime.now().strftime("%Y-%m-%d") + '_' + datetime.datetime.now().strftime("%H:%M:%S"))
             print("**********************************************************************************************")

             logging.info('%s' % STMT)
             logging.info('******************************************************************************')
             logging.info('%s' % sqlpluspath + ' -l' ' -s ' + '  @%s' % sqlscript + ' %s ' % GV_SCHEMA )
             print(STMT)
             print("**********************************************************************************************")

             #sqlstringSP = sqlpluspath + ' -l' ' -s ' + GV_WALLET_USER + '  @' + sqlscript + GV_SCHEMA + STMT # for wallet
             sqlstringSP = sqlpluspath + ' -l' ' -s ' + connstring + '  @' + sqlscript + ' ' + GV_SCHEMA + ' ' + STMT

             #logging.info(sqlstringSP)
             #logging.info(sqlpluspath'%s' % STMT + ' date %s ' % datetime.datetime.now().strftime("%Y%m%d") + '_%s' % datetime.datetime.now().strftime("%H%M%S") + ' **')
             #oracle=connectOracle.Oracle(OracleDbWallet.DbUser, OracleDbWallet.DbPassword, OracleDbWallet.DbTns)
             #logging.info(' Wallet# %s' % connstring)
             #logging.info('Script %s' % sqlscript)

             #o,e=runsqlplus_SP.runSqlPlusQuery_SP(args.DBENV, connstring, sqlscript)
             o, e = runsqlplus_SP.runSqlPlusQuery_SP(args.DBENV, sqlstringSP,'nothing')
             stdout_lines_out = o.decode('utf-8').splitlines()
             for line in stdout_lines_out:
                 logging.info('%s'% line)

             stdout_lines_err = e.decode('utf-8').splitlines()
             for line in stdout_lines_err:
                 logging.info('%s'%line)

             if GV_NEXT_STEP == GV_LAST_STEP:
                GV_NEXT_STEP = 'LASTSTEP'
             elif GV_NEXT_STEP != GV_LAST_STEP:
                  GV_NEXT_STEP = 'LASTSTEP' # need to add new step
                  print("****NEXT is last step****")

# ---- Global Application Environment Setup ----
#GV_HOME =HOME


# Run main() by default
if __name__ == "__main__":
    print('main Starts ......')
    main()
    print("****DONE MAIN****")