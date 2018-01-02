---
title: SpringBoot整合Mybatis时使用Druid数据库连接池
date: 2018-01-02 22:18:46
tags:
      - SpringBoot
categories: Spring      
---

#### 在SpringBoot项目中,增加如下依赖
```
    <!-- spring mybatis -->
		<dependency>
			<groupId>org.mybatis.spring.boot</groupId>
			<artifactId>mybatis-spring-boot-starter</artifactId>
			<version>1.1.1</version>
		</dependency>

		<!-- mysql -->
		<dependency>
			<groupId>mysql</groupId>
			<artifactId>mysql-connector-java</artifactId>
			<scope>runtime</scope>
		</dependency>

		<!-- druid数据库连接池 -->
		<dependency>
			<groupId>com.alibaba</groupId>
			<artifactId>druid</artifactId>
			<version>1.0.26</version>
		</dependency>
```

#### 在resource目录下,创建jdbc.properties配置文件,加入以下配置
```
#数据库配置
spring.datasource.url=jdbc:mysql://127.0.0.1:3306/test?useUnicode=true&characterEncoding=utf8&useSSL=false
spring.datasource.username=root
spring.datasource.password=root
spring.datasource.driver-class-name=com.mysql.jdbc.Driver
# 连接池配置
# 初始化大小，最小，最大
spring.datasource.initialSize=5  
spring.datasource.minIdle=5  
spring.datasource.maxActive=20  
# 配置获取连接等待超时的时间
spring.datasource.maxWait=60000  
# 配置间隔多久才进行一次检测，检测需要关闭的空闲连接，单位是毫秒
spring.datasource.timeBetweenEvictionRunsMillis=60000  
# 配置一个连接在池中最小生存的时间，单位是毫秒
spring.datasource.minEvictableIdleTimeMillis=300000
```

#### 创建数据源配置类DataSourceConfig.java,代码如下
```
package com.liao.mybatis;

import com.alibaba.druid.pool.DruidDataSource;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

import javax.sql.DataSource;

/**
 * 数据源
 *
 * @author hongyangliao
 * @ClassName: DataSourceConfig
 * @Date 18-1-2 下午8:56
 */
@Configuration
@MapperScan("com.liao.**.dao") //扫描映射接口
public class DataSourceConfig {

    @Autowired
    private JdbcConfig jdbcConfig;

    @Bean
    public DataSource dataSource() {
        DruidDataSource druidDataSource = new DruidDataSource();
        druidDataSource.setUrl(jdbcConfig.getUrl());
        druidDataSource.setUsername(jdbcConfig.getUserName());
        druidDataSource.setPassword(jdbcConfig.getPassword());
        druidDataSource.setInitialSize(jdbcConfig.getInitialSize());
        druidDataSource.setMinIdle(jdbcConfig.getMinIdle());
        druidDataSource.setMaxActive(jdbcConfig.getMaxActive());
        druidDataSource.setTimeBetweenEvictionRunsMillis(jdbcConfig.getTimeBetweenEvictionRunsMillis());
        druidDataSource.setMinEvictableIdleTimeMillis(jdbcConfig.getMinEvictableIdleTimeMillis());
        return druidDataSource;
    }


    /**
     * Jdbc配置类
     *
     * @author hongyangliao
     * @ClassName: JdbcConfig
     * @Date 18-1-2 下午9:00
     */
    @PropertySource(value = "classpath:jdbc.properties")
    @Component
    public static class JdbcConfig {
        /**
         * 数据库用户名
         */
        @Value("${spring.datasource.username}")
        private String userName;
        /**
         * 驱动名称
         */
        @Value("${spring.datasource.driver-class-name}")
        private String driverClass;
        /**
         * 数据库连接url
         */
        @Value("${spring.datasource.url}")
        private String url;
        /**
         * 数据库密码
         */
        @Value("${spring.datasource.password}")
        private String password;

        /**
         * 数据库连接池初始化大小
         */
        @Value("${spring.datasource.initialSize}")
        private int initialSize;

        /**
         * 数据库连接池最小最小连接数
         */
        @Value("${spring.datasource.minIdle}")
        private int minIdle;

        /**
         * 数据库连接池最大连接数
         */
        @Value("${spring.datasource.maxActive}")
        private int maxActive;

        /**
         * 获取连接等待超时的时间
         */
        @Value("${spring.datasource.maxWait}")
        private long maxWait;

        /**
         * 多久检测一次
         */
        @Value("${spring.datasource.timeBetweenEvictionRunsMillis}")
        private long timeBetweenEvictionRunsMillis;

        /**
         * 连接在池中最小生存的时间
         */
        @Value("${spring.datasource.minEvictableIdleTimeMillis}")
        private long minEvictableIdleTimeMillis;

        public String getUserName() {
            return userName;
        }

        public void setUserName(String userName) {
            this.userName = userName;
        }

        public String getDriverClass() {
            return driverClass;
        }

        public void setDriverClass(String driverClass) {
            this.driverClass = driverClass;
        }

        public String getUrl() {
            return url;
        }

        public void setUrl(String url) {
            this.url = url;
        }

        public String getPassword() {
            return password;
        }

        public void setPassword(String password) {
            this.password = password;
        }

        public int getInitialSize() {
            return initialSize;
        }

        public void setInitialSize(int initialSize) {
            this.initialSize = initialSize;
        }

        public int getMinIdle() {
            return minIdle;
        }

        public void setMinIdle(int minIdle) {
            this.minIdle = minIdle;
        }

        public int getMaxActive() {
            return maxActive;
        }

        public void setMaxActive(int maxActive) {
            this.maxActive = maxActive;
        }

        public long getMaxWait() {
            return maxWait;
        }

        public void setMaxWait(long maxWait) {
            this.maxWait = maxWait;
        }

        public long getTimeBetweenEvictionRunsMillis() {
            return timeBetweenEvictionRunsMillis;
        }

        public void setTimeBetweenEvictionRunsMillis(long timeBetweenEvictionRunsMillis) {
            this.timeBetweenEvictionRunsMillis = timeBetweenEvictionRunsMillis;
        }

        public long getMinEvictableIdleTimeMillis() {
            return minEvictableIdleTimeMillis;
        }

        public void setMinEvictableIdleTimeMillis(long minEvictableIdleTimeMillis) {
            this.minEvictableIdleTimeMillis = minEvictableIdleTimeMillis;
        }
    }
}
```

#### 创建Session工厂配置类SessionFactoryConfig.java,代码如下
```
package com.liao.mybatis;

import java.io.IOException;

import javax.sql.DataSource;

import org.mybatis.spring.SqlSessionFactoryBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@EnableTransactionManagement // 启注解事务管理，等同于xml配置方式的 <tx:annotation-driven />
public class SessionFactoryConfig {

    /**
     * mybatis 配置路径
     */
    private static String MYBATIS_CONFIG = "mybatis-config.xml";

    @Autowired
    private DataSource dataSource;


    /**
     * 创建sqlSessionFactoryBean 实例
     * 并且设置configtion 如驼峰命名.等等
     * 设置mapper 映射路径
     * 设置datasource数据源
     *
     * @return
     */
    @Bean(name = "sqlSessionFactory")
    public SqlSessionFactoryBean createSqlSessionFactoryBean() throws IOException {
        SqlSessionFactoryBean sqlSessionFactory = new SqlSessionFactoryBean();
        /** 设置mybatis configuration 扫描路径 */
        sqlSessionFactory.setConfigLocation(new ClassPathResource(MYBATIS_CONFIG));
        /** 设置datasource */
        sqlSessionFactory.setDataSource(dataSource);
        return sqlSessionFactory;
    }
}
```
