#!/bin/sh

echo copying kakadu from s3...
aws s3 cp $KAKADULOCATION /opt/kakadu.tar.gz

echo extracting kakadu...
cd /opt && tar -xzvf kakadu.tar.gz

export LD_LIBRARY_PATH=/opt/kakadu/kakadu-7.A.3/lib/Linux-x86-64-gcc

echo touching initial iipsrv log file
touch /tmp/iipsrv-1.log
chown www-data:www-data /tmp/iipsrv-1.log

echo starting lighttpd
lighttpd -f /etc/lighttpd/lighttpd-1.conf

echo tailing log...
tail -f /tmp/iipsrv-1.log
