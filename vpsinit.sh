#!/bin/bash

apt-get install vim-nox curl pwgen

at <<EOF >> /etc/apt/sources.list

deb http://packages.dotdeb.org jessie all
deb-src http://packages.dotdeb.org jessie all
EOF

curl 'https://www.dotdeb.org/dotdeb.gpg' | apt-key add -

apt-get update
apt-get upgrade

dpkg-reconfigure dash

apt-get install mariadb-server mariadb-client mariadb-common

mypw=`pwgen -s 12 1`
echo "$mypw" > /root/.mypw
echo "$mypw"
chmod 700 /root/.mypw

mysql_secure_installation

apt-get install mcrypt memcached php5 php5-cgi php5-cli php5-common php5-curl php5-gd php5-mcrypt php5-memcache php5-mysql
#apt-get install mcrypt memcached php7.0 php7.0-cgi php7.0-cli php7.0-common php7.0-curl php7.0-gd php7.0-mcrypt php7.0-memcache php7.0-mysql

apt-get install apache2 apache2-mpm-worker apache2-suexec-custom libapache2-mod-fcgid libapache2-mod-rpaf

a2enmod rewrite suexec

sed -i.back 's/Listen 80$/Listen 8080/g' /etc/apache2/ports.conf

for i in `find /etc/apache2/sites-available -type f -name "*.conf"` 
do 
	echo $i; 
	sed -i 's/*:80>/*:8080>/g' $i
done

service apache2 restart

apt-get install nginx
