練習問題3-2
```
SELECT shohin_bunrui, SUM(hanbai_tanka), SUM(shiire_tanka)
  FROM Shohin
 GROUP BY shohin_bunrui
HAVING SUM(hanbai_tanka) > SUM(shiire_tanka) * 1.5;
```
練習問題3-3
```
SELECT *
  FROM Shohin
 ORDER BY torokubi DESC, hanbai_tanka;
```
