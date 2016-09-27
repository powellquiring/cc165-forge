#!/bin/bash
sudo yum -y update
sudo yum -y install mysql-server mysql git

if [ -z ${HOST+x} ]; then echo "HOST is unset, set it to the IP address"; exit 1; fi
echo HOST $HOST

if [ -z ${PASSWORD+x} ]; then echo "PASSWORD is unset, set mysql password"; exit 1; fi
echo PASSWORD $PASSWORD

if [ grep bin-address /etc/my.cnf ]; then echo 'bind-address=0.0.0.0' in vim /etc/my.cnf; fi

mysql –u root –password=rootpassword <<EOF
CREATE USER 'root'@'%' IDENTIFIED BY '$PASSWORD';
EOF

sudo service mysqld restart
#connect from desktop

