#!/bin/bash
HOST=$( curl http://169.254.169.254/latest/meta-data/public-ipv4 )
if [ -z ${HOST+x} ]; then echo "HOST is unset, set it to the IP address"; exit 1; fi
echo HOST $HOST

if [ -z ${PASSWORD+x} ]; then echo "PASSWORD is unset, set mysql password"; exit 1; fi
echo PASSWORD $PASSWORD

sudo yum -y update
sudo yum -y install mysql-server mysql git

if [ grep bin-address /etc/my.cnf ]; then echo 'bind-address=0.0.0.0' in vim /etc/my.cnf; fi

sudo service mysqld restart

mysql –u root -e "CREATE USER 'root'@'%' IDENTIFIED BY '$PASSWORD';"
cd ~
git clone https://github.com/datacharmer/test_db.git
cd test_db
mysql -u root < employees.sql



#connect from desktop

