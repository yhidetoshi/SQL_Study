
練習問題1-1
```
CREATE TABLE Jyushoroku
(
	toroku_bango INTEGER NOT NULL,
	name		 VARCHAR(128) NOT NULL,
	jyusho       VARCHAR(256) NOT NULL,
	tel_no		 CHAR(10)	,
	mail_address CHAR(20)	,
	PRIMARY KEY (toroku_bango
));
```

練習問題1-2(MySQL)
```
ALTER TABLE Jyushoroku ADD COLUMN yubin_bango CHAR(8) NOT NULL;
```

練習問題1-3
```
DROP TALBE Jyushoroku
```
練習問題1-4
※ 1-1と同じ
