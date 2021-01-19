import psycopg2
import psycopg2.extras



# funkcje zwracaja liste tupli po ktorych mozna sobie iterowac i potem wyciagac poszczegolne kolumny np:
# dupa = getBestSelling(10,10)
# for product in dupa:
#    print(product.name)

#TODO: castowanie surowych danych z bazy na klasy z models.py


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

def getTupleCursor():
    conn = getConn()
    cur = conn.cursor(cursor_factory=psycopg2.extras.NamedTupleCursor)
    return cur



# podaj cid powiem ci jakie sa wszystkie kategorie nad nim, lacznie z podanym
def getCategoryTree(cid):

    try:
        cur = getTupleCursor()
        with cur:
            cur.execute("""WITH RECURSIVE superiors AS (
            SELECT
            	cid,
        		name,
        		parent_cid
        	FROM
        		categorie
        	WHERE
        		cid = %s
        	UNION
        		SELECT
        			c.cid,
        		    c.name,
        			c.parent_cid
        		FROM
        			categorie c
        		INNER JOIN superiors s ON s.parent_cid = c.cid
            ) SELECT
            	*
            FROM 
            superiors;""", [cid])

            return cur.fetchall()

    except (psycopg2.DatabaseError) as error:
        print(error)


# zwraca najlepiej sprzedajace sie produkty w ostatnich dniach days (int) oraz ile tych 
# najpopularniejszych produktow zwrocic ( count ( int))
def getBestSelling(days,count):
    days = str(days)
    try:
        cur = getTupleCursor()
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

# zwroc produkty ktorych mamy  najmniej na magazinie, ile ich chcemy zwrocic steruje zmienna count (int)
def getByLowestInStock(count):
    try:
        cur = getTupleCursor()
        with cur:
            cur.execute("select * from product where no_instock > 0 order by no_instock asc limit %s;",[count])

            return cur.fetchall()

    except (psycopg2.DatabaseError) as error:
        print(error)


def getByHighestInStock(count):
    try:
        cur = getTupleCursor()
        with cur:
            cur.execute("select * from product where no_instock > 0 order by no_instock desc limit %s;",[count])

            return cur.fetchall()

    except (psycopg2.DatabaseError) as error:
        print(error)

