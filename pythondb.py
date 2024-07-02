import psycopg2
import psycopg2.extras
from dict_conf import config



def db_connection():
    params = config()
    return psycopg2.connect(**params)

def read_dict():
    dbconn = db_connection()
    cursor = dbconn.cursor()
    cursor.execute("SELECT id, word, translation FROM dictionary;")
    rows = cursor.fetchall()
    cursor.close()
    dbconn.close()
    print(rows)


while True: ## REPL - Read Execute Program Loop
    cmd = input("Command: ")

    if cmd == "list":
        read_dict()
    elif cmd == "quit":
        exit()
    else:
        print("error")