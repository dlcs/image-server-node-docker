#!/bin/sh

aws s3 cp $KAKADULOCATION /opt/kakadu.tar.gz

cd /opt && tar -xzvf kakadu.tar.gz

export LD_LIBRARY_PATH=/opt/kakadu/kakadu-7.8/lib/Linux-x86-64-gcc

lighttpd -f /etc/lighttpd/lighttpd-1.conf

while true; do sleep 10; done


