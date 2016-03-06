### 集約関数/行数カウント/合計/平均/最大/最小/GROUP/HAVING/ORDER BY

#### Rules
- COUNT関数は引数によって動作が異なる
  - COUNT(*)はNULLを含む行数を数える
  - COUNT(<列名>)はNULLを除外した行数を数える
- 集約関数で計算する場合、NULLがあれば除外して計算する
- MAX/MIN関数はほとんど全てのデータ型に適用できる
- SUM/AVG関数は数値のみにしか適用できない

- 句の順番(暫定)
 → 1.SELECT -> 2.FROM -> 3.WHERE -> 4.GROUP BY

- 集約キー/グループ化列 : GROUP BY句に指定する列のことを集約キー、グループ化列と呼ぶ
- WHERE句とGROUP BYを併用した場合はWHERE句で絞った結果に対してGROUP BYが使われる
- 集約関数を使えるのはSELECT句/HAVING句だけ

(よくある間違い!!)

1. SELECT句には定数, 集約関数(COUNT,MAXなど),GROUP BYで指定した列名(つまり集約キー)しか書けない

2. GROUP BY句でASを用いて別名にした列の名前を使うことはできない

3. GROUP BYを使って複数行の結果を出した時の表示はランダム表示になる

4. WHERE句に集約関数は書けない


#### KYEWORD
- COUNT
  - テーブルの行数をカウント
- SUM
  - テーブルの数値列のデータを合計 
- AVG
  - テーブルの数値列のデータを平均
- MAX
  - テーブルの任意の列のデータの最大値を求める 
- MIN
  -   - テーブルの任意の列のデータの最小値を求める  
  
#### COUNT
- テーブルの全行数を数える
```
mysql> SELECT COUNT(*) 
  FROM Shohin;

+----------+
| COUNT(*) |
+----------+
|        8 |
+----------+
```

- テーブルのNULLを除外して行数を数える
```
mysql> SELECT COUNT(shiire_tanka) 
  FROM Shohin;

+---------------------+
| COUNT(shiire_tanka) |
+---------------------+
|                   6 |
+---------------------+
```

- 合計を求める(1つの列)
```
mysql> SELECT SUM(hanbai_tanka) 
  FROM Shohin;
+-------------------+
| SUM(hanbai_tanka) |
+-------------------+
|             16780 |
+-------------------+
```

- 合計を求める(2つの列の場合)
```
mysql> SELECT SUM(hanbai_tanka), SUM(shiire_tanka) 
  FROM Shohin;
+-------------------+-------------------+
| SUM(hanbai_tanka) | SUM(shiire_tanka) |
+-------------------+-------------------+
|             16780 |             12210 |
+-------------------+-------------------+
```

- 平均を求める
```
mysql> SELECT AVG(hanbai_tanka) 
  FROM Shohin;

+-------------------+
| AVG(hanbai_tanka) |
+-------------------+
|         2097.5000 |
+-------------------+
```

- 平均を求める(2つの列の場合)
```
mysql> SELECT AVG(hanbai_tanka), AVG(shiire_tanka) 
  FROM Shohin;

+-------------------+-------------------+
| AVG(hanbai_tanka) | AVG(shiire_tanka) |
+-------------------+-------------------+
|         2097.5000 |         2035.0000 |
+-------------------+-------------------+
```

- 最大値と最小値を求める
```
mysql> SELECT MAX(hanbai_tanka), MIN(shiire_tanka) 
  FROM Shohin;

+-------------------+-------------------+
| MAX(hanbai_tanka) | MIN(shiire_tanka) |
+-------------------+-------------------+
|              6800 |               320 |
+-------------------+-------------------+
```

- 日付の最大値と最小値を求めることができる
```
mysql> SELECT MAX(torokubi), MIN(torokubi) 
  FROM Shohin;
+---------------+---------------+
| MAX(torokubi) | MIN(torokubi) |
+---------------+---------------+
| 2009-11-11    | 2008-04-28    |
+---------------+---------------+
```

- 重複を除外して行数をカウント(重複を除外してからカウントされるので結果:3)
```
mysql> SELECT COUNT(DISTINCT shohin_bunrui) 
  FROM Shohin;

+-------------------------------+
| COUNT(DISTINCT shohin_bunrui) |
+-------------------------------+
|                             3 |
+-------------------------------+
```

  -　(注意:良くない例)数を数えてから重複をカウントになるので結果:8
```
mysql> SELECT DISTINCT COUNT(shohin_bunrui) 
  FROM Shohin;
+----------------------+
| COUNT(shohin_bunrui) |
+----------------------+
|                    8 |
+----------------------+
```

- 最初は重複なしで合計、２つ目は重複を除外して合計
```
mysql> SELECT SUM(hanbai_tanka), SUM(DISTINCT hanbai_tanka) 
  FROM Shohin;
+-------------------+----------------------------+
| SUM(hanbai_tanka) | SUM(DISTINCT hanbai_tanka) |
+-------------------+----------------------------+
|             16780 |                      16280 |
+-------------------+----------------------------+
```

#### テーブルをグループに切り分ける
 → (例) 商品ごと、登録日こととか

- 商品分類ごとの個数を調べる
```
mysql> SELECT shohin_bunrui, COUNT(*) 
  FROM Shohin
GROUP BY shohin_bunrui;
+--------------------+----------+
| shohin_bunrui      | COUNT(*) |
+--------------------+----------+
| キッチン用品       |        4 |
| 事務用品           |        2 |
| 衣服               |        2 |
+--------------------+----------+
```

- 仕入れ単価ごとに行数を調べる
```
mysql> SELECT shiire_tanka, COUNT(*) FROM Shohin GROUP BY shiire_tanka;

+--------------+----------+
| shiire_tanka | COUNT(*) |
+--------------+----------+
|         NULL |        2 |
|          320 |        1 |
|          500 |        1 |
|          790 |        1 |
|         2800 |        2 |
|         5000 |        1 |
+--------------+----------+
```

- WHERE句で絞ってGROUP BYをする
```
mysql> SELECT shiire_tanka, COUNT(*) FROM Shohin WHERE torokubi = '2009-09-20' GROUP BY shiire_tanka;

+--------------+----------+
| shiire_tanka | COUNT(*) |
+--------------+----------+
|         NULL |        1 |
|          500 |        1 |
|         2800 |        1 |
+--------------+----------+
```

