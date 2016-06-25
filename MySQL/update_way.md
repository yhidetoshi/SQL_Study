#### 検証 MySQL5.6から　にアップデート

- コンンパイルせずにMySQLのインストール
  - http://altarf.net/computer/server_tips/2418 

```
# pwd
/usr/local/src

# yum -y install gcc-c++
wget http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.16-linux-glibc2.5-x86_64.tar.gz

# groupadd mysql
# useradd -r -g mysql mysql
# cd /usr/local
# ln -s /usr/local/src/mysql-5.6.16-linux-glibc2.5-x86_64 mysql
# cd mysql
# chown -R mysql .
# chgrp -R mysql .
# scripts/mysql_install_db –user=mysql
# chown -R root .
# chown -R mysql data
# bin/mysqld_safe –user=mysql &
```

- 実行時のエラー
```
# 160625 03:36:02 mysqld_safe Logging to '/var/log/mysqld.log'.
160625 03:36:02 mysqld_safe Starting mysqld daemon with databases from /var/lib/mysql
160625 03:36:04 mysqld_safe mysqld from pid file /var/run/mysqld/mysqld.pid ended
```

[実行環境を整える]
```
/etc/init.d/mysql startをできるようにする
# cp -pr /usr/local/mysql/support-files/mysql.server /etc/init.d/mysql
# vi/etc/init.d/mysql
---
basedir=/usr/local/mysql
datadir=/usr/local/mysql/data
---
```

[/etc/my.cnf]
```
[mysqld]
character-set-server=utf8
skip-grant-tables
skip-federated
datadir=/usr/local/mysql
socket=/var/lib/mysql/mysql.sock
user=mysql
# Disabling symbolic-links is recommended to prevent assorted security risks
symbolic-links=0

[mysqld_safe]
log-error=/var/log/mysqld.log
pid-file=/var/run/mysqld/mysqld.pid
を記述
```
