練習問題5-1
```
mysql> CREATE VIEW ViewRenshu5_1 AS
    -> SELECT shohin_mei, hanbai_tanka, torokubi
    -> FROM Shohin
    -> WHERE hanbai_tanka >= 1000 AND torokubi = '2009-09-20';
```


練習問題5-3
```
SELECT shohin_id,
       shohin_mei,
       shohin_bunrui,
       hanbai_tanka,
       (SELECT AVG(hanbai_tanka) FROM Shohin) AS hanbai_tanka_all
  FROM Shohin;
```


練習問題5-5
```
CREATE VIEW AvgTankaByBunrui AS
SELECT shohin_id,
       shohin_mei,
       shohin_bunrui,
       hanbai_tanka,
       (SELECT AVG(hanbai_tanka)
          FROM Shohin S2
         WHERE S1.shohin_bunrui = S2.shohin_bunrui
         GROUP BY S1.shohin_bunrui) AS avg_hanbai_tanka
 FROM Shohin S1;
```
