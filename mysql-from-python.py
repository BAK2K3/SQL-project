import os
import pymysql


# Get username?
username = os.getenv('GITPOD_WORKSPACE_ID')

# Connect to the database

connection = pymysql.connect(host='localhost',
                             user='root',
                             password='',
                             db='Chinook')

try:
    # Run a Query
    with connection.cursor() as cursor:
        sql = "SELECT * FROM Artist;"
        cursor.execute(sql)
        result = cursor.fetchall()
        print(result)
finally:
    # Close connection, regardless of whether the above was succesful
    connection.close()
