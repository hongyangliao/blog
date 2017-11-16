---
title: tomcat设置自启
date: 2017-11-16 11:10:06
tags:
      -Tomcat
categories: Tomcat    
---
#### 新建tomcat文件,将以下命令添加到文件中,并添加执行权限
```
#!/bin/bash
#
# /etc/rc.d/init.d/tomcat
# init script for tomcat precesses
#
# processname: tomcat
# description: tomcat is a j2ee server
# chkconfig: 2345 86 16
# description:  Start up the Tomcat servlet engine.

if [ -f /etc/init.d/functions ]; then
        . /etc/init.d/functions
elif [ -f /etc/rc.d/init.d/functions ]; then
        . /etc/rc.d/init.d/functions
else
        echo -e "\atomcat: unable to locate functions lib. Cannot continue."
        exit -1
fi

RETVAL=$?
CATALINA_HOME="/home/tomcat"

case "$1" in
start)
        if [ -f $CATALINA_HOME/bin/startup.sh ];
          then
            echo $"Starting Tomcat"
            $CATALINA_HOME/bin/startup.sh
        fi  
        ;;
stop)
        if [ -f $CATALINA_HOME/bin/shutdown.sh ];
          then
            echo $"Stopping Tomcat"
            $CATALINA_HOME/bin/shutdown.sh
        fi
        ;;
*)
        echo $"Usage: $0 {start|stop}"
        exit 1
        ;;
esac

exit $RETVAL
```

#### 将:tomcat文件拷贝到/etc/init.d/下，并运行：chkconfig --add tomcat
