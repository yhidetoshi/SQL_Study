### 集約関数/行数カウント/合計/平均/最大/最小/GROUP/HAVING/ORDER BY

#### Rules
- COUNT関数は引数によって動作が異なる
  - COUNT(*)はNULLを含む行数を数える
  - COUNT(<列名>)はNULLを除外した行数を数える
- 集約関数で計算する場合、NULLがあれば除外して計算する

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
mysql> SELECT COUNT(*) FROM Shohin;

+----------+
| COUNT(*) |
+----------+
|        8 |
+----------+
```

- テーブルのNULLを除外して行数を数える
```
mysql> SELECT COUNT(shiire_tanka) FROM Shohin;

+---------------------+
| COUNT(shiire_tanka) |
+---------------------+
|                   6 |
+---------------------+
```

- 合計を求める(1つの列)
```
mysql> SELECT SUM(hanbai_tanka) FROM Shohin;
+-------------------+
| SUM(hanbai_tanka) |
+-------------------+
|             16780 |
+-------------------+
```

- 合計を求める(2つの列)
```
mysql> SELECT SUM(hanbai_tanka), SUM(shiire_tanka) FROM Shohin;
+-------------------+-------------------+
| SUM(hanbai_tanka) | SUM(shiire_tanka) |
+-------------------+-------------------+
|             16780 |             12210 |
+-------------------+-------------------+
```

- 平均を求める
```
mysql> SELECT AVG(hanbai_tanka) FROM Shohin;
+-------------------+
| AVG(hanbai_tanka) |
+-------------------+
|         2097.5000 |
+-------------------+
```

- 
