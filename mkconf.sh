#!/bin/bash

BASEDIR=/var/www/vhosts
APACHEDIR=/etc/apache2/sites-available
NGINXDIR=/etc/nginx/sites-available

hosts=`ls $BASEDIR`

for i in $hosts
do
	user=`stat -c %G $BASEDIR/$i`
	echo $i
	chown -R $user:$user $BASEDIR/$i/{htdocs,fcgi-bin}
	sed "s/%domain/$i/g; s/%user/$user/g; s/%group/$user/g" apache.tpl > $APACHEDIR/$i.conf
	a2ensite $i
	sed "s/%domain/$i/g;" nginx.tpl > $NGINXDIR/$i
	ngx-conf -e $i
done
