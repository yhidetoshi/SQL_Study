### コンンパイルせずにMySQLをインストールする(CentOS6.5@Vagrant)

- 環境
  - Vagrant
  - Centos6.5
  - MySQLのバージョン
    - mysql-5.6.16
    - mysql-5-6-28
    - mysql-5.6.31
  - MySQLのダウンロード：http://dev.mysql.com/downloads/mysql/
![Alt Text](https://github.com/yhidetoshi/Pictures/raw/master/SQL_Study_Basic/mysql-glibc-0.png)
![Alt Text](https://github.com/yhidetoshi/Pictures/raw/master/SQL_Study_Basic/mysql-glibc-1.png)
![Alt Text](https://github.com/yhidetoshi/Pictures/raw/master/SQL_Study_Basic/mysql-glibc-2.png)

**[Mysqlをダウンロードしてインストール]**
```
# cd /usr/local/src
---選択---
# wget http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.16-linux-glibc2.5-x86_64.tar.gz
# wget http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.28-linux-glibc2.5-x86_64.tar.gz
# wget http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.31-linux-glibc2.5-x86_64.tar.gz
-----------

# tar xvzf mysql-5.6.16-linux-glibc2.5-x86_64.tar.gz
# ln -s /usr/local/src/mysql-5.6.16-linux-glibc2.5-x86_64 /usr/local/mysql
# groupadd mysql
# useradd -r -g mysql mysql
# chown -R mysql .
# chgrp -R mysql .
# /usr/local/mysql/scripts/mysql_install_db --user=mysql --basedir=/usr/local/mysql/ --datadir=/var/lib/mysql
```

**[まず実行環境を整える]**
```
/etc/init.d/mysql startをできるようにする.
# cp -pr /usr/local/mysql/support-files/mysql.server /etc/init.d/mysql
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

**[rootパスワードを忘れた時の対処方法]**
```
/etc/my.cnfに下記の1行を追加する
---
skip-grant-tables
---

これを追加して、mysqlを起動し、`mysql -u root`でログインできるようになる。
```

- アップデートの前にいくつかダミーデータを登録
```
mysql> select User,Host from mysql.user;
+-------+-----------+
| User  | Host      |
+-------+-----------+
| hoge1 | %         |
| hoge2 | %         |
| root  | 127.0.0.1 |
| root  | ::1       |
|       | localhost |
| root  | localhost |
|       | node2     |
| root  | node2     |
+-------+-----------+
8 rows in set (0.00 sec)


mysql> SHOW TABLES FROM hogehoge;
+--------------------+
| Tables_in_hogehoge |
+--------------------+
| personal           |
+--------------------+
1 row in set (0.01 sec)
```
- /etc/my.cnfが変化するか確認するために`#hogehoge`を入れておいた。
```
]# cat /etc/my.cnf
[mysqld]
datadir=/var/lib/mysql
socket=/var/lib/mysql/mysql.sock
user=mysql
# Disabling symbolic-links is recommended to prevent assorted security risks
symbolic-links=0
socket=/tmp/mysql.sock
#hogehoge
[mysqld_safe]
log-error=/var/log/mysqld.log
pid-file=/var/run/mysqld/mysqld.pid
```


## Mysqlのバージョンを上げる(5.6.28から5.6.31へアップデート)

- 新しいバージョンにするにはシンボリックリンクの向け先を変えてMysqlを再起動する

`(前)mysql-5.6.16-linux-glibc2.5-x86_64`

`(後)MySQL-5.6.31-1.el6.x86_64`

- mysqldumpでバックアップをとる
  - # /usr/local/mysql/bin/mysqldump -u root -x --all-databases > /root/dump.sql 

```
- アップデート版をダウンロード
# cd /usr/local/src
# wget http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.31-linux-glibc2.5-x86_64.tar.gz

- シンボリックリンクを削除
# unlink mysql

- 新しいバージョンの中身をシンボリックリンクをはる
# ln -s /usr/local/src/mysql-5.6.31-linux-glibc2.5-x86_64 /usr/local/mysql

```

- 動作確認
```
# /etc/init.d/mysql start
Starting MySQL. SUCCESS!

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| hogehoge           |
| mysql              |
| performance_schema |
| test               |
+--------------------+
5 rows in set (0.01 sec)

mysql> select User,Host from mysql.user;
+-------+-----------+
| User  | Host      |
+-------+-----------+
| hoge1 | %         |
| hoge2 | %         |
| root  | 127.0.0.1 |
| root  | ::1       |
|       | localhost |
| root  | localhost |
|       | node2     |
| root  | node2     |
+-------+-----------+
8 rows in set (0.00 sec)

mysql> SHOW TABLES FROM hogehoge;
+--------------------+
| Tables_in_hogehoge |
+--------------------+
| personal           |
+--------------------+
1 row in set (0.00 sec)
```

-> `/var/lib/mysql`配下も変化なし

```
- プロセス確認
# ps -ef | grep mysql
root     10544 10531  0 14:51 pts/0    00:00:00 tail -f mysqld.log
root     10800     1  0 14:53 pts/1    00:00:00 /bin/sh /usr/local/mysql/bin/mysqld_safe --datadir=/var/lib/mysql --pid-file=/var/lib/mysql/node2.pid
mysql    10988 10800  1 14:53 pts/1    00:00:00 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/var/lib/mysql --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=/var/log/mysqld.log --pid-file=/var/lib/mysql/node2.pid --socket=/tmp/mysql.sock
root     11012 10412  0 14:54 pts/1    00:00:00 grep mysql
```

#### Mysqlを5.6.28から5.6.31へアップデートできた。

#####別の方法で試してみる。
tar xvzf mysql-5.6.16-linux-glibc2.5-x86_64.tar.gz
→ 解凍したら/etc/my.cnfが生成された

後でちゃんとまとめます。
```
# /etc/init.d/mysql start
Starting MySQL. SUCCESS!


2016-07-07 15:59:04 3820 [Note] /usr/local/mysql/bin/mysqld: ready for connections.
Version: '5.6.16'  socket: '/var/lib/mysql/mysql.sock'  port: 3306  MySQL Community Server (GPL)


# /etc/init.d/mysql start
Starting MySQL. SUCCESS!


2016-07-07 16:20:02 10164 [Note] /usr/local/mysql/bin/mysqld: ready for connections.
Version: '5.6.31'  socket: '/var/lib/mysql/mysql.sock'  port: 3306  MySQL Community Server (GPL)
```

### MySQLのレプリケーション

![Alt Text](https://github.com/yhidetoshi/Pictures/raw/master/SQL_Study_Basic/mysql_rep_icon.png)![Alt Text](https://github.com/yhidetoshi/Pictures/raw/master/SQL_Study_Basic/mysql-rep.png)
![Alt Text](https://github.com/yhidetoshi/Pictures/raw/master/SQL_Study_Basic/mysql-rep3.png)

**[検証環境]**
```
Vagrant(CentOS6.7)@Mac_Local

[Master: 192.168.1.21] <-----> [Slave: 192.168.33.11]
```


**[Master側の設定]**
- スレーブ側からマスターに接続できる必要がある
```
# CREATE USER repl;
# GRANT REPLICATION SLAVE ON *.* TO 'repl'@'192.168.33./255.255.255.0' IDENTIFIED BY 'password';

# vim /etc/my.cnf
[mysqld]
log-bin=/var/log/mysql/master-bin
log-bin-index = /var/log/mysql/master-bin
server-id=1001
```

**[マスター側でFileとPositionを確認]**

`mysql> show master status\G;`
```
+------------------+----------+--------------+------------------+-------------------+
| File             | Position | Binlog_Do_DB | Binlog_Ignore_DB | Executed_Gtid_Set |
+------------------+----------+--------------+------------------+-------------------+
| mysql-bin.000003 |     1010 |              |                  |                   |
+------------------+----------+--------------+------------------+-------------------+
```

**[Slaveの設定]**
```
[mysqld]
log-bin=/var/log/mysql/master-bin
log-bin-index = /var/log/mysql/master-bi
server-id=1002

#mysql再起動

(*) マスターで確認したFileとPostionを入れる
mysql>
CHANGE MASTER TO
MASTER_HOST='192.168.1.21',
MASTER_USER='repl',
MASTER_PASSWORD='password',
MASTER_LOG_FILE='mysql-bin.000003',
MASTER_LOG_POS=1010;

mysql> START SLAVE;
```

**[Slaveの状態確認]**
`mysql> SHOW SLAVE STATUS\G`
```
*************************** 1. row ***************************
        <-----  省略   ------->                 
             Slave_IO_Running: Connecting
             Slave_SQL_Running: Yes
        <-----  省略   ------->
```

[下記2つのパラメータが2つとも Yes になっている必要がある]
```
Slave_IO_Running: Connecting
Slave_SQL_Running: Yes
```
