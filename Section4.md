### INSERT/DELETE/UPDATE/トランザクション

#### Rules
- 原則としてINSERT文は1回の実行で1行を挿入する
- VALUE句の値リストは列数が一致しないとエラーになる
- NULLを入れることができるのは『NOT NULL』と定義してないこと
- DEFAULT制約
  - CREATE TABLEの中でDEFAULTを定義する
- DEFAULT定義をしていてデータ項目の定義と値を省略してもデフォルトの値が挿入される

#### KYEWORD
- 

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
INSERT INTO ShohinCopy (shohin_id, shohin_mei, shohin_bunrui, hanbai_tanka, shiire_tanka, torokubi) SELECT shohin_id, shohin_mei, shohin_bunrui, hanbai_tanka,shiire_tanka, torokubi FROM Shohin;

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

