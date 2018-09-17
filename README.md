
# ubuntu-nginx-mysql-php-blog  
### Directories tree

```
├── Dockerfile
├── README.md
├── etc
│   ├── mysql
│   │   └── my.cnf
│   ├── nginx
│   │   ├── danian.conf
│   │   └── default.conf
│   └── php
│       └── php.ini
├── files
│   ├── default
│   ├── mysql_init.sh
│   ├── php-fpm.conf
│   ├── supervisord.conf
│   └── vk_blog.sql
├── lnmp.yml
└── var
    ├── db
    ├── log
    │   ├── nginx
    │   └── redis
    └── www
        └── web
```
 #### Note: docker and docker-compose version
    1.docker version 18.06.1-ce
    2.docker-compose version 1.22.0

#### Step1: Build image
`docker-compose -f lnmp.yml up --force-recreate -d`
```  
$ docker images                                                                                                                                                                                                                       
REPOSITORY          TAG                 IMAGE ID            CREATED              SIZE
visk_blog           latest              d9be987bcde3        About a minute ago   575MB
ubuntu              14.04               c32fae490809        11 days ago          188MB
mysql               5.7                 563a026a1511        12 days ago          372MB

$ docker ps -a                                                                                                                                                                                                                        
CONTAINER ID        IMAGE               COMMAND                  CREATED              STATUS              PORTS                                      NAMES
6dda740569bc        visk_blog           "supervisord --nodae…"   About a minute ago   Up About a minute   0.0.0.0:80->80/tcp, 0.0.0.0:443->443/tcp   visk_blog
c3231298db29        mysql:5.7           "docker-entrypoint.s…"   About a minute ago   Up About a minute   33060/tcp, 0.0.0.0:3308->3306/tcp          visk_blog_mysql                       
```

#### Step2: Init blog data
`docker exec visk_blog_mysql /tmp/mysql_init.sh`
```  
mysql: [Warning] Using a password on the command line interface can be insecure.
mysql: [Warning] Using a password on the command line interface can be insecure.
mysql: [Warning] Using a password on the command line interface can be insecure.
mysql容器启动完毕,数据导入成功!
mysql: [Warning] Using a password on the command line interface can be insecure.
mysql: [Warning] Using a password on the command line interface can be insecure.
mysql: [Warning] Using a password on the command line interface can be insecure.
mysql: [Warning] Using a password on the command line interface can be insecure.
MySQL Community Server 5.7.20 is running.
```  
#### Step3: Set localhost
``` 
127.0.0.1 www.danian.com
```
