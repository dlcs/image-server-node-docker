#!/bin/sh

aws s3 cp $KAKADULOCATION /opt/kakadu.tar.gz

cd /opt && tar -xzvf kakadu.tar.gz

lighttpd -f /etc/lighttpd/lighttpd-1.conf

while true; do sleep 10; done


