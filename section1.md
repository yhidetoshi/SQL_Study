### SQL(Structured Query Language)のメモを記載

#### Rules
- RDBでは行単位でデータを読み書きする
- 1つのセルの中には1つのデータしか入らない
- SQL文の最後は[;]で終わる
- Keywordの大文字/小文字は区別されない
  - (ex)SELECT/selectは同義
-　文字列と日付の定数はシングルクォーテーション(')で囲む
-　定数の数字は(')で囲まない
-　単語と単語の間は半角スペースまたは改行で区切る
-


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

- Tableを削除
```
drop tables <table_name>;
```
　
