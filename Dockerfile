FROM ubuntu:14.04

ENV KAKADULOCATION s3://eu-west-1/dlcs-bootstrap-objects-1/kakadu.tar.gz

RUN apt-get update && apt-get install -y \
	lighttpd \
	libfcgi \
	libgomp1 \
	python-pip \
	groff \
    gettext-base \
    && rm -rf /var/lib/apt/lists/*

RUN pip install awscli

# dirty way to do it...
RUN ln -s /usr/lib/x86_64-linux-gnu/libtiff.so.5 /usr/lib/x86_64-linux-gnu/libtiff.so.4

RUN ln -s /etc/lighttpd/conf-available/10-fastcgi.conf /etc/lighttpd/conf-enabled/.

COPY lighttpd/lighttpd-1.conf.template /etc/lighttpd/lighttpd-1.conf.template

RUN mkdir -p /var/www/localhost

COPY ./fcgi-bin.tar.gz /var/www/localhost/

RUN cd /var/www/localhost && tar -xzvf fcgi-bin.tar.gz

COPY ./operations.sh /

ENV IMAGE_CACHE_SIZE 128

EXPOSE 8080
