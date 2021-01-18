import psycopg2
import psycopg2.extras

#get rid of hardcoding later
username = 'g12'
password = 'gwao6hn4'
host = 'localhost'
port = 5432

def getConn():
    conn = psycopg2.connect(
        user = username,
        password = password,
        host = host,
        port = port)


    return conn

def getCategoryTree(cid):
    conn = None
    try:
        conn = getConn()
        cur = conn.cursor()
        with cur:
            cur.execute("WITH RECURSIVE superiors AS ("
            "SELECT"
            "	cid,"
        "		name,"
        "		parent_cid"
        "	FROM"
        "		categorie"
        "	WHERE"
        "		cid = %s"
        "	UNION"
        "		SELECT"
        "			c.cid,"
        "			c.name,"
        "			c.parent_cid"
        "		FROM"
        "			categorie c"
        "		INNER JOIN superiors s ON s.parent_cid = c.cid"
            ") SELECT"
            "	*"
            "FROM "
            "superiors;", [cid])

            return cur.fetchall()

    except (psycopg2.DatabaseError) as error:
        print(error)

    finally:
        if conn is not None:
            conn.close()
def getBestSelling(days,count):
    conn = None
    days = str(days)
    try:
        conn = getConn()
        cur = conn.cursor(cursor_factory=psycopg2.extras.NamedTupleCursor)
        with cur:
            cur.execute("select * from product where product.no_instock != 0 and "
                        "product.pid IN (select op.pid from ordered_product op inner join"
                        " \"order\" o  on op.oid = o.oid   "
                        "where o.order_placed_date > current_date - interval %s day  "
                        "group by op.pid order by count(op.pid) desc limit %s);"
                        ,[days,count])

            return cur.fetchall()

    except (psycopg2.DatabaseError) as error:
        print(error)

    finally:
        if conn is not None:
            conn.close()



def getByLowestInStock(count):
    conn = None
    try:
        conn = getConn()
        cur = conn.cursor()
        with cur:
            cur.execute("select * from product where no_instock > 0 order by no_instock asc limit %s;",[count])

            return cur.fetchall()

    except (psycopg2.DatabaseError) as error:
        print(error)

    finally:
        if cur is not None:
            cur.close()




dupa = getBestSelling(100,100)
print(dupa)
for product in dupa:
    print(product.name)

