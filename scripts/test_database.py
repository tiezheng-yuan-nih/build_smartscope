#! /usr/bin/python3
'''
Test database:
    installation of mariadb server
    root and superuser
    database connection
'''
import os
import pymysql
import pymysql.cursors

db_info = {
    'database': None,
}


# Connect to the database
try:
    connection = pymysql.connect(
        host=os.environ.get('MYSQL_HOST', 'localhost'),
        port=int(os.environ.get('MYSQL_HOST', '3306')),
        user=os.environ.get('MYSQL_USER', 'root'),
        password=os.environ.get('MYSQL_PASSWORD', 'pass'),
        charset='utf8mb4',
        cursorclass=pymysql.cursors.DictCursor
    )

    with connection:
        with connection.cursor() as cursor:
            #check mariadb version
            sql = "SELECT @@VERSION"
            cursor.execute(sql)
            res = cursor.fetchall()[0]
            print(f"Version of MariaDB is {res}.")

            # detect database smartscope
            sql = "SHOW DATABASES"
            cursor.execute(sql)
            res = cursor.fetchall()
            for db in res:
                if db['Database'] == 'smartscope':
                    print(f"GOOD! Database smartscope exists in mariadb.")
                    db_info['database'] = 'smartscope'
                    break
            if not db_info['database']:
                sql = "CREATE DATABASE smartscope"
                cursor.execute(sql)
                print(f"Default database known as smartscope is created.")
except Exception as e:
    print(f"ERROR! Can't connect to MariaDB. error={e}")