練習問題2-1

```
mysql> SELECT shohin_mei, torokubi
    -> FROM Shohin
    -> WHERE torokubi > '2009-04-28';
+--------------------+------------+
| shohin_mei         | torokubi   |
+--------------------+------------+
| Tシャツ            | 2009-09-20 |
| 穴あけパンチ       | 2009-09-11 |
| 包丁               | 2009-09-20 |
| フォーク           | 2009-09-20 |
| ボールペン         | 2009-11-11 |
+--------------------+------------+
```

練習問題2-3
```
mysql> SELECT shohin_mei, hanbai_tanka, shiire_tanka
    -> FROM Shohin
    -> WHERE (hanbai_tanka - shiire_tanka) > 500;
+-----------------------+--------------+--------------+
| shohin_mei            | hanbai_tanka | shiire_tanka |
+-----------------------+--------------+--------------+
| カッターシャツ        |         4000 |         2800 |
| 圧力鍋                |         6800 |         5000 |
+-----------------------+--------------+--------------+
```

練習問題2-4
```
SELECT shohin_mei, shohin_bunrui,
       hanbai_tanka * 0.9 - shiire_tanka AS rieki
  FROM Shohin
 WHERE hanbai_tanka * 0.9 - shiire_tanka > 100
   AND (   shohin_bunrui = '事務用品'
        OR shohin_bunrui = 'キッチン用品');
```
