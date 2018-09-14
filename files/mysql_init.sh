#!/bin/bash
HOST="localhost"
USER="root"
PASSWORD="123456"
DATABASE="vk_blog"

mysql -h $HOST -u $USER -p$PASSWORD  -e "drop database if exists $DATABASE"
mysql -h $HOST -u $USER -p$PASSWORD  -e "create database $DATABASE character set utf8"
mysql -h $HOST -u $USER -p$PASSWORD $DATABASE < /tmp/vk_blog.sql

echo 'mysql容器启动完毕,数据导入成功!'

#创建远程连接用户
mysql -h $HOST -u $USER -p$PASSWORD  -e "flush privileges"
mysql -h $HOST -u $USER -p$PASSWORD  -e "use mysql"
mysql -h $HOST -u $USER -p$PASSWORD  -e "grant all on *.* to '$USER'@'%' identified by '$PASSWORD' with grant option"
mysql -h $HOST -u $USER -p$PASSWORD  -e "flush privileges"

echo `service mysql status`

