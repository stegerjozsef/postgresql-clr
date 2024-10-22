import argparse
from getpass import getpass
import psycopg2

## the sql pieces that implelent CLR and dependency functions
sourcefiles = [ 
    '01-zeta.sql', '02-epsilon.sql', '03-digamma_zeta_series.sql', 
    '04-polevl.sql', '05-digamma_imp_1_2.sql', '06-psi_asy.sql', 
    '07-fmod.sql', '08-psi.sql', '09-digamma.sql', 
    '10-aitchison_mean.sql', '11-clr.sql', '12-clr.sql', 
]


## connect to database engine
def db_connect(host, port, database, user, password):
    conn = psycopg2.connect(
        database = database,
        host=host,
        port=port,
        user=user,
        password=password
    )
    C = conn.cursor()
    return conn, C

## replace schema name in the telate and then execute a create query
def execute(C, sql, schema):
    C.execute(sql.format({'%%SCHEMA%%': schema}))

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("-H", "--host", help = "postgresql database server", type = str, default = "localhost")
    parser.add_argument("-p", "--port", help = "database server port", type = int, default = 5432)
    parser.add_argument("-d", "--dbname", help = "database name", type = str, required = True)
    parser.add_argument("-s", "--schema", help = "in which schema the functions be created", type = str, default = "public")
    parser.add_argument("-u", "--user", help = "login role", type = str, required = True)
    parser.add_argument("-W", help = "force password prompt", action = 'store_true')
    parser.add_argument("-w", "--password", help = "provide password on the command line", type = str, default = None)
    args = parser.parse_args()

    if args.password is None or args.W:
        pw = getpass(f"Provide database pasword for login role {args.user}: ")
    else:
        pw = args.password

    try:
        conn, C = db_connect(args.host, args.port, args.dbname, args.user, pw)
        for fn in sourcefiles:
            with open(fn, 'r') as r:
                template = r.read()
            execute(C, template, args.schema)
        conn.commit()
        C.close()
        conn.close()
    except Exception as e:
        print (f"Failed to setup functions: {e}")

