CREATE TABLE Shohin
(shouhin_id CHAR(4) NOT NULL,
 shouhin_name  VARCHAR(100) NOT NULL,
 shouhin_cate  VARCHAR(32) NOT NULL,
 shouhin_price INTEGER ,
 shiire_price  INTEGER ,
 regsiterday   DATE ,
 PRIMARY KEY (shouhin_id)
);

START TRANSACTION;

INSERT INTO Shohin VALUES('0001', 'Tシャツ', '衣服', 1000, 500, '2015-09-20');

COMMIT;
