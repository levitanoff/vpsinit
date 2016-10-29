#!/bin/bash

vhost_dir=/var/www/vhosts
hosts=`ls $vhost_dir`

for i in $hosts
do
	user=`stat -c %G $vhost_dir/$i`
	virtuser="admin@$i"
	passwd=`pwgen -s 12 1`
	(echo $passwd; echo $passwd) | pure-pw useradd $virtuser -u $user -g $user -d $vhost_dir/$i > /dev/null 2>&1
	printf "%-20s | %-32s | %12s\n" $i $virtuser $passwd;
done;

pure-pw mkdb
