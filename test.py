def main():
    print('Starts ......')
    PYname = 'dtmk079'
    function = 'prc_ins_ft_pot_remit_summary'
    IBS_SUCCESS_GROUP = 'shailendra.joshi@meredith.com'
    #STMT = "pkg_pot_remit_dm.prc_ins_ft_pot_remit_summary(500," + "'" + PYname + "'" + ",'prc_ins_ft_pot_remit_summary')"
    STMT = "pkg_pot_remit_dm.prc_ins_ft_pot_remit_summary(500," + "'" + PYname + "'" + ",'" + function + "'"+ ")"
    #STMT = "pkg_pot_remit_dm.prc_ins_ft_pot_remit_summary(500," + "'" + PYname + "'," +  "'" + function)"
    print("STMT" + STMT)
    HOME = '/home1/syndw'
    SCHEMA = 'dtm'
    sqlscript = HOME + '/' + SCHEMA + '/' + 'sql' + '/' + 'dtms001.sql'
    connstring = 'dtm/$dtm123@syndwd:1591/SYNDW.INT.SYNAPSEGROUPINC.COM'
    #sqlstringSP = '/oracle/app/oracle/product/12.1.0/client_1/bin/sqlplus -l -s ' + connstring + '  @' + sqlscript + ' ' + SCHEMA + ' ' + STMT
    sqlstringSP = '/oracle/app/oracle/product/12.1.0/client_1/bin/sqlplus -l -s ' + '/@SYNDWD_DTM' + '  @' + sqlscript + ' ' + SCHEMA + ' '+ '"' + STMT +'"'
    print(sqlstringSP)
#$ORACLE_HOME/bin/sqlplus -l -s /@SYNDWD_DTM  @/home1/syndw/dtm/sql/dtms001.sql dtm "pkg_pot_remit_dm.prc_ins_ft_pot_remit_summary(500,'dtmk079','"prc_ins_ft_pot_remit_summary"')"
if __name__ == "__main__":
    print('main Starts ......')
    main()
    print("****DONE MAIN****")