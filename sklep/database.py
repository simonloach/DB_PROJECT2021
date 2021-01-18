import psycopg2


#get rid of hardcoding later
username = 'postgres'
password = 'root'
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
        if cur is not None:
            cur.close()




