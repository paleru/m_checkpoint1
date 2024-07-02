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

def insert_query(word, translation):

    dbconn = db_connection()
    cursor = dbconn.cursor()
    insert_script = "INSERT INTO dictionary (word, translation) VALUES (%s, %s)"
    cursor.execute(insert_script, (word, translation))
    dbconn.commit()
    cursor.close()
    dbconn.close()

def add_word():
    word = input("Enter english word: ")
    translation = input("Enter your translation: ")
    insert_query(word, translation)
    print(f'Added {word} with translation: {translation} to dictionary')

def delete_query(word): 
    dbconn = db_connection()
    cursor = dbconn.cursor()
    delete_script = 'DELETE FROM dictionary WHERE word = %s'
    #added ',' at end of word due to needing to pass tuple even if only one argument
    cursor.execute(delete_script, (word,))
    dbconn.commit()
    cursor.close()
    dbconn.close()

def delete_word():
    word = input("Enter english word you wish to remove: ")
    delete_query(word)
    print(f'Removed {word} from dictionary')



while True: ## REPL - Read Execute Program Loop
    cmd = input("Command: ")

    if cmd == "list":
        read_dict()
    elif cmd == "add_word":
        add_word()
    elif cmd == "delete":
        delete_word()
    elif cmd == "quit":
        exit()
    else:
        print("error")