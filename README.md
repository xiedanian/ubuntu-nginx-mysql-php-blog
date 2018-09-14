
# ubuntu-nginx-mysql-php-blog  
### Directories  

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

#### Step1: Build 镜像
`docker-compose -f lnmp.yml up --force-recreate -d`
```  
$ docker images                                                                                                                                                                                                                       
REPOSITORY                                      TAG                       IMAGE ID            CREATED             SIZE
visk_blog                                       latest                    28a06a1ac3cf        32 minutes ago      582MB

$ docker ps -a                                                                                                                                                                                                                        
CONTAINER ID        IMAGE                                              COMMAND                  CREATED             STATUS                      PORTS                                             NAMES
0c7dd99759a2        visk_blog                                          "supervisord --nodae…"   23 minutes ago      Up 23 minutes               0.0.0.0:80->80/tcp, 0.0.0.0:443->443/tcp          visk_blog
f89d330d1c62        mysql:5.7                                          "docker-entrypoint.s…"   About an hour ago   Up About an hour            0.0.0.0:3306->3306/tcp                            visk_blog_mysql
```

#### Step2: 初始化Blog数据
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
#### Step3: 设置本地Host
``` 
127.0.0.1 www.danian.com
```