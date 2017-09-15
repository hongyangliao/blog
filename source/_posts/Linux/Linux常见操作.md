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
  # Manual customization of this file is not recommended.
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
:RH-Firewall-1-INPUT - [0:0]
-A INPUT -j RH-Firewall-1-INPUT
-A FORWARD -j RH-Firewall-1-INPUT
-A RH-Firewall-1-INPUT -i lo -j ACCEPT
-A RH-Firewall-1-INPUT -p icmp –icmp-type any -j ACCEPT
-A RH-Firewall-1-INPUT -p 50 -j ACCEPT
-A RH-Firewall-1-INPUT -p 51 -j ACCEPT
-A RH-Firewall-1-INPUT -m state –state ESTABLISHED,RELATED -j ACCEPT
-A RH-Firewall-1-INPUT -m state –state NEW -m tcp -p tcp –dport 53 -j ACCEPT
-A RH-Firewall-1-INPUT -m state –state NEW -m udp -p udp –dport 53 -j ACCEPT
-A RH-Firewall-1-INPUT -m state –state NEW -m tcp -p tcp –dport 22 -j ACCEPT
-A RH-Firewall-1-INPUT -m state –state NEW -m tcp -p tcp –dport 10022 -j ACCEPT
-A RH-Firewall-1-INPUT -m state –state NEW -m tcp -p tcp –dport 25 -j ACCEPT
-A RH-Firewall-1-INPUT -m state –state NEW -m tcp -p tcp –dport 80 -j ACCEPT
-A RH-Firewall-1-INPUT -m state –state NEW -m tcp -p tcp –dport 443 -j ACCEPT
-A RH-Firewall-1-INPUT -j REJECT –reject-with icmp-host-prohibited
COMMIT
  ```
  2.保存，service iptables save

  3.重启，service iptables restart

  4.添加到自启动，chkconfig iptables on

#### 修改镜像为阿里
  ```
  # cd /etc/yum.repos.d && mv CentOS-Base.repo CentOS-Base.repo.bak
  # wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-6.repo
  # yum makecache
  # yum clean all
  ```

#### 安装wget
  ```
  # yum -y install wget
  ```

#### 安装zip
  ```
  # yum -y install unzip zip
  ```

#### 安装vim
  ```
  # yum -y install vim
  ```

#### 安装相关依赖
  ```
  # yum -y install gcc-c++ tcl gettext-devel pcre-devel openssl openssl-devel bison flexcurl-devel expat-devel zlib-devel autoconf automake libtool python ncurses-devellibjpeg-devel e2fsprogs-devel sqlite-devel libcurl-devel speex-devel ldns-devel libeditdevelreadline-devel ncurses-devel pam-develnumactl
  ```
#### 安装时间同步工具
  1.安装ntpdate
  ```
  # yum -y install ntpdate
  ```

  2.设置定时任务（每一个小时执行一次）
  ```
  # echo '0 1 * * * ntpdate cn.pool.ntp.org;hwclock -w' >> /var/spool/cron/root
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

#### 安装Tomcat
  1.下载tomcat
  ```
  # wget http://mirror.bit.edu.cn/apache/tomcat/tomcat-7/v7.0.81/bin/apache-tomcat-7.0.81.tar.gz
  ```

  2.解压并移动到/usr/local目录
  ```
  # tar -zxvf  apache-tomcat-7.0.81.tar.gz
  # mv apache-tomcat-7.0.81 /usr/local/tomcat7
  ```

  3.修改admin登录密码

####  安装mysql
  1.检查原先是否装有mysql
  ```
  # rpm -qa | grep mysql
  ```

  2.如果有将其卸载
  ```
  # rpm -e --nodeps mysql-5.1.73-8.el6_8.x86_64
  ```

  3.下载mysql源
  ```
  # wget http://repo.mysql.com/mysql-community-release-el6-5.noarch.rpm
  ```

  4.安装mysql源
  ```
  # rpm-ivh mysql-community-release-el6-5.noarch.rpm
  ```

  5.执行mysql安全配置向导
  ```
  # mysql_secure_installation
  ```
  会执行以下设置
  a)为root用户设置密码
  b)删除匿名账号
  c)取消root用户远程登录
  d)删除test库和对test库的访问权限
  e)刷新授权表使修改生效

  6.添加mysql服务开机自启
  ```
  # vi /etc/rc.d/rc.local
  ```
  添加如下内容
  ```
  # start mysql server
  /usr/local/mysql/bin/mysqld start
  ```

#### 安装Maven
  1.下载Maven
  ```
  # wget http://ovg7i1lse.bkt.clouddn.com/apache-maven-3.2.5-bin.tar.gz
  ```

  2.解压并移动至/usr/local
  ```
  # tar -zxvf apache-maven-3.2.5-bin.tar.gz
  # mv apache-maven-3.2.5 /usr/local/maven3.2.5
  ```

  3.设置环境变量
  ```
  # echo 'M2_HOME=/usr/local/maven3.2.5' >> /etc/profile
  # echo 'export PATH=$M2_HOME/bin:$PATH' >> /etc/profile
  ```
  使文件生效
  ```
  # source /etc/profile
  ```

  4.打印Java系统属性核环境变量
  ```
  #  mvn help:system
  ```

  5.移动配置文件到本地仓库同级目录
  ```
  # cp /usr/local/maven3.2.5/conf/settings.xml /root/.m2
  ```

  6.修改setting.xml，将源换为阿里的

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
