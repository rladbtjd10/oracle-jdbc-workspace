SELECT * FROM TEST;

-- sample 계정 접속해서
CREATE TABLE MEMBER(
    NAME VARCHAR(50),
    AGE NUMBER,
    ADDR VARCHAR(100)
);

-- INSERT 구문
INSERT INTO MEMBER(NAME, AGE, ADDR) VALUES 
('가가가', 1, '나나나');

COMMIT;

SELECT * FROM MEMBER;