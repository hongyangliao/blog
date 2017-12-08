---
title: Linux常见操作
date: 2017-08-29 17:07:06
tags:
      - Linux
categories: Linux      
---
> 注意事项：基于centos6

#### 修改密码
> passwd

passwd 作为普通用户和超级权限用户都可以运行，但作为普通用户只能更改自己的用户密码，但前提是没有被root用户锁定；如果root用户运行passwd ，可以设置或修改任何用户的密码

passwd 命令后面不接任何参数或用户名，则表示修改当前用户的密码

#### 修改主机名
 > hostname

  1.使用hostname修改主机名
  hostname hongyangliao-pc

  2.修改/etc/sysconfig/network配置文件
  修改HOSTNAME=hongyangliao-pc

  3.修改本机域名解析文件/etc/hosts
  将原来的主机名换为hongyangliao-pc

#### 修改SSH端口
  1.修改SSH端口配置文件/etc/ssh/sshd_config,将Port的值换为想要的端口号

  2.重启SSH服务，service sshd restart

####  iptabels配置
  1.修改/etc/sysconfig/iptbles 文件
  ```
  *filter
  # Allow loopback (lo0) traffic and drop all traffic to 127/8 that doesn't use the lo0 interface
  -A INPUT -i lo -j ACCEPT
  -A INPUT -i ! lo -d 127.0.0.0/8 -j REJECT
  # Accept established inbound connections
  -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
  # Allow all outbound traffic
  -A OUTPUT -j ACCEPT
  # Allow HTTP and HTTPS connections
  -A INPUT -p tcp --dport 80 -j ACCEPT
  -A INPUT -p tcp --dport 443 -j ACCEPT
  # Allow SSH/SFTP
  # Change the value 22 if you are using a non-standard port
  -A INPUT -p tcp -m state --state NEW --dport 22 -j ACCEPT
  # Allow FTP
  # Purely optional, but required for WordPress to install its own plugins or update itself.
  -A INPUT -p tcp -m state --state NEW --dport 21 -j ACCEPT
  # Allow PING
  # Again, optional. Some disallow this altogether.
  -A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT
  # Reject ALL other inbound
  -A INPUT -j REJECT
  -A FORWARD -j REJECT
  COMMIT
  ```
  2.保存
  ```
  service iptables save
  ```

  3.重启
  ```
  service iptables restart
  ```

  4.添加到自启动
  ```
  chkconfig iptables on
  ```


#### 安装JDK
  方法一：手动解压JDK，设置环境变量
  1.在/usr/目录下创建java目录
  ```
  # mkdir/usr/java
  ```

  2.下载JDK，并解压（使用七牛云下载）
  ```
  # wget http://ovg7i1lse.bkt.clouddn.com/jdk-8u144-linux-x64.tar.gz
    # tar -zxvf jdk-8u144-linux-x64.tar.gz
  ```

  3.设置环境变量
  ```
  # vi /etc/profile
  ```
  添加内容为
  ```
  #set java environment
  JAVA_HOME=/usr/java/jdk1.8.0_144
  JRE_HOME=/usr/java/jdk1.8.0_144/jre
  CLASS_PATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib
  PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin
  export JAVA_HOME JRE_HOME CLASS_PATH PATH
  ```
  使修改生效
  ```
  source /etc/profile
  ```

  4.验证JDK是否生效
  ```
  # java -version
  java version "1.8.0_144"
  Java(TM) SE Runtime Environment (build 1.8.0_144-b01)
  Java HotSpot(TM) 64-Bit Server VM (build 25.144-b01, mixed mode)
  ```

  方法二：使用yum安装JDK
  1.查看yum库中的jdk版本
  ```
  # yum search java|grep jdk
  ```

  2.选择版本安装
  ```
  # yum install java-1.7.0-openjdk
  ```

  3.设置环境变量
  方法三：用rpm安装JDK
  1.下载rpm安装文件
  ```
  # wget http://ovg7i1lse.bkt.clouddn.com/jdk-8u144-linux-x64.rpm
  ```

  2.使用rpm命令安装
  ```
  # rpm -ivh jdk-8u144-linux-x64.rpm
  ```

  3.设置环境变量

#### ssh scp 免密码登录
  1.本机创建公钥、密钥
  ssh-keygen -t rsa
  一路回车到底

  2.把公钥id_rsa.pub复制到远程服务器上~/.ssh目录并命名为authorized_keys

#### 远程复制scp
  1.从本地复制到远程服务器
  ```
  # scp local_file remote_username@remote_ip:remote_folder
  ```

  2.从远程服务器复制到本地
  ```
  # $scp remote_username@remote_ip:remote_file local_folder
  ```

#### 安装redis
  1.下载redis
  ```
  # wget http://download.redis.io/releases/redis-3.0.0.tar.gz
  ```
  2.复制redis到/usr/local
  ```
  # cp redis-3.0.0.rar.gz /user/local
  ```

  3.解压
  ```
  # tar -zxvf redis-3.0.0.tar.gz
  ```

  4.编译并安装到指定目录
  ```
  # cd /usr/local/redis-3.0.0
  # make PREFIX=/usr/local/redis install
  ```

  5.将源码中的目录复制到安装目录
  ```
  # cd /usr/local/redis
  # mkdir conf
  # cp /usr/local/redis-3.0.0/redis.conf  /usr/local/redis/conf
  ```

  6./usr/local/redis/bin的文件结构
  ```
  redis-benchmark redis性能测试工具
  redis-check-aof AOF文件修复工具
  redis-check-rdb RDB文件修复工具
  redis-cli redis命令行客户端
  redis-sentinal redis集群管理工具
  redis-server redis服务进程
  ```

  7.启动redis
  前端模式启动
  ```
  # ./redis-server
  ```

  后端启动模式(修改/usr/local/redis/conf/redis.conf)
  ```
  # vim /usr/local/redis/conf/redis.conf
  ```
  修改为
  ```
  ################################ GENERAL  #####################################

  # By default Redis does not run as a daemon. Use 'yes' if you need it.
  # Note that Redis will write a pid file in /var/run/redis.pid when daemonized.
  daemonize yes
  ```
  启动redis
  ```
  # cd /usr/local/redis
  # ./bin/redis-server ./conf/redis.conf
  ```

  8.加入开机自启
  ```
  # vim /etc/rc.local
  ```
  在rc.local中中添加
  ```
  # redis
  /usr/local/redis/bin/redis-server /user/local/redis/conf/redis.conf
  ```

  9.关闭redis
  ```
  # cd /usr/local/redis
  # ./bin/redis-cli shutdown
  ```

#### 安装nginx
  1.下载nginx
  ```
  # wget http://ovg7i1lse.bkt.clouddn.com/nginx-1.8.0.tar.gz
  ```

  2.解压并编译
  ```
  # tar -zxvf nginx-1.8.0.tar.gz
  # cd nginx-1.8.0 && ./configure --prefix=/user/local/nginx
  # make && make install
  ```

  3.配置开机自启
  ```
  # vim /etc/init.d/nginx
  ```
  加入如下内容
  ```
  #!/bin/sh
  #
  # nginx – this script starts and stops the nginx daemon
  #
  # chkconfig: - 85 15
  # description: Nginx is an HTTP(S) server, HTTP(S) reverse \
  # proxy and IMAP/POP3 proxy server
  # processname: nginx
  # 根据安装的不同位置而改变
  # config: /usr/local/nginx/conf/nginx.conf
  # pidfile: /usr/local/nginx/logs/nginx.pid

  # Source function library.
  . /etc/rc.d/init.d/functions

  # Source networking configuration.
  . /etc/sysconfig/network

  # Check that networking is up.
  [ "$NETWORKING" = "no" ] && exit 0

  nginx="/usr/local/nginx/sbin/nginx"
  prog=$(basename $nginx)

  NGINX_CONF_FILE="/usr/local/nginx/conf/nginx.conf"

  lockfile=/var/lock/subsys/nginx

  start() {
  [ -x $nginx ] || exit 5
  [ -f $NGINX_CONF_FILE ] || exit 6
  echo -n $"Starting $prog: "
  daemon $nginx -c $NGINX_CONF_FILE
  retval=$?
  echo
  [ $retval -eq 0 ] && touch $lockfile
  return $retval
  }

  stop() {
  echo -n $"Stopping $prog: "
  killproc $prog -QUIT
  retval=$?
  echo
  [ $retval -eq 0 ] && rm -f $lockfile
  return $retval
  }

  restart() {
  configtest || return $?
  stop
  start
  }

  reload() {
  configtest || return $?
  echo -n $”Reloading $prog: ”
  killproc $nginx -HUP
  RETVAL=$?
  echo
  }

  force_reload() {
  restart
  }

  configtest() {
  $nginx -t -c $NGINX_CONF_FILE
  }

  rh_status() {
  status $prog
  }

  rh_status_q() {
  rh_status >/dev/null 2>&1
  }

  case "$1" in
  start)
  rh_status_q && exit 0
  $1
  ;;
  stop)
  rh_status_q || exit 0
  $1
  ;;
  restart|configtest)
  $1
  ;;
  reload)
  rh_status_q || exit 7
  $1
  ;;
  force-reload)
  force_reload
  ;;
  status)
  rh_status
  ;;
  condrestart|try-restart)
  rh_status_q || exit 0
  ;;
  *)
  echo $"Usage: $0 {start|stop|status|restart|condrestart|try-restart|reload|force-reload|configtest}"
  exit 2
  esac
  ```
  修改/etc/rc.local
  ```
  # vim /etc/rc.local
  ```
  加入如下内容
  ```
  # nginx
  /etc/init.d/nginx start
  ```
#### 网络设置
  1.修改ip地址
  修改对应网卡的ip地址
  ```
  # vim /etc/sysconfig/network-scripts/ifcfg-eth0
  ```
  修改以下内容
  ```
  DEVICE=eth0 #描述网卡对应的设备别名，例如ifcfg-eth0的文件中它为eth0
  BOOTPROTO=static #设置网卡获得ip地址的方式，可能的选项为static，dhcp或bootp，分别对应静态指定的 ip地址，通过dhcp协议获得的ip地址，通过bootp协议获得的ip地址
  BROADCAST=192.168.0.255 #对应的子网广播地址
  HWADDR=00:07:E9:05:E8:B4 #对应的网卡物理地址
  IPADDR=12.168.1.2 #如果设置网卡获得 ip地址的方式为静态指定，此字段就指定了网卡对应的ip地址
  IPV6INIT=no
  IPV6_AUTOCONF=no
  NETMASK=255.255.255.0 #网卡对应的网络掩码
  NETWORK=192.168.1.0 #网卡对应的网络地址
  ONBOOT=yes #系统启动时是否设置此网络接口，设置为yes时，系统启动时激活此设备
  ```
  2.修改网关
  修改对应网卡的网关
  ```
  # vim /etc/sysconfig/network
  ```
  修改以下内容
  ```
  NETWORKING=yes #表示系统是否使用网络，一般设置为yes。如果设为no，则不能使用网络，而且很多系统服务程序将无法启动
  HOSTNAME=centos #设置本机的主机名，这里设置的主机名要和/etc/hosts中设置的主机名对应
  GATEWAY=192.168.1.1 #设置本机连接的网关的IP地址。例如，网关为10.0.0.2
  ```

  3.修改DNS
  修改对应网卡的DNS
  ```
  # vim /etc/resolv.conf
  ```
  修改以下内容
  ```
  nameserver 8.8.8.8 #google域名服务器
  nameserver 8.8.4.4 #google域名服务器
  ```

  4.重启网卡
  ```
  #  /etc/init.d/network restart
  ```

  5.简单设置(推荐)
  修改对应网卡的网关
  ```
  # vim /etc/sysconfig/network-scripts/ifcfg-eth0
  ```
  修改以下内容
  ```
  BOOTPROTO=static #静态指定ip
  ONBOOT=yes #系统启动时是否设置此网络接口，设置为yes时，系统启动时激活此设备
  IPADDR=192.168.149.10 #ip地址
  NETMASK=255.255.255.0 #子网掩码
  GATEWAY=192.168.149.2 #网关
  DNS1=8.8.8.8 #DNS
  DNS2=4.4.4.4
  IPV6INIT=no
  DEVICE=eth0 #描述网卡对应的设备别名，例如ifcfg-eth0的文件中它为eth0
  ```
  重启网卡
  ```
  #  /etc/init.d/network restart
  ```

#### 安装Apache
  1.停止并卸载系统自带的httpd服务
  ```
  # service httpd stop
  # ps -ef | grep httpd
  # kill -9 pid号（逐个删除）
  # rpm -qa |grep httpd
  # rpm -e httpd软件包
  ```

  2.安装Apache
  ```
  # wget http://mirrors.hust.edu.cn/apache//httpd/httpd-2.2.34.tar.gz
  # tar -zxvf httpd-2.2.34.tar.gz
  ```

  3.编译
  ```
  # ./configure --prefix=/usr/local/apache
  # make && make install
  ```

  4.启动、停止、重启
  启动Apache：/usr/local/apache2/bin/apachectl start
  停止Apache：/usr/local/apache2/bin/apachectl stop
  重启Apache：/usr/local/apache2/bin/apachectl restart

  5.网站放置目录
  网站放在/usr/local/apache/htdocs

#### 安装php
  1.安装依赖文件(不安装的话，自己会安装很多东西)
  ```
  # yum groupinstall "Development tools"
  # yum install libxml2-devel gd-devel libmcrypt-devel libcurl-devel openssl-devel
  ```

  2.安装php
  ```
  # wget http://php.net/get/php-5.5.38.tar.gz/from/this/mirror
  # tar -zxvf php-5.5.38.tar.gz
  ```

  3.编译
  ```
  # ./configure --prefix=/usr/local/php --with-apxs2=/usr/local/apache/bin/apxs --disable-cli --enable-shared --with-libxml-dir --with-gd --with-openssl --enable-mbstring --with-mysqli --with-mysql --enable-opcache --enable-mysqlnd --enable-zip --enable-fpm --enable-fastcgi --with-zlib-dir --with-pdo-mysql --with-jpeg-dir --with-freetype-dir --with-curl --without-pdo-sqlite --without-sqlite3 --with-mcrypt=/usr/local/libmcrypt/
  # make && make install
  ```

  4.注意事项
  如果出现 configure: error: mcrypt.h not found. Please reinstall libmcrypt
  则需安装libmcrypt
  ```
  # wget ftp://mcrypt.hellug.gr/pub/crypto/mcrypt/attic/libmcrypt/libmcrypt-2.5.7.tar.gz
  # tar -zxvf libmcrypt-2.5.7.tar.gz
  # cd libmcrypt-2.5.7
  # ./configure prefix=/usr/local/libmcrypt/
  # make && make install
  ```

  5.配置Apache中的PHP环境
  修改Apache的配置文件httpd.conf
  在LoadModule中添加：
  ```
  LoadModule php5_module modules/libphp5.so
  ```
  在AddType application/x-gzip .gz .tgz下面添加：
  ```
  AddType application/x-httpd-php .php
  AddType application/x-httpd-php-source .phps
  ```

  在DirectoryIndex增加 index.php，以便Apache识别PHP格式的index
  ```
  <IfModule dir_module>  
    DirectoryIndex index.html index.php  
  </IfModule>
  ```

  6.验证PHP环境
  ```
  # vim /usr/local/apache/htdocs/info.php
  ```
  添加如下代码
  ```
  <?php

  phpinfo();

  ?>
  ```
  访问 http://locahost/info.php 可查看很多信息
