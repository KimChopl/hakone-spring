
DROP TABLE TB_PRODUCT;
DROP TABLE TB_DELIVERY;
DROP TABLE TB_PRODUCT_UNIT;
DROP TABLE TB_MY_STORE;
DROP TABLE TB_PRODUCT_ORDER;
DROP TABLE TB_ORDER_REQUEST;
DROP TABLE TB_PRODUCT_CATEGORY;
DROP TABLE TB_MEMBER;
DROP TABLE TB_MEMBER_TYPE;
DROP TABLE TB_MAIN_CATEGORY;
DROP TABLE TB_IMAGE_BRIGE;
DROP TABLE TB_ATTACHMENT;


DROP SEQUENCE SEQ_PNO; -- 상품등록 발생시킬 시퀸스
DROP SEQUENCE SEQ_SNO; -- 내상점 발생시킬 시퀸스
DROP SEQUENCE SEQ_ONO; -- 주문결제 발생시킬 시퀸스
DROP SEQUENCE SEQ_MNO; -- 회원번호 발생시킬 시퀸스
DROP SEQUENCE SEQ_INO; -- 사진저장 발생시킬 시퀸스


------------ 상품주문 관련 -------------------
CREATE TABLE TB_PRODUCT(
    PRODUCT_NO NUMBER PRIMARY KEY,                  -- 상품번호
    PRODUCT_NAME VARCHAR2(120) NOT NULL,            -- 상품명
    PRODUCT_PRICE NUMBER NOT NULL,                  -- 상품가격
    PRODUCT_CONTENT NVARCHAR2(2000) NOT NULL,       -- 상품설명
    PRODUCT_NUMBER NUMBER NOT NULL,                 -- 상품수량
    PRODUCT_HITS NUMBER,                            -- 상품 조회수
    PRODUCT_DATE DATE DEFAULT SYSDATE,              -- 상품 등록일
    DELIVERY_TYPE NUMBER,                           -- 배송비정보(있다,없다)
    CATEGORY_TYPE NUMBER,                           -- 상품카테고리(야채,과일 등등)
    MEMBER_NO NUMBER,                               -- 회원번호
    STRORE_NO NUMBER,                               -- 상점번호
    UNIT_NO NUMBER,                                 -- 수량타입(KG,BOX,수량)
    MAIN_CATEGORY NUMBER,                           -- 메인카테고리(사진,리뷰 등등)
    FOREIGN KEY (CATEGORY_TYPE) REFERENCES TB_PRODUCT_CATEGORY(CATEGORY_NO) ON DELETE CASCADE,
    -- 상품카테고리와 연결
    FOREIGN KEY (DELIVERY_TYPE) REFERENCES TB_DELIVERY(DELIVERY_NO) ON DELETE CASCADE,
    -- 배송정보관련이랑 연결
    FOREIGN KEY (MEMBER_NO) REFERENCES TB_MBMER(MEMBER_NO) ON DELETE CASCADE,
    -- 상품과 회원번호 연결
    FOREIGN KEY (UNIT_NO) REFERENCES TB_PRODUCT_UNIT(UNIT_NO) ON DELETE CASCADE,
    -- 상품단위 연결
    FOREIGN KEY (STRORE_NO) REFERENCES TB_PRODUCT_ORDER(STRORE_NO) ON DELETE CASCADE,
    -- 나의상점 연결 
    FOREIGN KEY (MAIN_CATEGORY) REFERENCES TB_MAIN_CATEGORY(MAIN_CATEGORY_NO) ON DELETE CASCADE
);

-------- 배송정보 관련 -----------
CREATE TABLE TB_DELIVERY(
    DELIVERY_NO NUMBER PRIMARY KEY, -- 배송관련 설정숫자
    DELIVERY_PRICE NUMBER           -- 배송비 금액
);

------- 상품단위 관련 -------------
CREATE TABLE TB_PRODUCT_UNIT(
    UNIT_NO NUMBER PRIMARY KEY,     -- 상품단위 번호
    UNIT_NAME VARCHAR2(20)           -- 단위타입(수량, BOX, kg)
);

------- 상품 카테고리 관련 ---------
CREATE TABLE TB_PRODUCT_CATEGORY(
    CATEGORY_NO NUMBER PRIMARY KEY, -- 카테고리 설정해줄 번호
    CATEGORY_NAME VARCHAR2(20)      -- 상품 카테고리(야채,과일등등)
);

-------- 주문결제 관련 -----------
CREATE TABLE TB_PRODUCT_ORDER(
    ORDER_NO PRIMARY KEY,               -- 주문결제 번호
    REQUEST_LETTER VARCHAR2(50),        -- 주문 요청사항(문앞이요)
    BUY_COUNT NUMBER NOT NULL,          -- 구매수량
    BUY_DATE DATE DEFAULT SYSDATE,      -- 주문일자
    REQUEST_TYPE NUMBER,                -- 주문요청사항
    FOREIGN KEY(REQUEST_TYPE) REFERENCES TB_ORDER_REQUEST(REQUEST_NO) ON DELETE CASCADE
    -- 주문요청테이블과 연결
);

------- 주문요청 관련 -------------

CREATE TABLE TB_ORDER_REQUEST(
    REQUEST_NO NUMBER PRIMARY KEY, -- 주문요청번호
    REQUEST_NAME VARCHAR2(10) -- 요청 타입 (문앞, 경비실)

);
----------- 사용자 관련 --------------------
CREATE TABLE TB_MEMBER(
    MEMBER_NO NUMBER PRIMARY KEY,               -- 회원번호
    CATEGORY_NO NUMBER NOT NULL,                -- 회원유형번호
    MEMBER_ID VARCHAR2(20) UNIQUE NOT NULL,     -- 회원 아이디
    MBMER_PWD VARCHAR2(25) NOT NULL,            -- 회원 비밀번호
    NICKNAME VARCHAR2(35) UNIQUE NOT NULL,      -- 회원 별명
    MEMBER_NAME VARCHAR2(20) NOT NULL,          -- 회원 성함
    PHONE VARCHAR2(20),                         -- 회원 전화번호
    STATUS NUMBER DEFAULT 1 NOT NULL CHECK (STATUS IN (1, 2)),  -- 회원 탈퇴유무
    CREATE_DATE DEFAULT SYSDATE,               -- 사용자 생성일
    FOREIGN KEY(CATEGORY_NO)REFERENCES TB_MEMBER_TYPE(MB_CATEGORY_NO) ON DELETE CASCADE
    -- 회원유형번호와 회원유형 테이블 넘버와 연결
);
----------- 회원 유형 관련 ---------------------
CREATE TABLE TB_MEMBER_TYPE(
    MB_CATEGORY_NO NUMBER PRIMARY KEY, -- 회원 유형번호
    MB_CATEGORY_NAME VARCHAR2(20) NOT NULL -- 유형 타입(관리자, 구매자, 판매자, 정지)
);

------ 메인 카테고리(사진,리뷰등등)---------
CREATE TABLE TB_MAIN_CATEGORY(
    MAIN_CATEGORY_NO NUMBER PRIMARY KEY, -- 카테고리번호
    CATEGORY_NAME VARCHAR2(50) NOT NULL -- 카테고리 타입(게시글, 판매, 체험, 리뷰, 내상점)
);

------ 사진 게시글 다리 --------------

CREATE TABLE TB_IMAGE_BRIGE(
    IMG_BRIGE_NO NUMBER PRIMARY KEY, -- 다리번호
    IMG_CA_NO NUMBER NOT NULL, -- 카테고리번호
    IMG_POST_NO NUMBER NOT NULL, -- 각 게시글/후기번호
    FOREIGN KEY(IMG_CA_NO)REFERENCES TB_MAIN_CATEGORY(MAIN_CATEGORY_NO) ON DELETE CASCADE
    -- 카테고리번호와 메인카테고리 테이블 카테고리번호와 연결
);

----------- 사진저장 -------------------
CREATE TABLE TB_ATTACHMENT(
    IMG_NO NUMBER PRIMARY KEY,              -- 사진 번호
    ORIGIN_IMG_NAME VARCHAR2(255) NOT NULL, -- 사진 원본명
    CHANGE_IMG_NAME VARCHAR2(255) NOT NULL, -- 사진 수정명
    IMG_PATH VARCHAR2(1000) NOT NULL,       -- 저장폴더 경로
    UPLOAD_DATE DATE DEFAULT SYSDATE,       -- 업로드 날짜
    IMG_STATUS CHAR(1) DEFAULT 'Y' NOT NULL CHECK (IMG_STATUS IN ('Y', 'N')), -- 파일 상태
    IMG_LEVEL NUMBER NOT NULL,              -- 대표 1 서브2
    IMG_BR_NO NUMBER NOT NULL,              -- 다리번호
    FOREIGN KEY(IMG_BR_NO)REFERENCES TB_IMAGE_BRIGE(IMG_BRIGE_NO) ON DELETE CASCADE 
    -- 다리번호와 사진게시글 다리테이블과 연결
);

--------- 리뷰 작성 --------------

CREATE TABLE TB_REVIEW(
    REVIEW_NO NUMBER PRIMARY KEY,            -- 리뷰번호
    REVIEW_MB_NO NUMBER NOT NULL,            -- 회원번호
    REVIEW_CA_NO NUMBER NOT NULL,            -- 카테고리번호
    REVIEW_TITLE VARCHAR2(200) NOT NULL,     -- 리뷰제목
    REVIEW_CONTENT VARCHAR2(3000) NOT NULL,  -- 리뷰내용
    RATING NUMBER NOT NULL,                  -- 별점
    REVIEW_POST_NO NUMBER NOT NULL           -- 각게시물 번호
);















