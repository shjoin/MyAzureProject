import logging

logging.basicConfig(level=logging.INFO,
                            format='%(asctime)s %(name)-12s %(levelname)-8s %(message)s',
                            datefmt='%m-%d %H:%M',
                            filename='log_file.tst',
                            filemode='w')

GV_CURRENT_STEP='STEP001'
VAT ='1000092'
logging.info('****** %s' % GV_CURRENT_STEP + '******' % VAT  )