### ビューとテーブル/サブクエリ/相関サブクエリ

#### Rules
- よく使うSELECT文は『ビュー』にして使い回す方が効率的
- ビューを多重に作ることはなるべく避ける

-　ビューの制限事項
  - ORDER BY句は使えない
- ビューとテーブルの更新は連動して行われるので集約されたビューは更新不可能 
- サブクエり
  - 『使い捨てのビュー』 

- サブクエリは内側から最初に実行される
- スカラ・サブクエリは1行1列だけの戻りを返す


**<大事>**
```
- 相関サブクエり
  - 小分けにしたグループ内での比較をする 

- 商品分類別にテーブルをカットしたイメージと相関サブクエリによるカットイメージ
　- 商品分類別だと
    - キッチン用品(4つ)(包丁/圧力鍋/フォーク/おろしがね) 
    - 衣服(2つ)(Tシャツ/カッターシャツ) 
    - 事務用品(2つ)(穴開けパンチ, ボールペン)
  - 相関サブクエリだと
    - キッチン用品(平均単価=1000)
    - 衣服(平均単価=2000)
    - 事務用品(平均単価=3000)
```


#### View
- ビューを作成
```
CREATE VIEW ビュー名 (<viewの列名1>, <viewの列名2>, ・・・)
AS
<SELECT文>
```

- ビューを作成する(個数を合計するビューを作る)
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

- ビューを削除する(DROP VIEW)
```
DROP VIEW <view_name>
```

#### サブクエリでビュー(ShohinSum)を作成する
```
SELECT shohin_bunrui, cnt_shohin 
	FROM(
       <------- サブクエリ ----->
	  SELECT shohin_bunrui, COUNT(*) AS cnt_shohin 
	   FROM Shohin 
        GROUP BY shohin_bunrui
       <------------>
    ) AS ShohinSum;
```

#### スカラ・サブクエリ
- リクエスト例
```
SELECT shohin_id, shohin_mei, hanbai_tanka,
       
       <---- スカラ・サブクエり --->
       (SELECT AVG(hanbai_tanka)
       	  FROM Shohin) AS avg_tanka
       <---------------------------->
 
 FROM Shohin;
```

#### 相関サブクエリ
- まず,シンプルに分類毎に平均値を求める
```
mysql> SELECT AVG(hanbai_tanka)
         FROM Shohin 
        GROUP BY shohin_bunrui;
+-------------------+
| AVG(hanbai_tanka) |
+-------------------+
|         2795.0000 |
|          300.0000 |
|         2500.0000 |
+-------------------+

→ これをスカラで求めようとすると戻り値が3つあるのでエラーになる
 → この問題を解決するのが相関サブクエリ
```

- 相関サブクエリを使って求める
  - サブクエリ(平均を求めて)作り、それと元のテーブルと同じ(shohin_bunrui同士)を比較する 
```
SELECT shohin_bunrui, shohin_mei, hanbai_tanka
 FROM Shohin AS S1
 WHERE hanbai_tanka > (SELECT AVG(hanbai_tanka)
			FROM Shohin AS S2
		      WHERE S1.shohin_bunrui = S2.shohin_bunrui
		      GROUP BY shohin_bunrui);
)

+--------------------+-----------------------+--------------+
| shohin_bunrui      | shohin_mei            | hanbai_tanka |
+--------------------+-----------------------+--------------+
| 事務用品           | 穴あけパンチ          |          500 |
| 衣服               | カッターシャツ        |         4000 |
| キッチン用品       | 包丁                  |         3000 |
| キッチン用品       | 圧力鍋                |         6800 |
+--------------------+-----------------------+--------------+
```


