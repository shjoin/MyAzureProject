
import cx_Oracle

https://oracle.github.io/python-cx_Oracle/samples/tutorial/Python-and-Oracle-Database-Scripting-for-the-Future.html

    Connection
    pooling is important
    for performance when applications frequently connect and disconnect from the database.Pooling also gives the best support for Oracle high availability features.Documentation link for further reading:


    Connection
    Pooling
    Connection
    pooling is important
    for performance when applications frequently connect and disconnect from the database.Pooling also gives the best support for Oracle high availability features.Documentation link for further reading: Connection
    Pooling.


def perform_query(query, bind_variables):
    connection = db_pool.acquire()
    cursor = connection.cursor()
    cursor.execute(query, bind_variables)
    result = cursor.fetchall()
    cursor.close()
    db_pool.release(connection)
    return result

db_pool = cx_Oracle.SessionPool('oracle user', 'oracle pass', 'oracle db', 2, 10, 3)

for i in range(100):
    result = perform_query('SELECT ...', {'var': 'abc'})
    print(result)


 cx_Oracle.connect(userName, password, "dbhost.example.com/orclpdb1",
            encoding="UTF-8") as connection:
    cursor = connection.cursor()
    cursor.execute("insert into SomeTable values (:1, :2)",
            (1, "Some string"))
    connection.commit()



dsn = cx_Oracle.makedsn("dbhost.example.com", 1521, service_name="orclpdb1")
connection = cx_Oracle.connect("hr", userpwd, dsn, encoding="UTF-8")

https://cx-oracle.readthedocs.io/en/latest/user_guide/connection_handling.html