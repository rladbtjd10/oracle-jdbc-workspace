DROP TABLE PHOTO CASCADE CONSTRAINTS;
DROP TABLE RESERVATION CASCADE CONSTRAINTS;
DROP TABLE RES_COMMENT CASCADE CONSTRAINTS;
DROP TABLE PICK CASCADE CONSTRAINTS;
DROP TABLE RES_MENU CASCADE CONSTRAINTS;
DROP TABLE DISCOUNT CASCADE CONSTRAINTS;
DROP TABLE REVIEW CASCADE CONSTRAINTS;
DROP TABLE MENU; CASCADE CONSTRAINTS
DROP TABLE RESTAURANT CASCADE CONSTRAINTS;
DROP TABLE LOCATION CASCADE CONSTRAINTS;
DROP TABLE MEMBER CASCADE CONSTRAINTS;
DROP TABLE FOOD CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_PHOTO;
DROP SEQUENCE SEQ_DISCOUNT;
DROP SEQUENCE SEQ_RESERVATION;
DROP SEQUENCE SEQ_MENU;
DROP SEQUENCE SEQ_DISCOUNT;
DROP SEQUENCE SEQ_PICK;
DROP SEQUENCE SEQ_RESTAURANT;
DROP SEQUENCE SEQ_LOCATION;
DROP SEQUENCE SEQ_FOOD;
DROP SEQUENCE SEQ_RES_COMMENT;
DROP SEQUENCE SEQ_REVIEW;

CREATE SEQUENCE SEQ_PHOTO;
CREATE SEQUENCE SEQ_PHOTO;
CREATE SEQUENCE SEQ_MENU;
CREATE SEQUENCE SEQ_DISCOUNT;
CREATE SEQUENCE SEQ_PICK;
CREATE SEQUENCE SEQ_RESTAURANT;
CREATE SEQUENCE SEQ_LOCATION;
CREATE SEQUENCE SEQ_FOOD;
CREATE SEQUENCE SEQ_RES_COMMENT;
CREATE SEQUENCE SEQ_RESERVATION;
CREATE SEQUENCE SEQ_REVIEW;
​
​
CREATE TABLE MEMBER(
    ID VARCHAR2(20),
    NAME VARCHAR2(200) NOT NULL,
    PASSWORD VARCHAR2(300) NOT NULL,
    PHONE VARCHAR2(20) NOT NULL,
    NICKNAME VARCHAR2(20) UNIQUE,
    GENDER CHAR(1) CHECK(GENDER IN('M', 'F')),
    AGE NUMBER,
    EMAIL VARCHAR2(50),
    ROLE VARCHAR2(10) CHECK(ROLE IN('사장', '고객', '관리자'))
);
CREATE TABLE DISCOUNT(
    DIS_CODE NUMBER,
    DIS_DESC VARCHAR2(100) NOT NULL,
    DIS_PERIOD VARCHAR2(50) NOT NULL,
    RES_CODE NUMBER
);
CREATE TABLE RESTAURANT(
    RES_CODE NUMBER,
    RES_NAME VARCHAR2(200) NOT NULL,
    RES_ADDR VARCHAR2(200) NOT NULL,
    RES_PHONE VARCHAR2(200) NOT NULL,
    RES_OPEN_HOUR VARCHAR2(100),
    RES_CLOSE VARCHAR2(100),
    RES_DESC VARCHAR2(500),
    RES_PICTURE VARCHAR2(200),
    RES_PICKS NUMBER DEFAULT 0,
    LOCAL_CODE NUMBER,
    FOOD_CODE NUMBER,
    MENU_CODE NUMBER,
    ID VARCHAR2(20)
);
CREATE TABLE LOCATION(
    LOCAL_CODE NUMBER,
    LOCAL_NAME VARCHAR2(200) NOT NULL
);
CREATE TABLE FOOD(
    FOOD_CODE NUMBER,
    FOOD_TYPE VARCHAR2(100) NOT NULL
);
CREATE TABLE RES_COMMENT(
    RES_COMMENT_CODE NUMBER,
    RES_COMMENT_DETAIL VARCHAR2(200),
    RES_COMMENT_DATE DATE DEFAULT SYSDATE,
    ID VARCHAR2(20),
    REVIEW_CODE NUMBER
);
CREATE TABLE RESERVATION(
    RESER_CODE NUMBER,
    RESER_DATE DATE,
    RESER_TIME TIMESTAMP,
    RESER_PER NUMBER, -- 예약 명수
    ID VARCHAR2(20),
    RES_CODE NUMBER
);
CREATE TABLE REVIEW(
    REVIEW_CODE NUMBER,
    REVIEW_CONTENT VARCHAR2(200), --리뷰-리뷰내용
    REVIEW_GRADE NUMBER,
    REVIEW_DATE DATE DEFAULT SYSDATE,
    REVIEW_PHOTO VARCHAR2(200),
    ID VARCHAR2(20),
    RES_CODE NUMBER
);
CREATE TABLE PHOTO(
    RES_PHOTO_CODE NUMBER,
    PHOTO_ VARCHAR2(300) NOT NULL,
    PHOTO_NAME VARCHAR2(50) NOT NULL,
    RES_CODE NUMBER
);
CREATE TABLE MENU(
    MENU_CODE NUMBER,
    MENU_NAME VARCHAR2(100),
    MENU_PRICE VARCHAR2(50),
    MENU_DESC VARCHAR2(300),
    MENU_PICTURE VARCHAR2(200),
    RES_CODE NUMBER
);
CREATE TABLE PICK(
    PICK_CODE NUMBER,
    RES_CODE NUMBER,
    PICK_TIME DATE DEFAULT SYSDATE,
    ID VARCHAR2(20)
);

CREATE SEQUENCE SEQ_PHOTO;
CREATE SEQUENCE SEQ_MENU;
CREATE SEQUENCE SEQ_DISCOUNT;
CREATE SEQUENCE SEQ_PICK;
CREATE SEQUENCE SEQ_RESTAURANT;
CREATE SEQUENCE SEQ_LOCATION;
CREATE SEQUENCE SEQ_FOOD;
CREATE SEQUENCE SEQ_RES_COMMENT;
CREATE SEQUENCE SEQ_RESERVATION;
CREATE SEQUENCE SEQ_REVIEW;
​
​
ALTER TABLE RESTAURANT ADD CONSTRAINT RESTAURANT_RES_CODE_PK PRIMARY KEY(RES_CODE);
ALTER TABLE LOCATION ADD CONSTRAINT LOCATION_LOCAL_CODE_PK PRIMARY KEY(LOCAL_CODE);
ALTER TABLE FOOD ADD CONSTRAINT FOOD_FOOD_CODE_PK PRIMARY KEY(FOOD_CODE);
ALTER TABLE MEMBER ADD CONSTRAINT MEMBER_ID_PK PRIMARY KEY(ID);
ALTER TABLE DISCOUNT ADD CONSTRAINT DISCOUNT_DIS_CODE_PK PRIMARY KEY(DIS_CODE);
ALTER TABLE RES_COMMENT ADD CONSTRAINT RES_COMMENT_RES_COMMENT_CODE_PK PRIMARY KEY(RES_COMMENT_CODE);
ALTER TABLE PICK ADD CONSTRAINT PICK_PICK_CODE_PK PRIMARY KEY(PICK_CODE);
ALTER TABLE RESERVATION ADD CONSTRAINT RESERVATION_RESER_CODE_PK PRIMARY KEY(RESER_CODE);
ALTER TABLE REVIEW ADD CONSTRAINT REVIEW_REVIEW_CODE_PK PRIMARY KEY(REVIEW_CODE);
ALTER TABLE PHOTO ADD CONSTRAINT PHOTO_RES_PHOTO_CODE_PK PRIMARY KEY (RES_PHOTO_CODE);
ALTER TABLE MENU ADD CONSTRAINT MENU_MENU_CODE_PK PRIMARY KEY (MENU_CODE);
​
​
​
​
​
ALTER TABLE RESTAURANT ADD CONSTRAINT RESTAURANT_ID_FK FOREIGN KEY(ID) REFERENCES MEMBER;
ALTER TABLE RESTAURANT ADD CONSTRAINT RESTAURANT_LOCAL_CODE_FK FOREIGN KEY(LOCAL_CODE) REFERENCES LOCATION;
ALTER TABLE RESTAURANT ADD CONSTRAINT RESTAURANT_FOOD_CODE_FK FOREIGN KEY(FOOD_CODE) REFERENCES FOOD;
ALTER TABLE PICK ADD CONSTRAINT PICK_RES_CODE_FK FOREIGN KEY(RES_CODE) REFERENCES RESTAURANT;
ALTER TABLE PICK ADD CONSTRAINT PICK_ID_FK FOREIGN KEY(ID) REFERENCES MEMBER;
ALTER TABLE RES_COMMENT ADD CONSTRAINT RES_COMMENT_ID_FK FOREIGN KEY(ID) REFERENCES MEMBER;
ALTER TABLE RES_COMMENT ADD CONSTRAINT RES_COMMENT_REVIEW_CODE_FK FOREIGN KEY(REVIEW_CODE) REFERENCES REVIEW;
ALTER TABLE RESERVATION ADD CONSTRAINT RESERVATION_ID_FK FOREIGN KEY(ID) REFERENCES MEMBER;
ALTER TABLE RESERVATION ADD CONSTRAINT RESERVATION_RES_CODE_FK FOREIGN KEY(RES_CODE) REFERENCES RESTAURANT;
ALTER TABLE REVIEW ADD CONSTRAINT REVIEW_ID_FK FOREIGN KEY(ID) REFERENCES MEMBER;
ALTER TABLE REVIEW ADD CONSTRAINT REVIEW_RES_CODE_FK FOREIGN KEY(RES_CODE) REFERENCES RESTAURANT;
ALTER TABLE MENU ADD CONSTRAINT MENU_RES_CODE_FK FOREIGN KEY(RES_CODE) REFERENCES RESTAURANT;
ALTER TABLE DISCOUNT ADD CONSTRAINT DISCOUNT_RES_CODE_FK FOREIGN KEY(RES_CODE) REFERENCES RESTAURANT(RES_CODE);
ALTER TABLE PHOTO ADD CONSTRAINT PHOTO_RES_CODE_FK FOREIGN KEY(RES_CODE) REFERENCES RESTAURANT(RES_CODE);
​
​
​
SELECT * FROM PICK;
SELECT * FROM RESTAURANT;
SELECT * FROM LOCATION ORDER BY LOCAL_CODE;
SELECT * FROM FOOD;
SELECT * FROM MEMBER;
SELECT * FROM DISCOUNT;
SELECT * FROM MENU;
SELECT * FROM RES_COMMENT;
SELECT * FROM PHOTO;

