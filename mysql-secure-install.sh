#!/bin/bash

# Make sure that NOBODY can access the server without a password
mysql -e "UPDATE mysql.user SET Password = PASSWORD('password') WHERE User = 'root'"
# Kill the anonymous users
mysql -e "DROP USER ''@'localhost'"
# Because our hostname varies we'll use some Bash magic here.
mysql -e "DROP USER ''@'$(hostname)'"
# Kill off the demo database
mysql -e "DROP DATABASE IF EXISTS test"
mysql -e "CREATE USER 'foxsarh'@'localhost' identified by '123';"
mysql -e "grant all privileges on *.* to 'foxsarh'@'localhost';"
# Make our changes take effect
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'password'; FLUSH PRIVILEGES;"
# Any subsequent tries to run queries this way will get access denied because lack of usr/pwd para