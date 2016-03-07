### ビューとテーブル/サブクエリ/相関サブクエリ

#### Rules
- よく使うSELECT文は『ビュー』にして使い回す方が効率的

#### KEYWORD
- 列


#### View
- ビューを作成
```
CREATE VIEW ビュー名 (<viewの列名1>, <viewの列名2>, ・・・)
AS
<SELECT文>
```

- ビューを作成する(合計するビューを作る)
```
CREATE VIEW ShohinSum (shohin_bunrui, cnt_shohin)
AS
SELECT shohin_bunrui, COUNT(*)
	FROM Shohin 
  GROUP BY shohin_bunrui;
```

- ビューを使う
```
SELECT shohin_bunrui, cnt_shohin
  FROM ShohinSum;

mysql> SELECT shohin_bunrui, cnt_shohin FROM ShohinSum;
+--------------------+------------+
| shohin_bunrui      | cnt_shohin |
+--------------------+------------+
| キッチン用品       |          4 |
| 事務用品           |          2 |
| 衣服               |          2 |
+--------------------+------------+
```
