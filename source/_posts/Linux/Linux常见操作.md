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
    ````
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

    3.下载mysql
    ```
    # wget https://dev.mysql.com/get/Downloads/MySQL-5.6/MySQL-5.6.37-1.el7.x86_64.rpm-bundle.tar

    ```

    4.解压文件
    ```
    # tar -xvf MySQL-5.6.37-1.el7.x86_64.rpm-bundle.tar
    ```

    5.安装mysql服务
    ```
    # rpm -ivh MySQL-5.6.37-1.el7.x86_64.rpm
    ```
    如报错，请执行如下操作
    ```
    #因为要先安装依赖：
    # yum -y install libaio.so.1 libgcc_s.so.1 libstdc++.so.6
    #需要升级 这个 libstdc++-4.4.7-4.el6.x86_64
    # yum  update libstdc++-4.4.7-4.el6.x86_64
    ```
