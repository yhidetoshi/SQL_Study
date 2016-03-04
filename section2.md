### SELECT文/Where句/算術演算子/比較演算子/論理演算子/真理値

#### Rules
- アスタリスク(*)は全列を意味する
- むやみに改行を入れない
- 結果から重複行を省く場合にはSELECT句にDISTINCTをつける
  - 複数NULLがあっても1つにまとめられる/先頭におく
- SELECT句には定数も式も記述できる
- NULLを含む計算は全て答えがNULLになる
- 比較演算子
  - 不等号が左側, イコールが右側 

#### KYEWORD
- SELECT文
  - クエリ：問い合わせ 
- 句
  - SELECT句, FROM句 
- AS
- DISTINCT
- WHERE句



#### SELECT文
- 基本的なSELECT文
```
mysql> SELECT <列名> FROM <table名>;

(例) 
SELECT shohin_id, shohin_mei, shiire_tanka FROM Shohin;
+-----------+-----------------------+--------------+
| shohin_id | shohin_mei            | shiire_tanka |
+-----------+-----------------------+--------------+
| 0001      | Tシャツ               |          500 |
```

- 全ての列を出力
```
mysql> SELECT * FROM <table名>;
(例)
SELECT * FROM Shohin;
```

- 列に別名をつける(AS)
```
SELECT hoge_id    AS id,
       hoge_mei   AS name,
       hoge_tanka AS tanka
  FROM <テーブル名>;
+------+-----------------------+-------+
| id   | name                  | tanka |
+------+-----------------------+-------+
| 0001 | Tシャツ               |   500 |
```

-  定数を出力
```
mysql> SELECT 'Goods' AS Goooods, 100 AS total_num, '2016-0304' AS hizuke, shohin_id, shohin_mei
  FROM Shohin;
+---------+-----------+-----------+-----------+-----------------------+
| Goooods | total_num | hizuke    | shohin_id | shohin_mei            |
+---------+-----------+-----------+-----------+-----------------------+
| Goods   |       100 | 2016-0304 | 0001      | Tシャツ               |
```

- 重複を省く(DISTINCT)
```
mysql> SELECT DISTINCT <列名> FROM <テーブル名>;
```

- SELECT文のWHERE句
```
SELECT <列名1>,...,<列名N>
    FROM <テーブル名>
  WHERE <条件式>;

(例)
mysql> SELECT shohin_mei, hanbai_tanka
	  FROM Shohin
  WHERE hanbai_tanka = '300';
+--------------------+--------------+
| shohin_mei         | hanbai_tanka |
+--------------------+--------------+
| スプーン           |          300 |
| フォーク           |          300 |
+--------------------+--------------+
```

- コメント
 - 1行コメント(--)
 - 複数行コメント(/*	*/)


- (例)算術演算子_価格を2倍
```
mysql> SELECT shohin_mei, hanbai_tanka,
       shohin_tanka * 2 AS "shohin_tanka_x2"
   WHERE Shohin;

+-----------------------+--------------+-----------------+
| shohin_mei            | hanbai_tanka | hanbai_tanka_x2 |
+-----------------------+--------------+-----------------+
| Tシャツ               |         1000 |            2000 |       
```

- 比較演算子_500以外
```
mysql> SELECT shohin_mei, shohin_bunrui
   FROM Shohin
 WHERE hanbai_tanka <> 500;

+-----------------------+--------------------+
| shohin_mei            | shohin_bunrui      |
+-----------------------+--------------------+
| Tシャツ               | 衣服               |
| カッターシャツ        | 衣服               |
```

- 比較演算子(WHERE句で計算)
```
SELECT shohin_mei, hanbai_tanka, shiire_tanka
   FROM Shohin
 WHERE hanbai_tanka - shiire_tanka >= 500;

+-----------------------+--------------+--------------+
| shohin_mei            | hanbai_tanka | shiire_tanka |
+-----------------------+--------------+--------------+
| Tシャツ               |         1000 |          500 |
```



