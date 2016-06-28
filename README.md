![Alt Text](https://github.com/yhidetoshi/Pictures/raw/master/SQL_Study_Basic/sqi-icon.jpeg)

## MySQLメモ

-> https://github.com/yhidetoshi/SQL_Study_Basic/blob/master/MySQL/README.md#コンンパイルせずにmysqlをインストールするcentos65vagrant


## SQLの勉強メモ

### 項目
#### Section1 (テーブルの構成/SQL文/テーブル操作/テーブル登録)

→ https://github.com/yhidetoshi/sql_memo/blob/master/Section1.md

#### Section2 (SELECT文/Where句/算術演算子/比較演算子/論理演算子/真理値)

→ https://github.com/yhidetoshi/sql_study/blob/master/Section2.md

#### Section3 (集約関数/行数カウント/合計/平均/最大/最小/GROUP/HAVING/ORDER BY)

→ https://github.com/yhidetoshi/sql_study/blob/master/Section3.md

#### Section4 (INSERT/DELETE/UPDATE/トランザクション)

→ https://github.com/yhidetoshi/sql_study/blob/master/Section4.md

#### Section5 (ビューとテーブル/サブクエリ/相関サブクエリ)

→ https://github.com/yhidetoshi/sql_study/blob/master/Section5.md

#### Section6 (様々な関数/述語(LIKE,BETWEEN,IS NULL,EXIST)/CASE式)

→ https://github.com/yhidetoshi/sql_study/blob/master/Section6.md


#### Section7 (集合演算(UNION, INTERSECT, EXCEPT)/結合(INER JOIN, OUTER JOIN, CROSS JOIN)/CASE式)

→ https://github.com/yhidetoshi/sql_study/blob/master/Section7.md


#### Section8 (Window関数/GROUPING演算子)

→ https://github.com/yhidetoshi/sql_study/blob/master/Section8.md

### その他

#### MySQLコマンドメモ
- Mysqlにrootログイン
```
mysql -u root -p
```
- .sqlを実行 
```
mysql> SOURCE /<file_path>/<file_name>.sql
```

![Alt Text](https://github.com/yhidetoshi/Pictures/raw/master/SQL_Study_Basic/postgres-image.png)

#### Postgresqlのインストール
- 環境
  - CentOS6.7
  - postgresql

**[インストール]**
```
# yum -y install postgresql-server
# /etc/rc.d/init.d/postgresql initdb

# vi /var/lib/pgsql/data/postgresql.conf

# 59行目：コメント解除して変更 [他ホストからのアクセスも受け付ける]
listen_addresses = '*'

# 334行目：コメント解除して変更 ( ログの形式を [日時 ユーザー DB ～])
log_line_prefix = '%t %u %d '

# service postgresql start
```

**[初期設定]**
```
[postgres ユーザーにスイッチしてパスワード設定]

$ psql -c "alter user postgres with password 'password'" 
ALTER ROLE

[DBユーザー「cent」を新規登録]
-bash-4.1$ createuser cent 
Shall the new role be a superuser? (y/n) y 

postgresにログイン
# su - postgres
# psql -d postgres
```

**[DBを作る]**
```
postgres=# CREATE DATABASE hoge;
CREATE DATABASE
```

**[ユーザを作る]**
```
postgres=# CREATE USER testuser;
CREATE ROLE
```

**[指定したユーザにパスワードを設定する]**
```
postgres=# \password testuser
Enter new password:
Enter it again:
```

**[データベースの一覧]**
```
postgres-# \l

                                  List of databases
   Name    |  Owner   | Encoding |  Collation  |    Ctype    |   Access privileges
-----------+----------+----------+-------------+-------------+-----------------------
 hoge      | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 postgres  | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 template0 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres
                                                             : postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres
                                                             : postgres=CTc/postgres
```

**[ユーザ一覧確認]**
```
postgres-# \du

            List of roles
 Role name | Attributes  | Member of
-----------+-------------+-----------
 cent      | Superuser   | {}
           : Create role
           : Create DB
 postgres  | Superuser   | {}
           : Create role
           : Create DB
 testuser  |             | {}
```

**[メタコマンドの一覧]**
```
postgres-# \?
```
- その他のコマンド一覧の参照

http://ossfan.net/manage/postgresql-05.html
