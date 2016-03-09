練習問題4-3
```
INSERT INTO ShohinSaeki (shohin_id, shohin_mei, hanbai_tanka, shiire_tanka, saeki)
SELECT shohin_id, shohin_mei, hanbai_tanka, shiire_tanka, hanbai_tanka - shiire_tanka
  FROM Shohin;
```

練習問題4-4

- 販売単価の引き下げ
```
UPDATE ShohinSaeki
  SET hanbai_tanka = 3000
 WHERE shohin_id = '0003';
```

- 差益の再計算
```
UPDATE ShohinSaeki
  SET saeki = hanbai_tanka - shiire_tanka
 WHERE shohin_id = '0003';
```
