### Window関数/GROUPING演算子


#### Rules
- PARTITION BY : 順位をつける対象の範囲
- ウィンドウ関数はカットと順序づけの両方の機能を持っている
- PATITION BYによって区切られた部分集合をウィンドウと呼ぶ
- ウィンドウ専用関数は引数をとらないので常にカッコ()の中は空っぽ
- ウィンドウ関数は原則としてSELECT句のみで使える


#### KYEWORD
- ウィンドウ関数
  - OLAP(OnLine Analytical Processing)関数
    - データベースを使ってリアルタイム(オンランインで)データ分析を行う処理
      - (例) 市場分析, 財務諸表作成, 契約作成
      - MySQL5.5では未サポート
    - ウィンドウ専用関数 
      - RANK
        - ランキングを算出(同順位が存在した場合、後続の順位が飛ぶ)
          - (例) 1位 1位 3位 
      - DENSE_RANK
        - RANKと同じだが(同順位が存在しても、後続の順位が飛ぶことがない)
          - (例) 1位 1位 2位 
      - ROW_NUMBER  
        - 一意な連番を付与する
          - (例) 1位が3つある場合でも, 1位 2位 3位 
  

- RANKを使ってみる(Oracle, SQL Server DB2 PostgresSQL)
```
SELECT shohin_mei, shohin_bunrui, hanbai_tanka,
    RANK () OVER (PARTITION BY shohin_bunrui
                      ORDER BY hanbai_tanka) AS ranking
  FROM Shohin;
```

