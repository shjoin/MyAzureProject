import subprocess
import datetime

def main():
        print('Starts ......')
        PYname='dtmk079'
        IBS_SUCCESS_GROUP='shailendra.joshi@meredith.com'
        STMT = "pkg_pot_remit_dm.prc_ins_ft_pot_remit_summary(500," + "'" + PYname + "'" + ",'prc_ins_ft_pot_remit_summary')"
        STMT = "pkg_pot_remit_dm.prc_ins_ft_pot_remit_summary(500," + "'" + PYname + "'" + ",prc_ins_ft_pot_remit_summary)"
             #select * from dtm.ft_pot_remit_daily_summary where trunc(create_date)=trunc(sysdate);alter table ft_pot_remit_daily_summary modify create_by varchar2(9);
        connstring = 'dtm/$dtm123@syndwd:1591/SYNDW.INT.SYNAPSEGROUPINC.COM'
        HOME = '/home1/syndw'
        SCHEMA='dtm'
        #sqlpluspath = 'C:/Oracle/app/client/product/12.1.0/client_64bit/BIN/sqlplus.exe'
        sqlscript = HOME + '/' + SCHEMA + '/' +'sql' + '/'+ 'dtms001.sql'
        print(sqlscript, 'date: ',datetime.datetime.now().strftime("%Y-%m-%d") + '_' + datetime.datetime.now().strftime("%H:%M:%S"))
        print("**********************************************************************************************")
        print(STMT)
        print("**********************************************************************************************")
        #sqlstringSP = sqlpluspath + ' -l' ' -s ' + GV_WALLET_USER + '  @' + sqlscript + GV_SCHEMA + STMT # for wallet
        #sqlstringSP = $ORACLE_HOME  + '/bin/sqlplus' + ' -l' ' -s ' + connstring + '  @' + sqlscript + ' ' + SCHEMA + ' ' + STMT
        #sqlstringSP='/oracle/app/oracle/product/12.1.0/client_1/bin/sqlplus -l -s ' + connstring + '  @' + sqlscript + ' ' + SCHEMA + ' ' + STMT
        #$ORACLE_HOME/bin/sqlplus -l -s /@$GV_WALLET_USER @$SQLname $GV_SCHEMA $STMT     >> $LOGname 2>&1
        sqlstringSP = '/oracle/app/oracle/product/12.1.0/client_1/bin/sqlplus -l -s ' + '/@SYNDWD_DTM' + '  @' + sqlscript + ' ' + SCHEMA + ' ' + STMT


        sp = subprocess.Popen(sqlstringSP, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        print('Running Now .. ', sqlstringSP)
        rc = sp.wait()
        print("Sctipt Executed ")
        o, e = sp.communicate()
        print("RUN END  ")


if __name__ == "__main__":
    print('main Starts ......')
    main()
    print("****DONE MAIN****")