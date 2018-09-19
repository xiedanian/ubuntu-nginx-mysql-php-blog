FROM ubuntu:14.04
MAINTAINER Visk <jinxiang.gz@gmail.com>

# Update apt-get local index
RUN apt-get update

# Install
RUN apt-get -y --force-yes install \
            wget \
            curl \
            git \
            unzip \
            supervisor \
            g++ \
            make \
            nginx \
            openssh-server \
            redis-server \
            php5-cli \
            php5-fpm \
            php5-dev \
            php5-mysql \
            php5-curl \
            php5-intl \
            php5-mcrypt \
            php5-memcache \
            php5-imap \
            php5-sqlite\
            libpcre3 \
            libpcre3-dev\
            openssl \
            libssl-dev


RUN bash -c "wget http://getcomposer.org/composer.phar && mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer"

# PHP Redis
RUN mkdir -p /tmp/php-redis
WORKDIR /tmp/php-redis
RUN wget https://github.com/phpredis/phpredis/archive/2.2.5.zip; unzip 2.2.5.zip
WORKDIR /tmp/php-redis/phpredis-2.2.5
RUN /usr/bin/phpize; ./configure; make; make install
RUN echo "extension=redis.so" > /etc/php5/mods-available/redis.ini
RUN php5enmod redis

# PHP Yaf
RUN mkdir -p /tmp/php-yaf
WORKDIR /tmp/php-yaf
#RUN wget https://codeload.github.com/laruence/yaf/zip/yaf-3.0.5; unzip yaf-3.0.5
RUN wget https://codeload.github.com/laruence/yaf/zip/php5; unzip php5
WORKDIR /tmp/php-yaf/yaf-php5
RUN /usr/bin/phpize; ./configure; make; make install
RUN echo "extension=yaf.so" > /etc/php5/mods-available/yaf.ini
RUN php5enmod yaf

# PHP conf
RUN sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php5/fpm/php.ini
RUN sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php5/cli/php.ini
RUN sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php5/fpm/php.ini
RUN sed -i "s/;daemonize = yes/daemonize = no/" /etc/php5/fpm/php-fpm.conf

# nginx conf
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf

# Install Visk Blog
RUN mkdir -p /var/www/web
ADD http://ftp.visk.com.cn/blog-2.0.tar.gz  /tmp/blog-2.0.tar.gz
RUN cd /tmp/ \
    && tar xvf blog-2.0.tar.gz \
    && rm blog-2.0.tar.gz

RUN mv /tmp/visk /var/www/web \
    && chmod -R 775 /var/www \
    && chown -R www-data:www-data /var/www/web/visk

ADD files/supervisord.conf /etc/supervisor/supervisord.conf
ADD files/php-fpm.conf /etc/php5/fpm/php-fpm.conf

# Expose ports
EXPOSE 80
EXPOSE 443

# Default command for container, start supervisor
CMD ["supervisord", "--nodaemon"]

