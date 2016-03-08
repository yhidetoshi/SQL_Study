### 様々な関数/述語(LIKE,BETWEEN,IS NULL,EXIST)/CASE式

#### Rules
- 算術関数
  - 『+ - * /』で四則演算をして結果を返す関数 
- LIKE(%)
  - 部分一致検索を行う時に使う
  - 前方一致 -> 『文字列%』
  - 中間一致 -> 『%文字列%』
  - 後方一致 -> 『%文字列』

- LIKE(-)
  - 『 _ 』は%と違って任意の1文字
  - 『 ___ 』だと任意の3文字

- BETWEEN(述語, 範囲検索)



#### KEYWORD
- ABS
  - 絶対値   
- MOD
  - 割った余り 
- ROUND
  -　四捨五入 
- CONCAT
  - 文字列連結
- LENGTH
  - 文字列数を数える
- LOWER
  - 大文字を小文字に変換
- REPLACE
  - 文字列を置き換える 
- SUBSTRING
  - 切り出す
- UPPER
  - 小文字を大文字に変換 


- CURRENT_DATE
  - 現在の日付を取得する 
- CURRENT_TIME
  - 現在の時間を取得する 
- CURRENT_TIMESTAMP
  - 現在のタイムスタンプを取得する 

- EXTRACT
  - 日付要素の切り出し 
- CAST
  - 型変換 
- COALESCE(コォアリース) 
  - NULLを別のデータに変える時に使う


- Tableデータ
```
mysql> select * FROM SampleMath;
+----------+------+------+
| m        | n    | p    |
+----------+------+------+
|  500.000 |    0 | NULL |
| -180.000 |    0 | NULL |
|     NULL | NULL | NULL |
|     NULL |    7 |    3 |
|     NULL |    5 |    2 |
|     NULL |    4 | NULL |
|    8.000 | NULL |    3 |
|    2.270 |    1 | NULL |
|    5.555 |    2 | NULL |
|     NULL |    1 | NULL |
|    8.760 | NULL | NULL |
+----------+------+------+
```

#### 算術関数
- 絶対値
```
mysql> SELECT m, 
  ABS(m) AS abs_col 
 FROM SampleMath;

+----------+---------+
| m        | abs_col |
+----------+---------+
|  500.000 | 500.000 |
| -180.000 | 180.000 |
|     NULL |    NULL |
|     NULL |    NULL |
|     NULL |    NULL |
|     NULL |    NULL |
|    8.000 |   8.000 |
|    2.270 |   2.270 |
|    5.555 |   5.555 |
|     NULL |    NULL |
|    8.760 |   8.760 |
+----------+---------+
```

- MOD関数
```
mysql> SELECT n,p, 
  MOD(n,p) AS mod_col 
 FROM SampleMath;

+------+------+---------+
| n    | p    | mod_col |
+------+------+---------+
|    0 | NULL |    NULL |
|    0 | NULL |    NULL |
| NULL | NULL |    NULL |
|    7 |    3 |       1 |
|    5 |    2 |       1 |
|    4 | NULL |    NULL |
| NULL |    3 |    NULL |
|    1 | NULL |    NULL |
|    2 | NULL |    NULL |
|    1 | NULL |    NULL |
| NULL | NULL |    NULL |
+------+------+---------+
```

- ROUND関数
```
mysql> SELECT m,n, 
  ROUND(m,n) AS round_col 
 FROM SampleMath;

+----------+------+-----------+
| m        | n    | round_col |
+----------+------+-----------+
|  500.000 |    0 |   500.000 |
| -180.000 |    0 |  -180.000 |
|     NULL | NULL |      NULL |
|     NULL |    7 |      NULL |
|     NULL |    5 |      NULL |
|     NULL |    4 |      NULL |
|    8.000 | NULL |      NULL |
|    2.270 |    1 |     2.300 |
|    5.555 |    2 |     5.560 |
|     NULL |    1 |      NULL |
|    8.760 | NULL |      NULL |
+----------+------+-----------+
```

#### 文字列関数
- 文字列の結合 ( CONCAT関数 ) 
```
mysql> SELECT str1, str2, str3, 
  CONCAT(str1, str2, str3) AS str_concat 
 FROM SampleStr;

+--------------------+-----------+--------+--------------------------+
| str1               | str2      | str3   | str_concat               |
+--------------------+-----------+--------+--------------------------+
| あいう             | えお      | NULL   | NULL                     |
| abc                | def       | NULL   | NULL                     |
| 山田               | 太郎      | です   | 山田太郎です             |
| aaa                | NULL      | NULL   | NULL                     |
| NULL               | あああ    | NULL   | NULL                     |
| @!#$%              | NULL      | NULL   | NULL                     |
| ABC                | NULL      | NULL   | NULL                     |
| aBC                | NULL      | NULL   | NULL                     |
| abc太郎            | abc       | ABC    | abc太郎abcABC            |
| abcdefabc          | abc       | ABC    | abcdefabcabcABC          |
| ミックマック       | ッ        | っ     | ミックマックッっ         |
+--------------------+-----------+--------+--------------------------+
```

- LENGTH関数( 文字列の長さを調べる )
```
mysql> SELECT str1, 
  LENGTH(str1) AS len_str 
 FROM SampleStr;

+--------------------+---------+
| str1               | len_str |
+--------------------+---------+
| あいう             |       9 |
| abc                |       3 |
| 山田               |       6 |
| aaa                |       3 |
| NULL               |    NULL |
| @!#$%              |       5 |
| ABC                |       3 |
| aBC                |       3 |
| abc太郎            |       9 |
| abcdefabc          |       9 |
| ミックマック       |      18 |
+--------------------+---------+
```

- LOWER関数 ( 文字を小文字に変換する )
```
mysql> SELECT str1, LOWER(str1) AS low_str 
  FROM SampleStr 
 WHERE str1 IN('ABC', 'aBC', 'abc');

+------+---------+
| str1 | low_str |
+------+---------+
| abc  | abc     |
| ABC  | abc     |
| aBC  | abc     |
+------+---------+
```

- REPLACE関数 ( 文字列を置き換える )
```
mysql> SELECT str1,str2,str3, 
  REPLACE(str1, str2, str3) AS rep_str 
 FROM SampleStr;

+--------------------+-----------+--------+--------------------+
| str1               | str2      | str3   | rep_str            |
+--------------------+-----------+--------+--------------------+
| あいう             | えお      | NULL   | NULL               |
| abc                | def       | NULL   | NULL               |
| 山田               | 太郎      | です   | 山田               |
| aaa                | NULL      | NULL   | NULL               |
| NULL               | あああ    | NULL   | NULL               |
| @!#$%              | NULL      | NULL   | NULL               |
| ABC                | NULL      | NULL   | NULL               |
| aBC                | NULL      | NULL   | NULL               |
| abc太郎            | abc       | ABC    | ABC太郎            |
| abcdefabc          | abc       | ABC    | ABCdefABC          |
| ミックマック       | ッ        | っ     | ミっクマっク       |
+--------------------+-----------+--------+--------------------+
```

#### 日付関数
- CURRENT_DATE
```
mysql> SELECT CURRENT_DATE;

+--------------+
| CURRENT_DATE |
+--------------+
| 2016-03-08   |
+--------------+
```

- CURRENT_TIME
```
mysql> SELECT CURRENT_TIME;

+--------------+
| CURRENT_TIME |
+--------------+
| 09:16:54     |
+--------------+
```

- CURRENT_TIMESTAMP
```
mysql> SELECT CURRENT_TIMESTAMP;

+---------------------+
| CURRENT_TIMESTAMP   |
+---------------------+
| 2016-03-08 09:17:28 |
+---------------------+
```

- EXTRACT(データを取り出す)
```
mysql> SELECT CURRENT_TIMESTAMP,
    -> EXTRACT(YEAR FROM CURRENT_TIMESTAMP) AS year,
    -> EXTRACT(MONTH FROM CURRENT_TIMESTAMP) AS month,
    -> EXTRACT(DAY FROM CURRENT_TIMESTAMP) AS day,
    -> EXTRACT(HOUR FROM CURRENT_TIMESTAMP) AS hour,
    -> EXTRACT(MINUTE FROM CURRENT_TIMESTAMP) AS minute,
    -> EXTRACT(SECOND FROM CURRENT_TIMESTAMP) AS second;
    
+---------------------+------+-------+------+------+--------+--------+
| CURRENT_TIMESTAMP   | year | month | day  | hour | minute | second |
+---------------------+------+-------+------+------+--------+--------+
| 2016-03-08 09:40:41 | 2016 |     3 |    8 |    9 |     40 |     41 |
+---------------------+------+-------+------+------+--------+--------+
```

- CAST(型変換)
```
mysql> SELECT CAST('0001' AS SIGNED INTEGER) AS int_col;

+---------+
| int_col |
+---------+
|       1 |
+---------+
```

#### 述語
- LIKE (前方一致)
```
mysql> SELECT * 
  FROM SampleLike 
 WHERE strcol LIKE 'ddd%';

+--------+
| strcol |
+--------+
| dddabc |
+--------+
```

- LIKE (後方一致)
```
mysql> SELECT * 
  FROM SampleLike 
 WHERE strcol LIKE '%ddd';

+--------+
| strcol |
+--------+
| abcddd |
+--------+
```

- LIKE (中間一致)
```
mysql> SELECT * 
  FROM SampleLike 
 WHERE strcol LIKE '%ddd%';

+--------+
| strcol |
+--------+
| abcddd |
| abdddc |
| dddabc |
+--------+
```

- 販売単価(100〜1000円)の商品を選択 
 → この書き方だと100と1000が含まれる
```
mysql> SELECT shohin_mei, hanbai_tanka 
  FROM Shohin 
 WHERE hanbai_tanka BETWEEN 100 AND 1000;

+--------------------+--------------+
| shohin_mei         | hanbai_tanka |
+--------------------+--------------+
| Tシャツ            |         1000 |
| 穴あけパンチ       |          500 |
| フォーク           |          500 |
| おろしがね         |          880 |
| ボールペン         |          100 |
+--------------------+--------------+
```

- 販売単価(101〜999円)の商品を選択
```
mysql> SELECT shohin_mei, hanbai_tanka
  FROM Shohin
 WHERE hanbai_tanka > 100 
   AND hanbai_tanka < 1000;

+--------------------+--------------+
| shohin_mei         | hanbai_tanka |
+--------------------+--------------+
| 穴あけパンチ       |          500 |
| フォーク           |          500 |
| おろしがね         |          880 |
+--------------------+--------------+
```

- IS NULLの判定
```
mysql> SELECT shohin_mei, hanbai_tanka 
  FROM Shohin 
 WHERE shiire_tanka IS NULL;

+-----------------+--------------+
| shohin_mei      | hanbai_tanka |
+-----------------+--------------+
| フォーク        |          500 |
| ボールペン      |          100 |
+-----------------+--------------+
```

- IS NOT NULLの判定
```
mysql> SELECT shohin_mei, shiire_tanka
  FROM Shohin 
 WHERE shiire_tanka IS NOT NULL;

+-----------------------+--------------+
| shohin_mei            | shiire_tanka |
+-----------------------+--------------+
| Tシャツ               |          500 |
| 穴あけパンチ          |          320 |
| カッターシャツ        |         2800 |
| 包丁                  |         2800 |
| 圧力鍋                |         5000 |
| おろしがね            |          790 |
+-----------------------+--------------+
```

- ORで複数の仕入れ単価を指定
```
mysql> SELECT shohin_mei, shiire_tanka
  From Shohin 
 WHERE shiire_tanka = 320 
    OR shiire_tanka = 500 
    OR shiire_tanka = 5000;

+--------------------+--------------+
| shohin_mei         | shiire_tanka |
+--------------------+--------------+
| Tシャツ            |          500 |
| 穴あけパンチ       |          320 |
| 圧力鍋             |         5000 |
+--------------------+--------------+
```
　　　↓↓↓
- IN述語で複数の仕入れ単価を指定して検索(1つ上のSQLと同義)
```
mysql> SELECT shohin_mei, shiire_tanka
  FROM Shohin 
 WHERE shiire_tanka IN (320, 500, 5000);

+--------------------+--------------+
| shohin_mei         | shiire_tanka |
+--------------------+--------------+
| Tシャツ            |          500 |
| 穴あけパンチ       |          320 |
| 圧力鍋             |         5000 |
+--------------------+--------------+
```

- NOT IN述語で複数の仕入れ単価を指定して検索
```
mysql> SELECT shohin_mei, shiire_tanka
    -> FROM Shohin
    -> WHERE shiire_tanka NOT IN (320, 500, 5000);
+-----------------------+--------------+
| shohin_mei            | shiire_tanka |
+-----------------------+--------------+
| カッターシャツ        |         2800 |
| 包丁                  |         2800 |
| おろしがね            |          790 |
+-----------------------+--------------+
```

