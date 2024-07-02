from configparser import ConfigParser

def config(filename = 'dict_db.ini', section='postgresql'):
    #create a parser
    parser = ConfigParser()
    #reads config
    parser.read(filename)

    #get section 
    db = {}
    if parser.has_section(section):
        print('User data for the connection string: ')
        parameters = parser.items(section)
        for param in parameters:
            db[param[0]] = param[1]
    
    else:
        raise Exception('Section {0} not found in the {1} file'.format(section, filename))
    
    return db