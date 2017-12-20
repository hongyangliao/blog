---
title: 使用nginx作为静态文件服务器
date: 2017-12-21 01:07:25
tags:
      - Nginx
categories: Nginx      
---

#### 介绍:自己希望搭建个文件服务器用来下载常用的开发软件

#### 修改nginx的配置文件,加上如下内容
```
server {
        listen  80;
        # 填写域名或者ip地址
        server_name test.hongyangliao.com;
        # 文件存储目录
        root /data;

     location / {
         # 显示索引
         autoindex on;
         # 显示大小
         autoindex_exact_size on;
         # 显示时间
         autoindex_localtime on;
        }
}
```

#### 重启nginx服务,输入test.hongyangliao.com即可查看,页面如下图所示
```
Index of /

../
apache-maven-3.5.2-bin.tar.gz                      20-Dec-2017 02:30             8738691
apache-tomcat-7.0.82.tar.gz                        20-Dec-2017 02:30             8997403
apache-tomcat-8.0.48.tar.gz                        20-Dec-2017 02:30             9390469
apache-tomcat-8.5.24.tar.gz                        20-Dec-2017 02:30             9487006
jdk-7u80-linux-x64.tar.gz                          20-Dec-2017 02:52           153530841
jdk-8u151-linux-x64.tar.gz                         20-Dec-2017 01:20           189736377
nginx-1.8.1.tar.gz                                 20-Dec-2017 00:25              833473
redis-4.0.6.tar.gz                                 20-Dec-2017 02:31             1723533
```

#### 点击相应的文件即可下载,如想在下载linux服务器下载,使用如下命令
```
wget http://test.hongyangliao.com/apache-maven-3.5.2-bin.tar.gz
```
