### SQLのメモを記載

- Mysqlにログイン(rootログインのパスワード付き)
```
mysql -u root -p
```

#### DB/Table操作のコマンド
- databaseを表示
```
mysql> show databases;
```
- tableを表示
```
mysql> show tables;
```

- databaseを作成
```
mysql> create database <name_DB>;
```

#### import_sample1.sqlを実行する
```
mysql> SOURCE /<file_path>/import_sample1.sql
```


