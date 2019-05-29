#!/bin/sh

echo copying kakadu from s3...
aws s3 cp $KAKADULOCATION /opt/kakadu.tar.gz

echo extracting kakadu...
cd /opt && tar -xzvf kakadu.tar.gz

export LD_LIBRARY_PATH=/opt/kakadu/$KAKADULIBNAME/lib/Linux-x86-64-gcc

envsubst < /etc/lighttpd/lighttpd-1.conf.template > /etc/lighttpd/lighttpd-1.conf

# Allow `www-data` user to write to /dev/stderr
mkfifo -m 600 /tmp/logpipe
chown www-data:www-data /tmp/logpipe
cat <> /tmp/logpipe 1>&2 &

echo starting lighttpd
lighttpd -D -f /etc/lighttpd/lighttpd-1.conf
