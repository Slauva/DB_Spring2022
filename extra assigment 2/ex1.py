import psycopg2
from contextlib import closing
from faker import Faker


def create_table(db, name):
    with db.cursor() as cursor:
        cursor.execute(f'''CREATE TABLE IF NOT EXISTS {name.upper()} (
                ID INT PRIMARY KEY     NOT NULL,
                Name           TEXT    NOT NULL,
                Address        TEXT    NOT NULL,
                review         TEXT
               );''')


def insert_faked_data(db, name, rows):
    fake = Faker()
    with db.cursor() as cursor:
        try:
            for i in range(rows):
                cursor.execute(f"INSERT INTO {name.upper()} (ID,Name,Address,review) VALUES ('" + str(
                    i) + "','" + fake.name() + "','" + fake.address() + "','" + fake.text() + "')")
                db.commit()
            print("Data inserted successfully")
        except Exception as e:
            return


def create_indexes(db):
    with db.cursor() as cursor:
        cursor.execute(
            "CREATE INDEX IF NOT EXISTS customer_id ON customer USING BTREE (Name, ID) WHERE Name like 'Amanda';")
        cursor.execute(
            "CREATE INDEX IF NOT EXISTS customer_idx ON customer USING BRIN (ID) WHERE ID > 500 AND ID < 50000;")
        cursor.execute(
            "CREATE INDEX IF NOT EXISTS customer_name ON customer USING HASH (Name);")
        cursor.execute(
            "CREATE INDEX IF NOT EXISTS customer_review ON customer USING GIN (to_tsvector('english'::regconfig, Review));"
        )
        cursor.execute(
            "CREATE INDEX IF NOT EXISTS customer_address ON customer USING GIST (to_tsvector('english'::regconfig, Address)) WHERE Address like 'PSC';"
        )


def drop_indexes(db):
    with db.cursor() as cursor:
        cursor.execute("DROP INDEX IF EXISTS customer_id;")
        cursor.execute("DROP INDEX IF EXISTS customer_idx;")
        cursor.execute("DROP INDEX IF EXISTS customer_name;")
        cursor.execute("DROP INDEX IF EXISTS customer_review;")
        cursor.execute("DROP INDEX IF EXISTS customer_address;")


def fetch(db, query):
    with db.cursor() as cursor:
        cursor.execute(query)
        rows = cursor.fetchall()
        print("=" * 65)
        print(query)
        for row in rows:
            print(row)
        print("=" * 65)


def parse(rows):
    _cost = rows[0][0].split("cost=")[1].split()[0].split("..")[1]
    _time = rows[-1][0].split()[-2]
    return _cost, _time


def fetch_analyze(db, query):
    with db.cursor() as cursor:
        cursor.execute(query)
        rows = cursor.fetchall()
        print("=" * 65)
        print(query)
        cost, exe_time = parse(rows)
        print(f"Cost: {cost}")
        print(f"Execution time: {exe_time} ms")
        print("=" * 65)


with closing(psycopg2.connect(dbname='assigment', user='postgres', password='12345', host='127.0.0.1')) as conn:
    create_table(conn, "CUSTOMER")
    print("Table has created")

    insert_faked_data(conn, "CUSTOMER", 1000000)
    print("Data has inserted")

    drop_indexes(conn)
    print("Indexes has dropped")

    print("Costs without indexes")
    fetch_analyze(conn, "EXPLAIN ANALYZE SELECT ID, Name FROM customer WHERE ID > 1000 AND ID < 10000")
    fetch_analyze(conn, "EXPLAIN ANALYZE SELECT Review FROM customer WHERE ID > 1000 AND ID < 10000 AND Name like 'Amanda'")
    fetch_analyze(conn, "EXPLAIN ANALYZE SELECT Name, Review FROM customer WHERE ID > 500 AND ID < 50000 AND Address like 'PSC'")
    fetch_analyze(conn, "EXPLAIN ANALYZE SELECT * FROM customer WHERE ID%2=1 AND Address like 'PSC'")

    print("Costs with indexes")
    create_indexes(conn)
    fetch_analyze(conn, "EXPLAIN ANALYZE SELECT ID, Name FROM customer WHERE ID > 1000 AND ID < 10000")
    fetch_analyze(conn, "EXPLAIN ANALYZE SELECT Review FROM customer WHERE ID > 1000 AND ID < 10000 AND Name like 'Amanda'")
    fetch_analyze(conn, "EXPLAIN ANALYZE SELECT Name, Review FROM customer WHERE ID > 500 AND ID < 50000 AND Address like 'PSC'")
    fetch_analyze(conn, "EXPLAIN ANALYZE SELECT * FROM customer WHERE ID%2=1 AND Address like 'PSC'")
