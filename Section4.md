### INSERT/DELETE/UPDATE/トランザクション

#### Rules
- 原則としてINSERT文は1回の実行で1行を挿入する
- VALUE句の値リストは列数が一致しないとエラーになる
- NULLを入れることができるのは『NOT NULL』と定義してないこと
- DEFAULT制約
  - CREATE TABLEの中でDEFAULTを定義する
- DEFAULT定義をしていてデータ項目の定義と値を省略してもデフォルトの値が挿入される
- 一部の行を削除するときはWHERE句で対象行の条件を記述する
- TRUNCATE(切り捨てる)
  - TRUNCATE <table_name>; 
- UPDATE文でNULLを入れるこも可能.(制約にNOT NULLでなければ) 

- トランザクション
  - データベースに対する1つ以上の更新をまとめて呼ぶときの名称
    -INSERT/DELETE/UPDATEなどをまとめて 	

- ROLLBACK
  - スタート地点まで一気にUターンする

- ACID特性
  - 原子性(Atomicity)
    - トランザクションが終わった時に更新処理は全て実行されるか,されない状態で終わる事を保証する 
  
  - 一貫性(Consistency)
    - 制約に違反するレコードを挿入するSQL文はエラーになり実行されない
   
  - 独立性(Isolation)
    - トランザクション同士が互いに干渉を受けない事を保証する性質 

  - 永続性(Durability)
    - トランザクションが終了したあとはそのデータの情報が保存される事を保証するもの 


#### INSERT
- INSERTでデータを1行追加する
```
mysql> INSERT INTO ShohinIns (shohin_id, shohin_mei, shohin_bunrui, hanbai_tanka, shiire_tanka, torokubi) 
  VALUES ('0001', 'T-shirts', 'Ihuku', 1000, 500, '2009-09-20');

mysql> SELECT * FROM ShohinIns;
+-----------+------------+---------------+--------------+--------------+------------+
| shohin_id | shohin_mei | shohin_bunrui | hanbai_tanka | shiire_tanka | torokubi   |
+-----------+------------+---------------+--------------+--------------+------------+
| 0001      | T-shirts   | Ihuku         |         1000 |          500 | 2009-09-20 |
+-----------+------------+---------------+--------------+--------------+------------+
```

- 3件のデータを追加(NULLも追加)
```
INSERT INTO ShohinIns (shohin_id, shohin_mei, shohin_bunrui, hanbai_tanka, shiire_tanka, torokubi) 
  VALUES ('0002', 'Anaakepanchi', 'Jimu', 500, 320, '2009-09-11');

INSERT INTO ShohinIns (shohin_id, shohin_mei, shohin_bunrui, hanbai_tanka, shiire_tanka, torokubi) 
  VALUES ('0003', 'K-shirts', 'Ihuku', 4000, 2800, NULL);

INSERT INTO ShohinIns (shohin_id, shohin_mei, shohin_bunrui, hanbai_tanka, shiire_tanka, torokubi) 
  VALUES ('0004', 'Knife', 'kitchen', 3000, 2800, '2009-09-20');


mysql> SELECT * FROM ShohinIns;
+-----------+--------------+---------------+--------------+--------------+------------+
| shohin_id | shohin_mei   | shohin_bunrui | hanbai_tanka | shiire_tanka | torokubi   |
+-----------+--------------+---------------+--------------+--------------+------------+
| 0001      | T-shirts     | Ihuku         |         1000 |          500 | 2009-09-20 |
| 0002      | Anaakepanchi | Jimu          |          500 |          320 | 2009-09-11 |
| 0003      | K-shirts     | Ihuku         |         4000 |         2800 | NULL       |
| 0004      | Knife        | kitchen       |         3000 |         2800 | 2009-09-20 |
+-----------+--------------+---------------+--------------+--------------+------------+
```

- 1行を追加(列無し)
```
INSERT INTO ShohinIns 
  VALUES ('0005', 'Aturyokunabe', 'kitchen', 6800, 5000, '2009-01-15');

mysql> SELECT * FROM ShohinIns;
+-----------+--------------+---------------+--------------+--------------+------------+
| shohin_id | shohin_mei   | shohin_bunrui | hanbai_tanka | shiire_tanka | torokubi   |
+-----------+--------------+---------------+--------------+--------------+------------+
| 0005      | Aturyokunabe | kitchen       |         6800 |         5000 | 2009-01-15 |
+-----------+--------------+---------------+--------------+--------------+------------+
```

- NULLを登録する
```
INSERT INTO ShohinIns (shohin_id, shohin_mei, shohin_bunrui, hanbai_tanka, shiire_tanka, torokubi) 
  VALUES ('0006', 'Fork', 'kitchen', 500, NULL, '2009-09-20');

mysql> SELECT * FROM ShohinIns;
+-----------+--------------+---------------+--------------+--------------+------------+
| shohin_id | shohin_mei   | shohin_bunrui | hanbai_tanka | shiire_tanka | torokubi   |
+-----------+--------------+---------------+--------------+--------------+------------+
| 0006      | Fork         | kitchen       |          500 |         NULL | 2009-09-20 |
```

- DEFAULT定義 (hanbai_tanka  INTEGER      DEFAULT 0) を使ってデータを登録してみる
```
mysql> INSERT INTO ShohinIns (shohin_id, shohin_mei, shohin_bunrui, hanbai_tanka, shiire_tanka, torokubi) 
  VALUES ('0007', 'Oroshigane', 'kitchen', DEFAULT, 790, '2009-04-28');

mysql> SELECT * FROM ShohinIns;                                                                                                                              +-----------+--------------+---------------+--------------+--------------+------------+
| shohin_id | shohin_mei   | shohin_bunrui | hanbai_tanka | shiire_tanka | torokubi   |
+-----------+--------------+---------------+--------------+--------------+------------+
| 0007      | Oroshigane   | kitchen       |            0 |          790 | 2009-04-28 |
+-----------+--------------+---------------+--------------+--------------+------------+
```

- テーブルをCopyする
  - ShohinCopyテーブルにShohinテーブルのデータをコピー
```
INSERT INTO ShohinCopy (shohin_id, shohin_mei, shohin_bunrui, hanbai_tanka, shiire_tanka, torokubi)
 SELECT shohin_id, shohin_mei, shohin_bunrui, hanbai_tanka,shiire_tanka, torokubi
 	FROM Shohin;

mysql> SELECT * FROM ShohinCopy;
+-----------+-----------------------+--------------------+--------------+--------------+------------+
| shohin_id | shohin_mei            | shohin_bunrui      | hanbai_tanka | shiire_tanka | torokubi   |
+-----------+-----------------------+--------------------+--------------+--------------+------------+
| 0001      | Tシャツ               | 衣服               |         1000 |          500 | 2009-09-20 |
| 0002      | 穴あけパンチ          | 事務用品           |          500 |          320 | 2009-09-11 |
| 0003      | カッターシャツ        | 衣服               |         4000 |         2800 | NULL       |
| 0004      | 包丁                  | キッチン用品       |         3000 |         2800 | 2009-09-20 |
| 0005      | 圧力鍋                | キッチン用品       |         6800 |         5000 | 2009-01-15 |
| 0006      | フォーク              | キッチン用品       |          500 |         NULL | 2009-09-20 |
| 0007      | おろしがね            | キッチン用品       |          880 |          790 | 2008-04-28 |
| 0008      | ボールペン            | 事務用品           |          100 |         NULL | 2009-11-11 |
+-----------+-----------------------+--------------------+--------------+--------------+------------+
```

#### DELETE
- テーブルを残したまま全ての行を削除する
```
DELETE FROM <table_name>;
```

- 削除対象を制限したDELETE文
```
DELETE FROM Shohin
  WHERE hanbai_tanka >= 4000;

mysql> SELECT * FROM Shohin;
+-----------+--------------------+--------------------+--------------+--------------+------------+
| shohin_id | shohin_mei         | shohin_bunrui      | hanbai_tanka | shiire_tanka | torokubi   |
+-----------+--------------------+--------------------+--------------+--------------+------------+
| 0001      | Tシャツ            | 衣服               |         1000 |          500 | 2009-09-20 |
| 0002      | 穴あけパンチ       | 事務用品           |          500 |          320 | 2009-09-11 |
| 0004      | 包丁               | キッチン用品       |         3000 |         2800 | 2009-09-20 |
| 0006      | フォーク           | キッチン用品       |          500 |         NULL | 2009-09-20 |
| 0007      | おろしがね         | キッチン用品       |          880 |          790 | 2008-04-28 |
| 0008      | ボールペン         | 事務用品           |          100 |         NULL | 2009-11-11 |
+-----------+--------------------+--------------------+--------------+--------------+------------+
```

- データの更新(UPDATE)
```
UPDATE <table_name>
  SET <列名> = <式>;
```

```
UPDATE Shohin 
  SET torokubi = '2009-10-10';

mysql> SELECT * FROM Shohin;
+-----------+--------------------+--------------------+--------------+--------------+------------+
| shohin_id | shohin_mei         | shohin_bunrui      | hanbai_tanka | shiire_tanka | torokubi   |
+-----------+--------------------+--------------------+--------------+--------------+------------+
| 0001      | Tシャツ            | 衣服               |         1000 |          500 | 2009-10-10 |
| 0002      | 穴あけパンチ       | 事務用品           |          500 |          320 | 2009-10-10 |
| 0004      | 包丁               | キッチン用品       |         3000 |         2800 | 2009-10-10 |
| 0006      | フォーク           | キッチン用品       |          500 |         NULL | 2009-10-10 |
| 0007      | おろしがね         | キッチン用品       |          880 |          790 | 2009-10-10 |
| 0008      | ボールペン         | 事務用品           |          100 |         NULL | 2009-10-10 |
+-----------+--------------------+--------------------+--------------+--------------+------------+
```

- shiire_tankaが500以下の商品の値段を10倍にする
```
UPDATE Shohin 
  SET hanbai_tanka = hanbai_tanka * 10 
 WHERE hanbai_tanka <= 500;
 
mysql> SELECT * FROM Shohin ORDER BY shohin_id;
+-----------+--------------------+--------------------+--------------+--------------+------------+
| shohin_id | shohin_mei         | shohin_bunrui      | hanbai_tanka | shiire_tanka | torokubi   |
+-----------+--------------------+--------------------+--------------+--------------+------------+
| 0001      | Tシャツ            | 衣服               |         1000 |          500 | 2009-10-10 |
| 0002      | 穴あけパンチ       | 事務用品           |         5000 |          320 | 2009-10-10 |
| 0004      | 包丁               | キッチン用品       |         3000 |         2800 | 2009-10-10 |
| 0006      | フォーク           | キッチン用品       |         5000 |         NULL | 2009-10-10 |
| 0007      | おろしがね         | キッチン用品       |          880 |          790 | 2009-10-10 |
| 0008      | ボールペン         | 事務用品           |         1000 |         NULL | 2009-10-10 |
+-----------+--------------------+--------------------+--------------+--------------+------------+
```


- shohin_idが0008の登録日をNULLにする
```
UPDATE Shohin 
  SET torokubi = NULL 
 WHERE shohin_id = '0008';

mysql> SELECT * FROM Shohin ORDER BY shohin_id;
+-----------+--------------------+--------------------+--------------+--------------+------------+
| shohin_id | shohin_mei         | shohin_bunrui      | hanbai_tanka | shiire_tanka | torokubi   |
+-----------+--------------------+--------------------+--------------+--------------+------------+
| 0001      | Tシャツ            | 衣服               |         1000 |          500 | 2009-10-10 |
| 0002      | 穴あけパンチ       | 事務用品           |         5000 |          320 | 2009-10-10 |
| 0004      | 包丁               | キッチン用品       |         3000 |         2800 | 2009-10-10 |
| 0006      | フォーク           | キッチン用品       |         5000 |         NULL | 2009-10-10 |
| 0007      | おろしがね         | キッチン用品       |          880 |          790 | 2009-10-10 |
| 0008      | ボールペン         | 事務用品           |         1000 |         NULL | NULL       |
+-----------+--------------------+--------------------+--------------+--------------+------------+
```

- 正しく更新できるが冗長なUPDATE文
```
UPDATE Shohin 
	SET hanbai_tanka = hanbai_tanka * 10 
  WHERE shohin_bunrui = 'キッチン用品';

UPDATE Shohin 
	SET shiire_tanka = shiire_tanka / 2 
  WHERE shohin_bunrui = 'キッチン用品';
```
↓↓↓
- 処理を1つのUPDATE文にする
```
UPDATE Shohin 
	SET hanbai_tanka = hanbai_tanka * 10, 
 		shiire_tanka = shiire_tanka / 2 
  WHERE shohin_bunrui = 'キッチン用品';
```

#### Transaction
- トランザクション構文
```
START TRANSACTION;

   -- カッターシャツの販売単価を1000円引き
   UPDATE Shohin
      SET hanbai_tanka = hanbai_tanka - 1000
     WHERE shohin_mei = 'カッターシャツ';
   
   -- Tシャツの販売単価を1000値上げ
   UPDATE Shohin
      SET hanbai_tanka = hanbai_tanka + 1000
     WHERE shohin_mei = 'Tシャツ';
COMMIT;
```
