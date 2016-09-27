#!/bin/bash
HOST=$( curl http://169.254.169.254/latest/meta-data/public-ipv4 )
if [ -z ${HOST+x} ]; then echo "HOST is unset, set it to an ip address, export HOST=a.b.c.d"; exit 1; fi
echo HOST $HOST

if [ -z ${PASSWORD+x} ]; then echo "PASSWORD is unset, export PASSWORD=rootpassword"; exit 1; fi
echo PASSWORD $PASSWORD

sudo yum -y update
sudo yum -y install mysql-server mysql git

if grep bind-address /etc/my.cnf; then echo /etc/my.cnf bound; else echo 'bind-address=0.0.0.0' in sudo vim /etc/my.cnf; exit 1; fi

sudo service mysqld restart

mysql -u root --execute="CREATE USER 'root'@'%' IDENTIFIED BY '$PASSWORD';"
mysql -u root --execute="GRANT ALL PRIVILEGES ON * . * TO 'root'@'%';"
cd ~
git clone https://github.com/datacharmer/test_db.git
cd test_db
mysql -u root < employees.sql
