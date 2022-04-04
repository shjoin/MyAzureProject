from pypika import Query, Table, Field


#q = Query.from_('customers').select('id', 'fname', 'lname', 'phone')
#str(q)
#q.get_sql()
stmt = Query \
    .create_table("person") \
    .columns(
        Column("id", "INT", nullable=False),
        Column("first_name", "VARCHAR(100)", nullable=False),
        Column("last_name", "VARCHAR(100)", nullable=False),
        Column("phone_number", "VARCHAR(20)", nullable=True),
        Column("status", "VARCHAR(20)", nullable=False, default=ValueWrapper("NEW")),
        Column("date_of_birth", "DATETIME")) \
    .unique("last_name", "first_name") \
    .primary_key("id")

customers = Table('customers')

q = Query.into(customers).insert(1, 'Jane', 'Doe', 'jane@example.com')

#INSERT INTO customers VALUES (1,'Jane','Doe','jane@example.com')

customers =  Table('customers')

q = customers.insert(1, 'Jane', 'Doe', 'jane@example.com')

#INSERT INTO customers VALUES (1,'Jane','Doe','jane@example.com')

q = Query.from_('customers').select('id', 'fname', 'lname', 'phone')
str(q)
q.get_sql()
