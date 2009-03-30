#!/bin/sh

day=$(date +%d);
mysql -N -e 'SHOW DATABASES' | \
while read db; 
do 
    mysqldump ${db} > /var/backups/mysql/daily/${db}.${day}.sql
    bzip2 /var/backups/mysql/daily/${db}.${day}.sql
done

