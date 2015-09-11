# Dockerfile for openresty
# VERSION   0.0.4

FROM ubuntu:14.04
MAINTAINER Luke Swart <luke.swart@gmail.com>
ENV REFRESHED_AT 2014-08-08

ENV    DEBIAN_FRONTEND noninteractive
RUN    echo "deb-src http://archive.ubuntu.com/ubuntu trusty main" >> /etc/apt/sources.list
RUN    sed 's/main$/main universe/' -i /etc/apt/sources.list
RUN    apt-get update
RUN    apt-get upgrade -y
RUN    apt-get -y install wget vim git libpq-dev curl

# App specifics
RUN mkdir /duwamish-api
RUN mkdir /logs
RUN mkdir -p /var/log/nginx
RUN mkdir /var/www
# VOLUME ["/duwamish/staticfiles"]

# Openresty (Nginx)
RUN    apt-get -y build-dep nginx \
  && apt-get -q -y clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*
# Install Openresty with lua: http://wiki.nginx.org/HttpLuaModule#Installation
RUN    wget http://openresty.org/download/ngx_openresty-1.7.7.1.tar.gz \
    && tar xvfz ngx_openresty-1.7.7.1.tar.gz \
    && cd ngx_openresty-1.7.7.1 \
    && ./configure --with-luajit \
  && make \
  && make install \
  && rm -rf /ngx_openresty*

# Copies the nginx file to the container's filesystem
# ADD ssl ssl
# ADD nginx.conf nginx.conf

EXPOSE 80
EXPOSE 443
# EXPOSE 9090
CMD /usr/local/openresty/nginx/sbin/nginx -p `pwd` -c nginx.conf
