---
title: Centos6.5服务器安装
date: 2017-11-29 13:23:21
tags:
      - Linux
categories: Linux
---

#### 关闭安全子系统
```
sed -i "s/SELINUX=enforcing/SELINUX=disabled/" /etc/selinux/config
setenforce 0
```

#### 安装wget
```
yum -y install wget
```

#### 更改默认镜像为阿里镜像
```
cd /etc/yum.repos.d && mv CentOS-Base.repo CentOS-Base.repo.bak
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-6.repo
yum makecache
yum clean all
```

#### 安装zip
```
yum install -y unzip zip
```

#### 安装vim
```
yum install -y vim
```

#### 安装scp
```
yum -y install openssh-clients
```

#### 安装相关依赖
```
yum -y install gcc-c++ tcl gettext-devel pcre-devel openssl openssl-devel bison flexcurl-devel expat-devel zlib-devel autoconf automake libtool python ncurses-devellibjpeg-devel e2fsprogs-devel sqlite-devel libcurl-devel speex-devel ldns-devel libeditdevelreadline-devel ncurses-devel pam-develnumactl
```

#### 安装screen会话
```
yum -y install screen
```

#### 安装ntpdate时间同步工具
```
yum -y install ntpdate
echo '0 1 * * * ntpdate cn.pool.ntp.org;hwclock -w' >> /var/spool/cron/root
```

#### 安装java
```
mkdir -p /opt/java
cd ~ && wget http://storage.csf89757.com/jdk-8u144-linux-x64.tar.gz
mv jdk-8u144-linux-x64.tar.gz /opt/java/
cd /opt/java
tar -xzvf jdk-8u144-linux-x64.tar.gz
rm -rf jdk-8u144-linux-x64.tar.gz
echo 'export JAVA_HOME=/opt/java/jdk1.8.0_144' >> /etc/profile
echo 'exportCLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib/rt.jar' >> /etc/profile
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /etc/profile
cd /usr/bin
ln -s -f /opt/java/jdk1.8.0_144/jre/bin/java
ln -s -f /opt/java/jdk1.8.0_144/bin/javac
```

#### 安装Tomcat
```
cd ~ && wget http://storage.csf89757.com/apache-tomcat-8.0.46.tar.gz
mv apache-tomcat-8.0.46.tar.gz /usr/local/
cd /usr/local
tar -xzvf apache-tomcat-8.0.46.tar.gz
mv apache-tomcat-8.0.46 tomcat8
mv apache-tomcat-8.0.46.tar.gz /usr/local/src
echo 'export CATALINA_HOME=/usr/local/tomcat8' >> /etc/profile
source /etc/profile
```

#### 设置Tomcat自启
```
cd /etc/init.d
touch tomcat8 && chmod 755 tomcat8 && vim tomcat8
```
##### 添加如下命令,注意JAVA_HOME,CATALANA_HOME

```
#!/bin/bash    
#    
# tomcat startup script for the Tomcat server    
#    
# chkconfig: 345 80 20    
# description: start the tomcat deamon    
#    
# Source function library    
. /etc/rc.d/init.d/functions

prog=tomcat8
JAVA_HOME=/opt/java/jdk1.8.0_144
export JAVA_HOME    
CATALANA_HOME=/usr/local/tomcat8
export CATALINA_HOME    

case "$1" in
start)
    echo "Starting Tomcat..."    
    $CATALANA_HOME/bin/startup.sh
    ;;

stop)
    echo "Stopping Tomcat..."    
    $CATALANA_HOME/bin/shutdown.sh
    ;;

restart)
    echo "Stopping Tomcat..."    
    $CATALANA_HOME/bin/shutdown.sh
    sleep 2
    echo    
    echo "Starting Tomcat..."    
    $CATALANA_HOME/bin/startup.sh
    ;;

*)
    echo "Usage: $prog {start|stop|restart}"    
    ;;
esac
exit 0
```


#### 安装nginx
```
cd && wget http://storage.csf89757.com/nginx-1.8.0.tar.gz
wget http://storage.csf89757.com/vhosts.tar.gz
wget http://storage.csf89757.com/nginx
wget http://storage.csf89757.com/nginx.conf
mv nginx-1.8.0.tar.gz /usr/local/src
cd /usr/local/src && tar -xzvf nginx-1.8.0.tar.gz
cd nginx-1.8.0 && ./configure --prefix=/opt/nginx
make && make install
mv /opt/nginx/conf/nginx.conf /opt/nginx/conf/nginx.conf.bak
mv ~/nginx.conf /opt/nginx/conf
cd ~ && tar -xzvf vhosts.tar.gz && mv vhosts /opt/nginx && rm -rf vhosts.tar.gz
mv ~/nginx /etc/init.d
chmod +x /etc/init.d/nginx
chkconfig --add nginx
chkconfig --level 345 nginx on
service nginx start
```

#### 安装mysql
```
wget http://repo.mysql.com/mysql-community-release-el6-5.noarch.rpm
rpm -ivh mysql-community-release-el6-5.noarch.rpm
yum install mysql-server
/etc/init.d/mysqld start
mysql_secure_installation
mysql -uroot -p
use mysql;
GRANT ALL PRIVILEGES ON *.* TO 'kerby'@'%' IDENTIFIED BY 'kerbywang' WITH GRANT OPTION;
FLUSH PRIVILEGES;
```

#### 修改mysql数据库编码为UTF-8，修改/etc/my.cnf或者/etc/mysql/my.cnf文件
```
[client]
default-character-set = utf8
[mysqld]
default-storage-engine = INNODB
character-set-server = utf8
collation-server = utf8_general_ci
```

#### 重启mysql服务，并查看数据库编码
```
service mysqld restart
mysql -uroot -p
show variables like '%char%';
```
编码为以下即可
```
+--------------------------+----------------------------+
| Variable_name            | Value                      |
+--------------------------+----------------------------+
| character_set_client     | utf8                       |
| character_set_connection | utf8                       |
| character_set_database   | utf8                       |
| character_set_filesystem | binary                     |
| character_set_results    | utf8                       |
| character_set_server     | utf8                       |
| character_set_system     | utf8                       |
| character_sets_dir       | /usr/share/mysql/charsets/ |
+--------------------------+----------------------------+
```

#### 安装Maven
```
cd ~ && wget http://storage.csf89757.com/apache-maven-3.2.5-bin.tar.gz
mv apache-maven-3.2.5-bin.tar.gz /usr/local/
cd /usr/local && tar -xzvf apache-maven-3.2.5-bin.tar.gz
mv apache-maven-3.2.5 maven
echo 'M2_HOME=/usr/local/maven' >> /etc/profile
echo 'export PATH=$M2_HOME/bin:$PATH' >> /etc/profile
source /etc/profile
mvn help:system
cp /usr/local/maven/conf/settings.xml /root/.m2/
mv /usr/local/apache-maven-3.2.5-bin.tar.gz /usr/local/src/
```
#### 安装Git
```
yum -y install git
```

#### 配置公钥
```
ssh-keygen -t rsa
```
