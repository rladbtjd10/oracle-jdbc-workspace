CREATE SEQUENCE SEQ_BOARD;
CREATE TABLE BOARD(
    NO NUMBER,
    TITLE VARCHAR2(200) NOT NULL,
    CONTENT VARCHAR2(2000) NOT NULL,
    WRITER VARCHAR2(50) NOT NULL,
    REGDATE DATE DEFAULT SYSDATE
);

SELECT*FROM BOARD;

INSERT INTO board(no, title, content, writer)
(SELECT SEQ_BOARD.NEXTVAL, title, content, writer FROM board);
COMMIT;

ALTER TABLE board ADD CONSTRAINT PK_BOARD PRIMARY KEY(no);

SELECT * FROM board ORDER BY no DESC;

-- 힌트..! (위에꺼보다 속도가 더 빠름)
-- 첫페이지
SELECT NUM, NO, TITLE, WRITER, REGDATE
FROM (
        SELECT /*+ INDEX_DESC(board PK_BOARD) */   
                ROWNUM NUM, NO, TITLE, WRITER, REGDATE
        FROM board
        WHERE ROWNUM <= 10
)
WHERE NUM > 0;

-- 두번째 페이지 (11~20)
SELECT NUM, NO, TITLE, WRITER, REGDATE
FROM (
        SELECT /*+ INDEX_DESC(board PK_BOARD) */ 
                ROWNUM NUM, NO, TITLE, WRITER, REGDATE
        FROM board
        WHERE ROWNUM <=20
)
WHERE NUM > 10;

-- 세번째 페이지 (21~30)
SELECT NUM, NO, TITLE, WRITER, REGDATE
FROM (
        --/*+ FULL(board PK_BOARD) */ --전부다 색출해내겠다 ASC도 쓸수 있음 쓴순서대로
        SELECT /*+ INDEX_DESC(board PK_BOARD) */  --힌트(이상한 문법이들어가도 돌아감)보조적역할
                ROWNUM NUM, NO, TITLE, WRITER, REGDATE
        FROM board
        WHERE ROWNUM <=30
)
WHERE NUM > 20;

drop table member;

create table member(
    id varchar2(50) primary key,
    password varchar2(100) not null,
    name varchar2(50) not null,
    address varchar2(200),
    auth varchar2(50) default 'ROLE_MEMBER' not null,
    enabled number(1) default 1 not null
);

SELECT  *FROM MEMBER;




