### Window関数/GROUPING演算子


#### Rules
- PARTITION BY : 順位をつける対象の範囲


#### KYEWORD
- ウィンドウ関数
  - OLAP(OnLine Analytical Processing)関数
    - データベースを使ってリアルタイム(オンランインで)データ分析を行う処理
      - (例) 市場分析, 財務諸表作成, 契約作成
      - MySQL5.5では未サポート
    - ウィンドウ専用関数 
      - RANK, DENSE_RANK, ROW_NUMBER  
  

- RANKを使ってみる(Oracle, SQL Server DB2 PostgresSQL)
```
SELECT shohin_mei, shohin_bunrui, hanbai_tanka,
    RANK () OVER (PARTITION BY shohin_bunrui
                      ORDER BY hanbai_tanka) AS ranking
  FROM Shohin;
```

