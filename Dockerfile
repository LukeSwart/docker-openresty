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
RUN mkdir /logs
RUN mkdir -p /var/log/nginx
RUN mkdir /var/www

# Openresty (Nginx)
RUN    apt-get -y build-dep nginx \
  && apt-get -q -y clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*
RUN    wget https://openresty.org/download/openresty-1.9.7.3.tar.gz \
  && tar xvfz openresty-1.9.7.3.tar.gz \
  && cd openresty-1.9.7.3 \
  && ./configure --with-luajit  --with-http_addition_module --with-http_dav_module --with-http_geoip_module --with-http_gzip_static_module --with-http_image_filter_module --with-http_realip_module --with-http_stub_status_module --with-http_ssl_module --with-http_sub_module --with-http_xslt_module --with-ipv6 --with-http_postgres_module --with-pcre-jit \
  && make \
  && make install \
  && rm -rf /openresty*

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

# Copies the nginx file to the container's filesystem
ADD nginx.conf nginx.conf

EXPOSE 80
CMD /usr/local/openresty/nginx/sbin/nginx -p `pwd` -c nginx.conf
