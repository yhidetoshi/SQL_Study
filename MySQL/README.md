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


#### Mysqlのバージョンを上げる(5.6.28から5.6.31へアップデート)

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

- インストール
# /usr/local/mysql/scripts/mysql_install_db --user=mysql --basedir=/usr/local/mysql/ --datadir=/var/lib/mysql

perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
	LANGUAGE = (unset),
	LC_ALL = (unset),
	LANG = "ja_JP.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
Installing MySQL system tables...2016-06-27 14:49:09 0 [Warning] TIMESTAMP with implicit DEFAULT value is deprecated. Please use --explicit_defaults_for_timestamp server option (see documentation for more details).
2016-06-27 14:49:09 0 [Note] /usr/local/mysql//bin/mysqld (mysqld 5.6.31) starting as process 10461 ...
2016-06-27 14:49:09 10461 [Note] InnoDB: Using atomics to ref count buffer pool pages
2016-06-27 14:49:09 10461 [Note] InnoDB: The InnoDB memory heap is disabled
2016-06-27 14:49:09 10461 [Note] InnoDB: Mutexes and rw_locks use GCC atomic builtins
2016-06-27 14:49:09 10461 [Note] InnoDB: Memory barrier is not used
2016-06-27 14:49:09 10461 [Note] InnoDB: Compressed tables use zlib 1.2.3
2016-06-27 14:49:09 10461 [Note] InnoDB: Using Linux native AIO
2016-06-27 14:49:09 10461 [Note] InnoDB: Using CPU crc32 instructions
2016-06-27 14:49:09 10461 [Note] InnoDB: Initializing buffer pool, size = 128.0M
2016-06-27 14:49:09 10461 [Note] InnoDB: Completed initialization of buffer pool
2016-06-27 14:49:09 10461 [Note] InnoDB: Highest supported file format is Barracuda.
2016-06-27 14:49:09 10461 [Note] InnoDB: 128 rollback segment(s) are active.
2016-06-27 14:49:09 10461 [Note] InnoDB: Waiting for purge to start
2016-06-27 14:49:09 10461 [Note] InnoDB: 5.6.31 started; log sequence number 1630068
2016-06-27 14:49:09 10461 [Note] Binlog end
2016-06-27 14:49:09 10461 [Note] InnoDB: FTS optimize thread exiting.
2016-06-27 14:49:09 10461 [Note] InnoDB: Starting shutdown...
2016-06-27 14:49:11 10461 [Note] InnoDB: Shutdown completed; log sequence number 1630078
OK

Filling help tables...2016-06-27 14:49:11 0 [Warning] TIMESTAMP with implicit DEFAULT value is deprecated. Please use --explicit_defaults_for_timestamp server option (see documentation for more details).
2016-06-27 14:49:11 0 [Note] /usr/local/mysql//bin/mysqld (mysqld 5.6.31) starting as process 10484 ...
2016-06-27 14:49:11 10484 [Note] InnoDB: Using atomics to ref count buffer pool pages
2016-06-27 14:49:11 10484 [Note] InnoDB: The InnoDB memory heap is disabled
2016-06-27 14:49:11 10484 [Note] InnoDB: Mutexes and rw_locks use GCC atomic builtins
2016-06-27 14:49:11 10484 [Note] InnoDB: Memory barrier is not used
2016-06-27 14:49:11 10484 [Note] InnoDB: Compressed tables use zlib 1.2.3
2016-06-27 14:49:11 10484 [Note] InnoDB: Using Linux native AIO
2016-06-27 14:49:11 10484 [Note] InnoDB: Using CPU crc32 instructions
2016-06-27 14:49:11 10484 [Note] InnoDB: Initializing buffer pool, size = 128.0M
2016-06-27 14:49:11 10484 [Note] InnoDB: Completed initialization of buffer pool
2016-06-27 14:49:11 10484 [Note] InnoDB: Highest supported file format is Barracuda.
2016-06-27 14:49:11 10484 [Note] InnoDB: 128 rollback segment(s) are active.
2016-06-27 14:49:11 10484 [Note] InnoDB: Waiting for purge to start
2016-06-27 14:49:11 10484 [Note] InnoDB: 5.6.31 started; log sequence number 1630078
2016-06-27 14:49:11 10484 [Note] Binlog end
2016-06-27 14:49:11 10484 [Note] InnoDB: FTS optimize thread exiting.
2016-06-27 14:49:11 10484 [Note] InnoDB: Starting shutdown...
2016-06-27 14:49:13 10484 [Note] InnoDB: Shutdown completed; log sequence number 1630088
OK

To start mysqld at boot time you have to copy
support-files/mysql.server to the right place for your system

PLEASE REMEMBER TO SET A PASSWORD FOR THE MySQL root USER !
To do so, start the server, then issue the following commands:

  /usr/local/mysql//bin/mysqladmin -u root password 'new-password'
  /usr/local/mysql//bin/mysqladmin -u root -h node2 password 'new-password'

Alternatively you can run:

  /usr/local/mysql//bin/mysql_secure_installation

which will also give you the option of removing the test
databases and anonymous user created by default.  This is
strongly recommended for production servers.

See the manual for more instructions.

You can start the MySQL daemon with:

  cd . ; /usr/local/mysql//bin/mysqld_safe &

You can test the MySQL daemon with mysql-test-run.pl

  cd mysql-test ; perl mysql-test-run.pl

Please report any problems at http://bugs.mysql.com/

The latest information about MySQL is available on the web at

  http://www.mysql.com

Support MySQL by buying support/licenses at http://shop.mysql.com

WARNING: Found existing config file /usr/local/mysql//my.cnf on the system.
Because this file might be in use, it was not replaced,
but was used in bootstrap (unless you used --defaults-file)
and when you later start the server.
The new default config file was created as /usr/local/mysql//my-new.cnf,
please compare it with your file and take the changes you need.

WARNING: Default config file /etc/my.cnf exists on the system
This file will be read by default by the MySQL server
If you do not want to use this, either remove it, or use the
--defaults-file argument to mysqld_safe when starting the server

```

- /etc/my.cnfを確認
```
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
