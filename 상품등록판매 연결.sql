
DROP TABLE TB_PRODUCT_ORDER;            -- 상품주문 테이블
DROP TABLE TB_PRODUCT;                  -- 상품등록 테이블
DROP TABLE TB_ORDER_REQUEST;            -- 상품주문 요청 테이블
DROP TABLE TB_MY_STORE;                 -- 내상점 테이블
DROP TABLE TB_DELIVERY;                 -- 배송정보 테이블
DROP TABLE TB_ATTACHMENT;               -- 사진저장 테이블
DROP TABLE TB_PRODUCT_UNIT;             -- 상품단위 테이블
DROP TABLE TB_PRODUCT_CATEGORY;         -- 상품타입 테이블
DROP TABLE TB_IMAGE_BRIGE;              -- 사진/다리 테이블
DROP TABLE TB_INQUIRY_ANSWER;           -- 문의답변 테이블
DROP TABLE TB_INQUIRY;                  -- 문의 테이블
DROP TABLE TB_REVIEW;                   -- 리뷰 테이블
DROP TABLE TB_MAIN_CATEGORY;            -- 메인카테고리 테이블 
DROP TABLE TB_REPLY;                    -- 댓글 테이블
DROP TABLE TB_BOARD;                    -- 자유게시판 테이블
DROP TABLE TB_MEMBER;                   -- 사용자저장 테이블 
DROP TABLE TB_MEMBER_TYPE;              -- 사용자타입 테이블


DROP SEQUENCE SEQ_MNO;      -- 회원번호 시퀀스 삭제
DROP SEQUENCE SEQ_ONO;      -- 주문결제 시퀸스 삭제
DROP SEQUENCE SEQ_INO;      -- 사진번호 시퀸스 삭제
DROP SEQUENCE SEQ_SNO;      -- 상점번호 시퀸스 삭제
DROP SEQUENCE SEQ_PNO;      -- 상품번호 시퀸스 삭제
DROP SEQUENCE SEQ_QNO;      -- 문의번호 시퀸스 삭제
DROP SEQUENCE SEQ_ANO;      -- 답변번호 시퀀스 삭제
DROP SEQUENCE SEQ_RNO;      -- 리뷰번호 시퀸스 삭제
DROP SEQUENCE SEQ_BNO;      -- 게시판번호 시퀸스 삭제
DROP sEQUENCE SEQ_BRNO;     -- 게시판댓글 시퀸스 삭제

CREATE SEQUENCE SEQ_MNO NOCACHE; -- 회원번호 시퀸스
CREATE SEQUENCE SEQ_ONO NOCACHE; -- 주문결제 시퀀스
CREATE SEQUENCE SEQ_INO NOCACHE; -- 사진번호 시퀸스
CREATE SEQUENCE SEQ_SNO NOCACHE; -- 상점번호 시퀸스
CREATE SEQUENCE SEQ_PNO NOCACHE; -- 상품번호 시퀸스
CREATE SEQUENCE SEQ_QNO NOCACHE; -- 문의번호 시퀸스
CREATE SEQUENCE SEQ_ANO NOCACHE; -- 답변번호 시퀸스
CREATE SEQUENCE SEQ_RNO NOCACHE; -- 리뷰번호 시퀸스
CREATE SEQUENCE SEQ_BNO NOCACHE; -- 게시판번호 시퀸스
CREATE SEQUENCE SEQ_BRNO; NOCACHE; --게시판댓글 시퀸스

--------------------- [ 배송금액 테이블 ] --------------------
CREATE TABLE TB_DELIVERY(
    DELIVERY_NO NUMBER PRIMARY KEY,     -- 배송비번호
    DELIVERY_PRICE NUMBER               -- 배송금액
);
COMMENT ON COLUMN TB_DELIVERY.DELIVERY_NO IS '배송비관련번호';
COMmENT ON COLUMN TB_DELIVERY.DELIVERY_PRICE IS '배송비';

INSERT INTO TB_DELIVERY VALUES(1, 0); -- 1번 무료
INSERT INTO TB_DELIVERY VALUES(2, 0); -- 2번 금액입력받을곳

-------------------- [ 상품단위 테이블 ] ----------------------
CREATE TABLE TB_PRODUCT_UNIT(
    UNIT_NO NUMBER PRIMARY KEY,         -- 상품타입번호
    UNIT_NAME VARCHAR2(20) NOT NULL     -- 타입이름
);
COMMENT ON COLUMN TB_PRODUCT_UNIT.UNIT_NO IS '상품타입번호';
COMMENT ON COLUMN TB_PRODUCT_UNIT.UNIT_NAME IS '수량타입';

INSERT INTO TB_PRODUCT_UNIT VALUES (1, '수량');
INSERT INTO TB_PRODUCT_UNIT VALUES (2, 'BOX');
INSERT INTO TB_PRODUCT_UNIT VALUES (3, 'KG');

------------------ [ 상품 카테고리 테이블 ] --------------------
CREATE TABLE TB_PRODUCT_CATEGORY(
    CATEGORY_NO NUMBER PRIMARY KEY,     -- 카테고리타입번호
    CATEGORY_NAME VARCHAR2(20) NOT NULL -- 카테고리이름
);
COMMENT ON COLUMN TB_PRODUCT_CATEGORY.CATEGORY_NO IS '상품카테고리번호';
COMMENT ON COLUMN TB_PRODUCT_CATEGORY.CATEGORY_NAME IS '상품타입';

INSERT INTO TB_PRODUCT_CATEGORY VALUES (1, '유기농채소');
INSERT INTO TB_PRODUCT_CATEGORY VALUES (2, '유기농과일');
INSERT INTO TB_PRODUCT_CATEGORY VALUES (3, '못난이채소');
INSERT INTO TB_PRODUCT_CATEGORY VALUES (4, '못난이과일');


------------------ [ 주문요청사항 테이블 ] ---------------------
CREATE TABLE TB_ORDER_REQUEST(
    REQUEST_NO NUMBER PRIMARY KEY,              -- 요청사항번호
    REQUEST_NAME VARCHAR2(20)                   -- 요청사항타입(문앞, 경비실)
);
COMMENT ON COLUMN TB_ORDER_REQUEST.REQUEST_NO IS '요청사항번호';
COMMENT ON COLUMN TB_ORDER_REQUEST.REQUEST_NAME IS '요청타입';

INSERT INTO TB_ORDER_REQUEST VALUES (1, '문앞');
INSERT INTO TB_ORDER_REQUEST VALUES (2, '경비실');
--------------------------------------------------------------------------------
---------------------------   [ 회원 관련 테이블 ]       --------------------------
--------------------------------------------------------------------------------

---------------------------- [ 회원 유형 테이블 ] --------------------------------
CREATE TABLE TB_MEMBER_TYPE(
    MB_CATEGORY_NO NUMBER PRIMARY KEY,      -- 회원유형번호
    MB_CATEGORY_NAME VARCHAR2(30)           -- 회원유형타입(관리자, 사용자)
);
COMMENT ON COLUMN TB_MEMBER_TYPE.MB_CATEGORY_NO IS '회원유형번호';
COMMENT ON COLUMN TB_MEMBER_TYPE.MB_CATEGORY_NAME IS '회원유형타입';

INSERT INTO TB_MEMBER_TYPE VALUES (1, '관리자');
INSERT INTO TB_MEMBER_TYPE VALUES (2, '판매자');
INSERT INTO TB_MEMBER_TYPE VALUES (3, '사용자');

---------------------------- [ 회원정보 테이블 ] --------------------------------
CREATE TABLE TB_MEMBER(
    MEMBER_NO NUMBER PRIMARY KEY,                                   -- 회원 번호
    MEMBER_ID VARCHAR2(20) UNIQUE NOT NULL,                         -- 회원 아이디
    MEMBER_PWD VARCHAR2(30) NOT NULL,                               -- 회원 비밀번호
    MEMBER_NAME VARCHAR2(30) NOT NULL,                              -- 회원 이름
    NICKNAME VARCHAR2(35),                                          -- 회원 닉네임
    PHONE VARCHAR2(20),                                             -- 회원 전화번호
    STATUS CHAR(1) DEFAULT 'Y' CHECK(STATUS IN('Y', 'N')),          -- 탈퇴유무
    CREATE_DATE DATE DEFAULT SYSDATE,                               -- 가입일
    MODIFY_DATE DATE DEFAULT SYSDATE,                               -- 수정일
    FK_CATEGORY_NO NUMBER,                                          -- 회원유형번호
    FOREIGN KEY(FK_CATEGORY_NO)REFERENCES TB_MEMBER_TYPE(MB_CATEGORY_NO) ON DELETE CASCADE
    -- 회원유형 연결
);
COMMENT ON COLUMN TB_MEMBER.MEMBER_NO IS '회원번호';
COMMENT ON COLUMN TB_MEMBER.MEMBER_ID IS '회원아이디';
COMMENT ON COLUMN TB_MEMBER.MEMBER_PWD IS '회원비밀번호';
COMMENT ON COLUMN TB_MEMBER.MEMBER_NAME IS '회원이름';
COMMENT ON COLUMN TB_MEMBER.NICKNAME IS '회원닉네임';
COMMENT ON COLUMN TB_MEMBER.PHONE IS '전화번호';
COMMENT ON COLUMN TB_MEMBER.STATUS IS '회원상태';
COMMENT ON COLUMN TB_MEMBER.CREATE_DATE IS '가입일';
COMMENT ON COLUMN TB_MEMBER.MODIFY_DATE IS '회원수정일';
COMMENT ON COLUMN TB_MEMBER.FK_CATEGORY_NO IS '회원유형타입';

INSERT INTO TB_MEMBER VALUES (SEQ_MNO.NEXTVAL, 'admin', '1234', '운영자', '운영자', '010-1234-5678', 'Y', SYSDATE, SYSDATE, 1);
INSERT INTO TB_MEMBER VALUES (SEQ_MNO.NEXTVAL, 'user01', '1234', '판매왕', '판매자1', '010-1234-5678', 'Y', SYSDATE, SYSDATE, 2);
INSERT INTO TB_MEMBER VALUES (SEQ_MNO.NEXTVAL, 'user02', '1234', '구매왕', '구매자1', '010-1234-5678', 'Y', SYSDATE, SYSDATE, 3);
--------------------------------------------------------------------------------
------------------------   [ 메인 카테고리 관련 테이블 ]       ----------------------
--------------------------------------------------------------------------------

---------------------------- [ 메인카테고리 테이블 ] -------------------------------
CREATE TABLE TB_MAIN_CATEGORY(
    MAIN_CATEGORY_NO NUMBER PRIMARY KEY,                -- 메인카테고리 번호
    CATEGORY_NAME VARCHAR2(50)                          -- 카테고리이름(게시글, 판매, 리뷰, 내상점)
);
COMMENT ON COLUMN TB_MAIN_CATEGORY.MAIN_CATEGORY_NO IS '메인카테고리번호';
COMMENT ON COLUMN TB_MAIN_CATEGORY.CATEGORY_NAME IS '카테고리타입';

INSERT INTO TB_MAIN_CATEGORY VALUES(1, '내상점');
INSERT INTO TB_MAIN_CATEGORY VALUES(2, '판매');
INSERT INTO TB_MAIN_CATEGORY VALUES(3, '사진');

-------------------------- [ 사진/ 게시글 다리 테이블 ] ----------------------------
CREATE TABLE TB_IMAGE_BRIGE(
    IMG_BRIGE_NO NUMBER PRIMARY KEY,                    -- 다리번호
    IMG_POST_NO NUMBER,                                  -- 각게시글 /후기
    FK_MAIN_CATEGORY_NO NUMBER,                          -- 메인카테고리번호
    
    FOREIGN KEY (FK_MAIN_CATEGORY_NO) REFERENCES TB_MAIN_CATEGORY(MAIN_CATEGORY_NO) ON DELETE CASCADE
    -- 메인카테고리 연결
);
COMMENT ON COLUMN TB_IMAGE_BRIGE.IMG_BRIGE_NO IS '연결부번호';
COMMENT ON COLUMN TB_IMAGE_BRIGE.IMG_POST_NO IS '게시글후기';
COMMENT ON COLUMN TB_IMAGE_BRIGe.FK_MAIN_CATEGORY_NO IS '메인카테고리번호';

INSERT INTO TB_IMAGE_BRIGE VALUES(1, 1, 1);


---------------------------- [ 사진저장 테이블 ] ----------------------------------
CREATE TABLE TB_ATTACHMENT(
    IMG_NO NUMBER PRIMARY KEY,                               -- 사진번호
    ORIGIN_IMG_NAME VARCHAR2(255) NOT NULL,                  -- 사진원본명
    CHANGE_IMG_NAME VARCHAR2(255) NOT NULL,                  -- 사진수정명
    IMG_PATH VARCHAR2(1000) NOT NULL,                        -- 저장폴더경로
    UPLOAD_DATE DATE DEFAULT SYSDATE,                        -- 업로드 날짜
    IMG_STATUS VARCHAR(1)CHECK (IMG_STATUS IN ('Y', 'N')),   -- 사진상태 (Y : 있 N: 없)
    IMG_LEVEL NUMBER NOT NULL,                               -- 파일레벨(1: 대표사진 2:일반사진)
    FK_IMG_BR_NO NUMBER,                                     -- 다리번호
    
    FOREIGN KEY(FK_IMG_BR_NO)REFERENCES TB_IMAGE_BRIGE(IMG_BRIGE_NO) ON DELETE CASCADE
    -- 사진 게시글다리 연결
);

INSERT INTO TB_ATTACHMENT VALUES(SEQ_INO.NEXTVAL, '원본사진', '수정사진', '경로1', SYSDATE, 'Y', 1, 1);
COMMENT ON COLUMN TB_ATTACHMENT.IMG_NO IS '사진번호';
COMMENT ON COLUMN TB_ATTACHMENT.ORIGIN_IMG_NAME IS '사진원본명';
COMMENT ON COLUMN TB_ATTACHMENT.CHANGE_IMG_NAME IS '사진수정명';
COMMENT ON COLUMN TB_ATTACHMENT.IMG_PATH IS '저장폴더경로';
COMMENT ON COLUMN TB_ATTACHMENT.UPLOAD_DATE IS '업로드날짜';
COMMENT ON COLUMN TB_ATTACHMENT.IMG_STATUS IS '사진상태';
COMMENT ON COLUMN TB_ATTACHMENT.IMG_LEVEL IS '사진레벨';
COMMENT ON COLUMN TB_ATTACHMENT.FK_IMG_BR_NO IS '연결부번호';

--------------------------------------------------------------------------------
--------------------------[ 연결된 테이블 관련 목록 ]-------------------------------
--------------------------------------------------------------------------------

----------------------------- [ 내상점 테이블 ] -----------------------------------
CREATE TABLE TB_MY_STORE(
    STORE_NO NUMBER PRIMARY KEY,             -- 상점번호
    STORE_TITLE VARCHAR2(40),                -- 상점이름
    STORE_CONTENT VARCHAR2(1000),            -- 상점소개
    STORE_COUNT NUMBER DEFAULT 0,            -- 상점조회수
    FK_MAIN_NO NUMBER,                       -- 메인카테고리
    FK_MEMBER_NO NUMBER,                     -- 회원번호 
    FOREIGN KEY(FK_MAIN_NO)REFERENCES TB_MAIN_CATEGORY(MAIN_CATEGORY_NO) ON DELETE CASCADE,
    -- 메인카테고리 연결
    FOREIGN KEY(FK_MEMBER_NO)REFERENCES TB_MEMBER(MEMBER_NO) ON DELETE CASCADE
    -- 회원정보 연결
);
COMMENT ON COLUMN TB_MY_STORE.STORE_NO IS '상점번호';
COMMENT ON COLUMN TB_MY_STORE.STORE_TITLE IS '상점이름';
COMMENT ON COLUMN TB_MY_STORE.STORE_CONTENT IS '상점소개';
COMMENT ON COLUMN TB_MY_STORE.STORE_COUNT IS '상점조회수';
COMMENT ON COLUMN TB_MY_STORE.FK_MAIN_NO IS '메인카테고리';
COMMENT ON COLUMN TB_MY_STORE.FK_MEMBER_NO IS '회원번호';

INSERT INTO TB_MY_STORE VALUES(SEQ_SNO.NEXTVAL, '감자농장', '상점소개글1', 0, 1, 1);
INSERT INTO TB_MY_STORE VALUES(SEQ_SNO.NEXTVAL, '고구마농장', '상점소개글2', 0, 1, 1);
INSERT INTO TB_MY_STORE VALUES(SEQ_SNO.NEXTVAL, '사과농장', '상점소개글3', 0, 1, 2);
INSERT INTO TB_MY_STORE VALUES(SEQ_SNO.NEXTVAL, '배농장', '상점소개글4', 0, 1, 2);

------------------------------ [ 상품 등록 테이블 ] -------------------------------
CREATE TABLE TB_PRODUCT(
    PRODUCT_NO NUMBER PRIMARY KEY,                 -- 상품등록번호
    PRODUCT_NAME VARCHAR2(120) NOT NULL,           -- 상품이름
    PRODUCT_PRICE NUMBER NOT NULL,                 -- 상품금액
    PRODUCT_CONTENT NVARCHAR2(2000) NOT NULL,      -- 상품설명
    PRODUCT_QUANTITY NUMBER NOT NULL,              -- 상품수량
    PRODUCT_COUNT NUMBER DEFAULT 0,                -- 상품조회수
    PRODUCT_DATE DATE DEFAULT SYSDATE,             -- 상품등록일
    STATUS VARCHAR(1)CHECK (STATUS IN ('Y', 'N')), -- 상품상태(삭제)
    FK_CATEGORY_NO NUMBER NOT NULL,                -- 상품카테고리(과일,야채)
    FK_UNIT_NO NUMBER NOT NULL,                    -- 상품단위(kg,box)
    FK_DELIVERY_NO NUMBER NOT NULL,                -- 배송금액 유무
    FK_STORE_NO NUMBER NOT NULL,                   -- 상점번호
    FK_MAIN_NO NUMBER NOT NULL,                    -- 메인연결(사진,리뷰)
    FOREIGN KEY(FK_CATEGORY_NO) REFERENCES TB_PRODUCT_CATEGORY(CATEGORY_NO) ON DELETE CASCADE,
    -- 상품카테고리 연결
    FOREIGN KEY(FK_UNIT_NO) REFERENCES TB_PRODUCT_UNIT(UNIT_NO) ON DELETE CASCADE,
    -- 상품타입 연결  
    FOREIGN KEY(FK_DELIVERY_NO) REFERENCES TB_DELIVERY(DELIVERY_NO) ON DELETE CASCADE,
    -- 배송비 연결   
    FOREIGN KEY(FK_STORE_NO) REFERENCES TB_MY_STORE(STORE_NO) ON DELETE CASCADE,
    -- 내상점 연결   
    FOREIGN KEY(FK_MAIN_NO) REFERENCES TB_MAIN_CATEGORY(MAIN_CATEGORY_NO) ON DELETE CASCADE
    -- 메인 카테고리 연결
);

 INSERT INTO TB_PRODUCT VALUES(SEQ_PNO.NEXTVAL, '감자', 12000, '강원도감자입니다', 1, 0, SYSDATE,'Y', 1, 1, 1, 1, 1);
 INSERT INTO TB_PRODUCT VALUES(SEQ_PNO.NEXTVAL, '고구마', 10000, '고구마입니다', 1, 0, SYSDATE,'Y', 1, 1, 1, 1, 1);
 
COMMENT ON COLUMN TB_PRODUCT.PRODUCT_NO IS '상품번호';
COMMENT ON COLUMN TB_PRODUCT.PRODUCT_NAME IS '상품이름';
COMMENT ON COLUMN TB_PRODUCT.PRODUCT_PRICE IS '상품금액';
COMMENT ON COLUMN TB_PRODUCT.PRODUCT_CONTENT IS '상품설명';
COMMENT ON COLUMN TB_PRODUCT.PRODUCT_QUANTITY IS '상품수량';
COMMENT ON COLUMN TB_PRODUCT.PRODUCT_COUNT IS '상품조회수';
COMMENT ON COLUMN TB_PRODUCT.PRODUCT_DATE IS '상품등록일';
COMMENT ON COLUMN TB_PRODUCT.STATUS IS '상품상태';
COMMENT ON COLUMN TB_PRODUCT.FK_CATEGORY_NO IS '상품카테고리';
COMMENT ON COLUMN TB_PRODUCT.FK_UNIT_NO IS '상품단위';
COMMENT ON COLUMN TB_PRODUCT.FK_DELIVERY_NO IS '배송금액유무';
COMMENT ON COLUMN TB_PRODUCT.FK_STORE_NO IS '상점번호';
COMMENT ON COLUMN TB_PRODUCT.FK_MAIN_NO IS '메인카테고리';

----------------------------- [ 주문결제 테이블 ] ---------------------------------
CREATE TABLE TB_PRODUCT_ORDER(
    ORDER_NO NUMBER PRIMARY KEY,              -- 주문결제번호
    REQUEST_LETTER VARCHAR2(100),             -- 요청메시지 
    BUY_QUANTITY NUMBER,                      -- 구매수량
    BUY_DATE DATE DEFAULT SYSDATE,            -- 결제날짜
    FK_PRODUCT_NO NUMBER,                     -- 상품번호
    FK_REQUEST_NO NUMBER,                     -- 요청번호
    FK_MEMBER_NO NUMBER,                      -- 회원번호
    
    FOREIGN KEY(FK_PRODUCT_NO)REFERENCES TB_PRODUCT ON DELETE CASCADE,
    -- 상품등록 연결
    FOREIGN KEY(FK_REQUEST_NO)REFERENCES TB_ORDER_REQUEST(REQUEST_NO) ON DELETE CASCADE,
    -- 요청사항 연결
    FOREIGN KEY(FK_MEMBER_NO)REFERENCES TB_MEMBER(MEMBER_NO) ON DELETE CASCADE
    -- 회원번호 연결
);
COMMENT ON COLUMN TB_PRODUCT_ORDER.ORDER_NO IS '주문결제번호';
COMMENT ON COLUMN TB_PRODUCT_ORDER.REQUEST_LETTER IS '요청메시지';
COMMENT ON COLUMN TB_PRODUCT_ORDER.BUY_QUANTITY IS '구매수량';
COMMENT ON COLUMN TB_PRODUCT_ORDER.BUY_DATE IS '결제날짜';
COMMENT ON COLUMN TB_PRODUCT_ORDER.FK_PRODUCT_NO IS '상품번호';
COMMENT ON COLUMN TB_PRODUCT_ORDER.FK_REQUEST_NO IS '요청타입번호';
COMMENT ON COLUMN TB_PRODUCT_ORDER.FK_MEMBER_NO IS '회원번호';

INSERT INTO TB_PRODUCT_ORDER VALUES (SEQ_ONO.NEXTVAL, '엄마몰래주세요', 1, SYSDATE, 1, 1, 1);
INSERT INTO TB_PRODUCT_ORDER VALUES (SEQ_ONO.NEXTVAL, '상품명 가려주세요', 1, SYSDATE, 1, 2, 1);

----------------------------- [ 문의사항 테이블 ] ---------------------------------

CREATE TABLE TB_INQUIRY(
    INQUIRY_NO NUMBER PRIMARY KEY,                  -- 문의글번호
    INQUIRY_TITLE VARCHAR2(50) NOT NULL,            -- 문의제목
    INQUIRY_CONTENT VARCHAR2(3000) NOT NULL,        -- 문의내용
    CREATE_DATE DATE DEFAULT SYSDATE,               -- 문의등록일
    STATUS VARCHAR(1) DEFAULT 'Y' CHECK (STATUS IN ('Y', 'N')),  -- 문의상태
    FK_MEMBER_NO NUMBER NOT NULL,                   -- 회원번호
    FOREIGN KEY(FK_MEMBER_NO) REFERENCES TB_MEMBER(MEMBER_NO) ON DELETE CASCADE -- 회원연결
);
INSERT INTO TB_INQUIRY VALUES (SEQ_QNO.NEXTVAL, '문의제목1', '문의내용1', SYSDATE, 'Y', 1);
INSERT INTO TB_INQUIRY VALUES (SEQ_QNO.NEXTVAL, '문의제목2', '문의내용2', SYSDATE, 'Y', 1);

COMMENT ON COLUMN TB_INQUIRY.INQUIRY_NO IS '문의번호';
COMMENT ON COLUMN TB_INQUIRY.INQUIRY_TITLE IS '문의제목';
COMMENT ON COLUMN TB_INQUIRY.INQUIRY_CONTENT IS '문의내용';
COMMENT ON COLUMN TB_INQUIRY.CREATE_DATE IS '문의등록일';
COMMENT ON COLUMN TB_INQUIRY.STATUS IS '문의상태';
COMMENT ON COLUMN TB_INQUIRY.FK_MEMBER_NO IS '회원번호';

----------------------------- [ 문의사항 답변 테이블 ] -----------------------------
CREATE TABLE TB_INQUIRY_ANSWER(
    INQUIRY_ANSWER_NO NUMBER PRIMARY KEY,               -- 답변번호
    INQUIRY_ANSWER VARCHAR2(3000) NOT NULL,             -- 답변내용
    WRITER VARCHAR2(30) NOT NULL,                       -- 작성자
    CREATE_DATE DATE DEFAULT SYSDATE,                   -- 작성일
    FK_INQUIRY_NO NUMBER NOT NULL,                      -- 문의번호
    FOREIGN KEY(FK_INQUIRY_NO) REFERENCES TB_INQUIRY(INQUIRY_NO) ON DELETE CASCADE -- 문의연결
);
INSERT INTO TB_INQUIRY_ANSWER VALUES (SEQ_ANO.NEXTVAL, '답변내용1', '작성자1', SYSDATE, 1);
INSERT INTO TB_INQUIRY_ANSWER VALUES (SEQ_ANO.NEXTVAL, '답변내용1', '작성자1', SYSDATE, 2);
COMMENT ON COLUMN TB_INQUIRY_ANSWER.INQUIRY_ANSWER_NO IS '답변번호';
COMMENT ON COLUMN TB_INQUIRY_ANSWER.INQUIRY_ANSWER IS '답변내용';
COMMENT ON COLUMN TB_INQUIRY_ANSWER.WRITER IS '작성자';
COMMENT ON COLUMN TB_INQUIRY_ANSWER.CREATE_DATE IS '작성일';
COMMENT ON COLUMN TB_INQUIRY_ANSWER.FK_INQUIRY_NO IS '문의번호';

----------------------------- [ 후기 테이블 ] ------------------------------------
CREATE TABLE TB_REVIEW(
    REVIEW_NO NUMBER PRIMARY KEY,                                       -- 후기번호
    REVIEW_TITLE VARCHAR2(200) NOT NULL,                                -- 후기제목
    REVIEW_CONTENT VARCHAR2(3000),                                      -- 후기내용
    RATING NUMBER NOT NULL,                                             -- 별점
    CREATE_DATE DATE DEFAULT SYSDATE,                                   -- 작성일
    STATUS CHAR(1) DEFAULT 'Y' CHECK (STATUS IN ('Y', 'N')),            -- 후기상태
    FK_MEMBER_NO NUMBER NOT NULL,                                       -- 회원번호
    FK_MAIN_NO NUMBER NOT NULL,                                         -- 메인카테고리번호
    FOREIGN KEY(FK_MEMBER_NO) REFERENCES TB_MEMBER(MEMBER_NO) ON DELETE CASCADE, -- 회원연결
    FOREIGN KEY(FK_MAIN_NO) REFERENCES TB_MAIN_CATEGORY(MAIN_CATEGORY_NO) ON DELETE CASCADE -- 메인연결
);
INSERT INTO TB_REVIEW VALUES(SEQ_RNO.NEXTVAL, '후기제목1', '후기내용1', '5', SYSDATE, 'Y', 1, 1);
INSERT INTO TB_REVIEW VALUES(SEQ_RNO.NEXTVAL, '후기제목2', '후기내용2', '4', SYSDATE, 'Y', 1, 1);
COMMENT ON COLUMN TB_REVIEW.REVIEW_NO IS '후기번호';
COMMENT ON COLUMN TB_REVIEW.REVIEW_TITLE IS '후기제목';
COMMENT ON COLUMN TB_REVIEW.REVIEW_CONTENT IS '후기내용';
COMMENT ON COLUMN TB_REVIEW.RATING IS '평점';
COMMENT ON COLUMN TB_REVIEW.CREATE_DATE IS '작성일';
COMMENT ON COLUMN TB_REVIEW.STATUS IS '후기상태';
COMMENT ON COLUMN TB_REVIEW.FK_MEMBER_NO IS '회원번호';
COMMENT ON COLUMN TB_REVIEW.FK_MAIN_NO IS '메인카테번호';
----------------------------- [ 게시판 테이블 ] -----------------------------------
CREATE TABLE TB_BOARD(
    BOARD_NO NUMBER PRIMARY KEY,                                -- 게시판번호
    BOARD_TITLE VARCHAR2(500) NOT NULL,                         -- 게시판제목
    BOARD_CONTENT VARCHAR2(4000) NOT NULL,                      -- 게시글내용
    COUNT NUMBER DEFAULT 0 NOT NULL,                            -- 조회수
    CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,                  -- 작성일
    STATUS CHAR(1) DEFAULT 'Y' CHECK(STATUS IN('Y', 'N'))       -- 상태값
);
INSERT INTO TB_BOARD VALUES (SEQ_BNO.NEXTVAL, '게시판제목1', '게시글내용1', 0, SYSDATE, 'Y');
INSERT INTO TB_BOARD VALUES (SEQ_BNO.NEXTVAL, '게시판제목2', '게시글내용2', 0, SYSDATE, 'Y');
COMMENT ON COLUMN TB_BOARD.BOARD_NO IS '게시판번호';
COMMENT ON COLUMN TB_BOARD.BOARD_TITLE IS '게시글제목';
COMMENT ON COLUMN TB_BOARD.BOARD_CONTENT IS '게시글내용';
COMMENT ON COLUMN TB_BOARD.COUNT IS '조회수';
COMMENT ON COLUMN TB_BOARD.CREATE_DATE IS '작성일';
COMMENT ON COLUMN TB_BOARD.STATUS IS '게시판상태';

----------------------------- [ 댓글 테이블 ] ------------------------------------
CREATE TABLE TB_REPLY(
    REPLY_NO NUMBER PRIMARY KEY,                                    -- 댓글번호
    REPLY_CONTENT VARCHAR2(1000) NOT NULL,                          -- 댓글내용
    CREATE_DATE DATE DEFAULT SYSDATE,                               -- 작성일
    STATUS CHAR(1) DEFAULT 'Y' CHECK (STATUS IN ('Y', 'N')),        -- 댓글상태
    FK_MEMBER_NO NUMBER NOT NULL,                                   -- 회원번호
    FK_BOARD_NO NUMBER NOT NULL,                                    -- 게시판번호
    FOREIGN KEY(FK_MEMBER_NO) REFERENCES TB_MEMBER(MEMBER_NO) ON DELETE CASCADE, -- 회원연결
    FOREIGN KEY(FK_BOARD_NO) REFERENCES TB_BOARD(BOARD_NO) ON DELETE CASCADE --게시판연결
);
INSERT INTO TB_REPLY VALUES (SEQ_BRNO.NEXTVAL, '댓글내용', SYSDATE, 'Y', 1, 1);
INSERT INTO TB_REPLY VALUES (SEQ_BRNO.NEXTVAL, '댓글내용', SYSDATE, 'Y', 2, 1);
COMMENT ON COLUMN TB_REPLY.REPLY_NO IS '댓글번호';
COMMENT ON COLUMN TB_REPLY.REPLY_CONTENT IS '댓글내용';
COMMENT ON COLUMN TB_REPLY.CREATE_DATE IS '작성일';
COMMENT ON COLUMN TB_REPLY.STATUS IS '댓글상태';
COMMENT ON COLUMN TB_REPLY.FK_MEMBER_NO IS '회원번호';
COMMENT ON COLUMN TB_REPLY.FK_BOARD_NO IS '게시판번호';
