### テーブルの構成/SQL文/テーブル操作/テーブル登録

#### Rules
- RDBでは行単位でデータを読み書きする
- 1つのセルの中には1つのデータしか入らない
- SQL文の最後は[;]で終わる
- Keywordの大文字/小文字は区別されない
  - (ex)SELECT/selectは同義
- 文字列と日付の定数はシングルクォーテーション(')で囲む
- 定数の数字は(')で囲まない
- 単語と単語の間は半角スペースまたは改行で区切る
- 削除したテーブルは元に戻せない  

#### KEYWORD
- 列
  -  カラム
- 行
  - レコード
- セル
  - 1つのセルの中には1つのデータしか入らない
- SQL (Structured Query Language)
  - リレーショナルデータベースを操作するための言語  
- INTEGER
  - 数値
- CHAR
  - 固定長文字列(最大長に満たない場合は最大長になるまで半角スペースで埋める) 
- VARCHAR
  - 可変長文字列(最大長に満たなくても半角スペースで産めない) 
- DATE
  - 日付を入れる列を指定する
-　制約
  - NULL, NOT NULL
  - 主キー(PRIMARY KEY)

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

- Tableを削除[DROP]
```
mysql> drop tables <table_name>;
```

- テーブル名を変更(Oracle PostgreSQL)
```
mysql> ALTER TABLE <変更前のTable_name> RENAME TO <変更後のTable_name>
```

- テーブル名を変更(MySQL)
```
mysql> RENAME TABLE <変更前のTable_name> RENAME to <変更後のTable_name>
```


- 列を追加[ALTER TABLE] (テーブルを削除して再作成ではなく直接追加する)
```
mysql> ALTER TABLE <テーブル名> ADD COLUMN <列の定義>;
→ (ex) ALTER TABLE Shohin ADD COLUMN shohin_name_kana VARCHAR(100);
```
- 列を削除[ALTER TABLE] (テーブルを削除して再作成ではなく直接削除する)
```
mysql> ALTER TABLE <テーブル名> DROP COLUMN <列名>;
→ (ex) ALTER TABLE Shohin DROP COLUMN shohin_name_kana;
```



#### DML(Data Manipulation Language )
→ データベースを管理・操作するための言語の一種
MySQLでは
```
BEGIN TRANSACTION;

  SQL実行文を記述

COMMIT;
```
