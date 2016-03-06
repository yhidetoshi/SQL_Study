### INSERT/DELETE/UPDATE/トランザクション

#### Rules
- 原則としてINSERT文は1回の実行で1行を挿入する
- VALUE句の値リストは列数が一致しないとエラーになる


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

- 3件のデータを追加
```
INSERT INTO ShohinIns (shohin_id, shohin_mei, shohin_bunrui, hanbai_tanka, shiire_tanka, torokubi) VALUES ('0002', 'Anaakepanchi', 'Jimu', 500, 320, '2009-09-11');

INSERT INTO ShohinIns (shohin_id, shohin_mei, shohin_bunrui, hanbai_tanka, shiire_tanka, torokubi) VALUES ('0003', 'K-shirts', 'Ihuku', 4000, 2800, NULL);

INSERT INTO ShohinIns (shohin_id, shohin_mei, shohin_bunrui, hanbai_tanka, shiire_tanka, torokubi) VALUES ('0004', 'Knife', 'kitchen', 3000, 2800, '2009-09-20');


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
