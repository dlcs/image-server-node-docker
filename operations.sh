#!/bin/bash

aws s3 cp $KAKADULOCATION /opt/kakadu.tar.gz

cd /opt && tar -xzvf kakadu.tar.gz

lighttpd -D -f /etc/lighttpd/lighttpd-1.conf
