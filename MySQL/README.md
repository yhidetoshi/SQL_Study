### コンンパイルせずにMySQLをインストールする(CentOS6.5@Vagrant)

- 環境
  - Vagrant
  - Centos6.5
  - MySQLのダウンロード：http://dev.mysql.com/downloads/mysql/
![Alt Text](https://github.com/yhidetoshi/Pictures/raw/master/SQL_Study_Basic/mysql-glibc-0.png)
![Alt Text](https://github.com/yhidetoshi/Pictures/raw/master/SQL_Study_Basic/mysql-glibc-1.png)
![Alt Text](https://github.com/yhidetoshi/Pictures/raw/master/SQL_Study_Basic/mysql-glibc-2.png)

**[Mysqlをダウンロードしてインストール]**
```
# cd /usr/local/src
# wget http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.16-linux-glibc2.5-x86_64.tar.gz
# tar xvzf mysql-5.6.16-linux-glibc2.5-x86_64.tar.gz
# ln -s /usr/local/src/mysql-5.6.16-linux-glibc2.5-x86_64 mysq
# groupadd mysql
# useradd -r -g mysql mysql
# chown -R mysql .
# chgrp -R mysql .
# /usr/local/mysql/scripts/mysql_install_db --user=mysql --basedir=/usr/local/mysql/ --datadir=/usr/local/mysql/
```

**[起動]**
```
# bin/mysqld_safe –user=mysql &

→ 下のようにエラーが出る。
---
[1] 3046
[root@node2 mysql]# 160625 04:25:50 mysqld_safe Logging to '/var/log/mysqld.log'.
160625 04:25:50 mysqld_safe Starting mysqld daemon with databases from /var/lib/mysql
160625 04:25:53 mysqld_safe mysqld from pid file /var/run/mysqld/mysqld.pid ended
---
```

**[まず実行環境を整える]**
```
/etc/init.d/mysql startをできるようにする.
# cp -pr /usr/local/mysql/support-files/mysql.server /etc/init.d/mysql
```

**[改めてエラーログを調べる]**
```
# /etc/init.d/mysql start

/var/log/mysqld.log
---
[ERROR] Can't open the mysql.plugin table. Please run mysql_upgrade to create it.
---
```
**[エラーの対策]**
```
/etc/my.cnfに下記の2行を追加する
---
character-set-server=utf8
skip-grant-tables
---


- 起動後に`mysql_upgrade`をする。 
- mysql_upgradeはOSのmysqlユーザで実行する
- 最後まで通ったらservice mysqld stop
- skip-grant-tablesの記述を削除。
```

**[起動を確認]**
```
# /etc/init.d/mysql start

Starting MySQL. SUCCESS!
[root@node2 ~]# ps -ef | grep mysql
root      3502  3260  0 04:31 pts/1    00:00:00 tail -f mysqld.log
root      3512     1  0 04:31 pts/0    00:00:00 /bin/sh /usr/local/mysql/bin/mysqld_safe --datadir=/var/lib/mysql --pid-file=/var/lib/mysql/node2.pid
mysql     3714  3512  0 04:31 pts/0    00:00:00 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/var/lib/mysql --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=/var/log/mysqld.log --pid-file=/var/lib/mysql/node2.pid --socket=/var/lib/mysql/mysql.sock
```

**[MySQLに接続する]**
```
# /usr/local/mysql/bin/mysql -u root

ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/tmp/mysql.sock' (2)
```

**[errorの対処]**
```
/etc/my.cnfを変更

#socket=/var/lib/mysql/mysql.sock
socket=/tmp/mysql.sock
```
**[再度接続]**
```
# /usr/local/mysql/bin/mysql -u root
mysql>

無事にログインできた
```



#### Mysqlのバージョンを上げる

`(前)mysql-5.6.16-linux-glibc2.5-x86_64`

`(後)MySQL-5.6.31-1.el6.x86_64`

- mysqldumpでバックアップをとる
  - # /usr/local/mysql/bin/mysqldump -u root -x --all-databases > /root/dump.sql 


