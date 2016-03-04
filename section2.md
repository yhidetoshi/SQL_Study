### SELECT文/Where句/算術演算子/比較演算子/論理演算子/真理値

#### Rules
- アスタリスク(*)は全列を意味する
- むやみに改行を入れない


#### KYEWORD
- SELECT文
  - クエリ：問い合わせ 
- 句
  - SELECT句, FROM句 
- *
- AS


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

