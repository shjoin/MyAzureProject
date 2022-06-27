import cx_Oracle


class Oracle:
  def __init__(self,username, password, tns):
      self.schema=username
      self.password=password
      self.tns=tns

  def connect(self):
      try:
          self.db=cx_Oracle.connect(self.schema,self.password,self.tns)
      except cx_Oracle.DatabaseError as e:
          raise

      self.cursor=self.db.cursor
      print("Connection Stablished  ")
      return self.cursor()

  def disconnect(self):
      try:
          self.db.close()
          print("Connection Closed  ")
      except cx_Oracle.DatabaseError:
          pass

  def execute(self,sqlstm,bindvars=None,commit=False):
      try:
          self.cursor.execute(sqlstm,bindvars)
      except cx_Oracle.DatabaseError as e:
          raise

      if commit:
          self.db.commit()

  def callprocedure(self,sqlstm,bindvars=None,commit=False):
      try:
          self.cursor.callproc(sqlstm,bindvars)
      except cx_Oracle.DatabaseError as e:
          raise

      if commit:
          self.db.commit()

