#!/bin/sh

echo copying kakadu from s3...
aws s3 cp $KAKADULOCATION /opt/kakadu.tar.gz

echo extracting kakadu...
cd /opt && tar -xzvf kakadu.tar.gz

export LD_LIBRARY_PATH=/opt/kakadu/$KAKADULIBNAME/lib/Linux-x86-64-gcc

envsubst < /etc/lighttpd/lighttpd-1.conf.template > /etc/lighttpd/lighttpd-1.conf

chown www-data:www-data /tmp/iipsrv-1.log

echo starting lighttpd
lighttpd -D -f /etc/lighttpd/lighttpd-1.conf


