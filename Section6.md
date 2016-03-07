### 様々な関数/述語(LIKE,BETWEEN,IS NULL,EXIST)/CASE式

#### Rules
- 算術関数
  - 『+ - * /』で四則演算をして結果を返す関数 


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
mysql> SELECT m, ABS(m) AS abs_col FROM SampleMath;
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

