---
title: mysql数据库设置utf-8编码
date: 2017-11-20 09:22:08
tags:
    -mysql
categories: mysql            
---
#### 修改/etc/my.cnf或者/etc/mysql/my.cnf文件
```
[client]
default-character-set = utf8
[mysqld]
default-storage-engine = INNODB
character-set-server = utf8
collation-server = utf8_general_ci
```

#### 重启mysql,使用mysql客户端检查编码
```
show variables like '%char%';
```
