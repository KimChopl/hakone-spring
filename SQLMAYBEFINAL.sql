-------- 배송정보 관련 -----------
CREATE TABLE TB_DELIVERY(
    DELIVERY_NO NUMBER PRIMARY KEY, -- 배송관련 설정숫자
    DELIVERY_PRICE NUMBER           -- 배송비 금액
);
COMMENT ON COLUMN TB_DELIVERY.DELIVERY_NO IS '배송비관련번호';
COMmENT ON COLUMN TB_DELIVERY.DELIVERY_PRICE IS '배송비';

------- 상품단위 관련 -------------
CREATE TABLE TB_PRODUCT_UNIT(
    UNIT_NO NUMBER PRIMARY KEY,     -- 상품단위 번호
    UNIT_NAME VARCHAR2(20)           -- 단위타입(수량, BOX, kg)
);
COMMENT ON COLUMN TB_PRODUCT_UNIT.UNIT_NO IS '상품타입번호';
COMMENT ON COLUMN TB_PRODUCT_UNIT.UNIT_NAME IS '수량타입';

------- 상품 카테고리 관련 ---------
CREATE TABLE TB_PRODUCT_CATEGORY(
    CATEGORY_NO NUMBER PRIMARY KEY, -- 카테고리 설정해줄 번호
    CATEGORY_NAME VARCHAR2(20)      -- 상품 카테고리(야채,과일등등)
);
COMMENT ON COLUMN TB_PRODUCT_CATEGORY.CATEGORY_NO IS '상품카테고리번호';
COMMENT ON COLUMN TB_PRODUCT_CATEGORY.CATEGORY_NAME IS '상품타입';

------- 주문요청 관련 -------------

CREATE TABLE TB_ORDER_REQUEST(
    REQUEST_NO NUMBER PRIMARY KEY, -- 주문요청번호
    REQUEST_NAME VARCHAR2(10) -- 요청 타입 (문앞, 경비실)

);
COMMENT ON COLUMN TB_ORDER_REQUEST.REQUEST_NO IS '요청사항번호';
COMMENT ON COLUMN TB_ORDER_REQUEST.REQUEST_NAME IS '요청타입';

-- 이용자 타입(판매 구매 관리자)
CREATE TABLE TB_MEMBER_TYPE(
    MB_CATEGORY_NO NUMBER PRIMARY KEY,
    MB_CATEGORY_NAME VARCHAR2(15) NOT NULL
);
COMMENT ON COLUMN TB_MEMBER_TYPE.MB_CATEGORY_NO IS '회원유형번호';
COMMENT ON COLUMN TB_MEMBER_TYPE.MB_CATEGORY_NAME IS '회원유형타입';

-- 메인 카테고리
CREATE TABLE TB_MAIN_CATEGORY(
    MAIN_CATEGORY_NO NUMBER PRIMARY KEY,
    CATEGORY_NAME VARCHAR2(50) NOT NULL
);
COMMENT ON COLUMN TB_MAIN_CATEGORY.MAIN_CATEGORY_NO IS '메인카테고리번호';
COMMENT ON COLUMN TB_MAIN_CATEGORY.CATEGORY_NAME IS '카테고리타입';


-- 농장 체험 목록(과일 따기 감자 캐기 등등)
CREATE TABLE TB_FARM_PRODUCT(
    PRODUCT_NO NUMBER PRIMARY KEY,
    PRODUCT_NAME VARCHAR2(45) NOT NULL UNIQUE
);

-- 부대시설
CREATE TABLE TB_FACILITY(
    FACILITY_NO NUMBER PRIMARY KEY,
    FACILITY_NAME VARCHAR2(60) NOT NULL UNIQUE
);

---------------------------- [ 회원정보 테이블 ] --------------------------------
CREATE TABLE TB_MEMBER(
    MEMBER_NO NUMBER PRIMARY KEY,                                   -- 회원 번호
    MEMBER_ID VARCHAR2(20) UNIQUE NOT NULL,                         -- 회원 아이디
    MEMBER_PWD VARCHAR2(100) NOT NULL,                               -- 회원 비밀번호
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

------------ 상품주문 관련 -------------------
CREATE TABLE TB_PRODUCT(
    PRODUCT_NO NUMBER PRIMARY KEY,                  -- 상품번호
    PRODUCT_NAME VARCHAR2(120) NOT NULL,            -- 상품명
    PRODUCT_PRICE NUMBER NOT NULL,                  -- 상품가격
    PRODUCT_CONTENT NVARCHAR2(2000) NOT NULL,       -- 상품설명
    PRODUCT_NUMBER NUMBER NOT NULL,                 -- 상품수량
    PRODUCT_HITS NUMBER DEFAULT 0,                            -- 상품 조회수
    PRODUCT_DATE DATE DEFAULT SYSDATE,              -- 상품 등록일
    DELIVERY_TYPE NUMBER,                           -- 배송비정보(있다,없다)
    CATEGORY_TYPE NUMBER,                           -- 상품카테고리(야채,과일 등등)
    STRORE_NO NUMBER,                               -- 상점번호
    UNIT_NO NUMBER,                                 -- 수량타입(KG,BOX,수량)
    MAIN_CATEGORY_NO NUMBER DEFAULT 2 NOT NULL CHECK(MAIN_CATEGORY_NO = 2),
    FOREIGN KEY (CATEGORY_TYPE) REFERENCES TB_PRODUCT_CATEGORY(CATEGORY_NO) ON DELETE CASCADE,
    -- 상품카테고리와 연결
    FOREIGN KEY (DELIVERY_TYPE) REFERENCES TB_DELIVERY(DELIVERY_NO) ON DELETE CASCADE,
    -- 배송정보관련이랑 연결
    FOREIGN KEY (UNIT_NO) REFERENCES TB_PRODUCT_UNIT(UNIT_NO) ON DELETE CASCADE,
    -- 상품단위 연결
    FOREIGN KEY (STRORE_NO) REFERENCES TB_MY_STORE(STORE_NO) ON DELETE CASCADE
    -- 나의상점 연결 
);

DROP TABLE TB_PRODUCT_ORDER;

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

CREATE TABLE TB_STATE_CATEGORY(
    STATE_CODE CHAR(3) PRIMARY KEY,
    STATE_NAME VARCHAR2(30) NOT NULL
);


-- 주소
CREATE TABLE TB_ADDRESS(
    ADDRESS_NO NUMBER PRIMARY KEY,
    STATE_CODE CHAR(3) NOT NULL REFERENCES TB_STATE_CATEGORY,
    MEMBER_NO NUMBER NOT NULL REFERENCES TB_MEMBER,
    ADDRESS_TYPE NUMBER DEFAULT 1 NOT NULL CHECK(ADDRESS_TYPE IN(1, 2)),
    DISTRICT VARCHAR2(300) NOT NULL
);

-- 농장 정보
CREATE TABLE TB_FARM(
    FARM_NO NUMBER PRIMARY KEY,
    SELLER_NO NUMBER NOT NULL REFERENCES TB_MEMBER,
    CATEGORY_NO NUMBER DEFAULT 3 NOT NULL CHECK(CATEGORY_NO = 3) REFERENCES TB_MAIN_CATEGORY,
    FARM_PRODUCT_NO NUMBER NOT NULL REFERENCES TB_FARM_PRODUCT,
    FARM_TITLE VARCHAR2(150) NOT NULL,
    FARM_CONTENT VARCHAR2(4000) NOT NULL,
    FARM_CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
    BEWARE_LIST VARCHAR2(4000),
    DELETE_ASK CHAR(1) DEFAULT 'N' NOT NULL CHECK(DELETE_ASK IN('N', 'Y')),
    FARM_COUNT NUMBER DEFAULT 0 NOT NULL,
    FARM_PRICE NUMBER DEFAULT 0 NOT NULL,
    FARM_MODIFY_DATE DATE,
    FARM_ADDRESS_NO NUMBER NOT NULL REFERENCES TB_ADDRESS
);


-- 농장 관심 목록
CREATE TABLE TB_FARM_ATTENTION(
    ATT_USER_NO NUMBER REFERENCES TB_MEMBER,
    ATT_BY_FARM NUMBER REFERENCES TB_FARM,
    ATT_DATE DATE DEFAULT SYSDATE NOT NULL,
    PRIMARY KEY (ATT_USER_NO, ATT_BY_FARM)
);

-- 농장 좋아요
CREATE TABLE TB_FARM_LIKE(
    LIKE_USER_NO NUMBER REFERENCES TB_MEMBER,
    LIKE_BY_FARM NUMBER REFERENCES TB_FARM,
    GOOD_DATE DATE DEFAULT SYSDATE NOT NULL,
    PRIMARY KEY (LIKE_USER_NO, LIKE_BY_FARM)
);

-- 부대시설 다리
CREATE TABLE TB_FAC_BRIGE(
    BR_FACILITY_NO NUMBER REFERENCES TB_FACILITY,
    BR_FARM_NO NUMBER REFERENCES TB_FARM,
    PRIMARY KEY (BR_FACILITY_NO, BR_FARM_NO)
);

-- 리뷰
CREATE TABLE TB_REVIEW(
    REVIEW_NO NUMBER PRIMARY KEY,
    REVIEW_MB_NO NUMBER NOT NULL REFERENCES TB_MEMBER,
    REVIEW_CA_NO NUMBER NOT NULL REFERENCES TB_MAIN_CATEGORY,
    REVIEW_TITLE VARCHAR2(200) NOT NULL,
    REVIEW_CONTENT VARCHAR2(3000),
    RATING NUMBER DEFAULT 0 NOT NULL CHECK (RATING IN(0,1,2,3,4,5)),
    REVIEW_POST_NO NUMBER NOT NULL,
    REVIEW_CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
    REVIEW_STATUS CHAR(1) DEFAULT 'Y' NOT NULL CHECK(REVIEW_STATUS IN ('Y', 'N'),
    REVIEW_MODIFY_DATE DATE
);
ALTER TABLE TB_REVIEW MODIFY REVIEW_CA_NO DEFAULT 4 CHECK(REVIEW_CA_NO = 4);

-- 이미지 다리
CREATE TABLE TB_IMAGE_BRIGE(
    IMG_BRIGE_NO NUMBER PRIMARY KEY,
    IMG_CA_NO NUMBER NOT NULL REFERENCES TB_MAIN_CATEGORY,
    IMG_POST_NO NUMBER NOT NULL
);

-- 사진 테이블(게시글, 리뷰, 판매, 체험 등등)
CREATE TABLE TB_IMAGE(
    IMG_NO NUMBER PRIMARY KEY,
    ORIGIN_IMG_NAME VARCHAR2(255) NOT NULL,
    CHANGE_IMG_NAME VARCHAR2(255) NOT NULL,
    UPLOAD_DATE DATE DEFAULT SYSDATE NOT NULL,
    IMG_STATUS CHAR(1) DEFAULT 'Y' NOT NULL CHECK(IMG_STATUS IN('Y', 'N')),
    IMG_LEVEL NUMBER DEFAULT 2 NOT NULL CHECK(IMG_LEVEL IN(1,2)),
    IMG_BR_NO NUMBER NOT NULL REFERENCES TB_IMAGE_BRIGE
);

-- 예약 테이블
CREATE TABLE TB_BOOK(
    BOOK_NO NUMBER PRIMARY KEY,
    BOOK_FARM_NO NUMBER NOT NULL REFERENCES TB_FARM,
    BOOK_USER_NO NUMBER NOT NULL REFERENCES TB_MEMBER,
    BOOK_DATE DATE DEFAULT SYSDATE NOT NULL,
    PLAY_DATE DATE NOT NULL,
    BOOK_CHECK CHAR(1) DEFAULT 'N' NOT NULL CHECK(BOOK_CHECK IN ('N', 'Y')),
    BOOK_CANCEL CHAR(1) DEFAULT 'N' NOT NULL CHECK(BOOK_CANCEL IN ('N', 'Y')),
    BOOK_PAY CHAR(1) DEFAULT 'N' NOT NULL CHECK(BOOK_PAY IN('N', 'Y')),
    PLAY_CHECK CHAR(1) DEFAULT 'N' NOT NULL CHECK(PLAY_CHECK IN('N', 'Y')),
    BOOK_COMPLETE CHAR(1) DEFAULT 'N' NOT NULL CHECK(BOOK_COMPLETE IN ('N','Y')),
    ADULT_NO NUMBER DEFAULT 0,
    KID_NO NUMBER DEFAULT 0,
    DELETE_PLAYER CHAR(1) DEFAULT 'N' NOT NULL CHECK(DELETE_PLAYER IN('N', 'Y')),
    DELETE_SELLER CHAR(1) DEFAULT 'N' NOT NULL CHECK(DELETE_SELLER IN('N', 'Y'))
);

-- 메세지 테이블(뭘 보냈는지)
CREATE TABLE TB_MANGE_MESSAGE(
    MESSAGE_NO NUMBER PRIMARY KEY,
    MANGERT_NO NUMBER NOT NULL REFERENCES TB_MEMBER,
    MESSAGE_TITLE VARCHAR2(150) NOT NULL,
    MESSAGE_CONTENT VARCHAR2(4000) NOT NULL,
    SEND_DATE DATE DEFAULT SYSDATE NOT NULL
);

-- 메세지 보낸 후 저장 테이블(누가 받았는지)
CREATE TABLE TB_MESSAGE_BRIGE(
    BRIGE_MSG_NO NUMBER NOT NULL REFERENCES TB_MANGE_MESSAGE,
    BRIGE_MB_NO NUMBER NOT NULL REFERENCES TB_MEMBER,
    READ_MESSAGE CHAR(1) DEFAULT 'N' NOT NULL,
    DELETE_STATUS CHAR(1) DEFAULT 'N' NOT NULL
);







-- 자유게시판
CREATE TABLE TB_BOARD(
    BOARD_NO NUMBER PRIMARY KEY,
    BOARD_WRITER NUMBER NOT NULL REFERENCES TB_MEMBER,
    MAIN_CATEGORY_NO NUMBER NOT NULL REFERENCES TB_MAIN_CATEGORY,
    BOARD_TITLE VARCHAR2(500) NOT NULL,
    BOARD_CONTENT NVARCHAR2(2000) NOT NULL,
    COUNT NUMBER DEFAULT 0 NOT NULL,
    CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
    MODIFY_DATE DATE DEFAULT SYSDATE,
    STATUS CHAR(1) DEFAULT 'Y' NOT NULL CHECK(STATUS IN ('Y', 'N'))
);
ALTER TABLE TB_BOARD MODIFY MAIN_CATEGORY_NO DEFAULT 1 CHECK(MAIN_CATEGORY_NO = 1);

-- 댓글
CREATE TABLE TB_REPLY(
    REPLY_NO NUMBER PRIMARY KEY,
    REF_BNO NUMBER NOT NULL REFERENCES TB_BOARD,
    REPLY_WRITER NUMBER NOT NULL REFERENCES TB_MEMBER,
    REPLY_CONTENT VARCHAR2(1000) NOT NULL,
    CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
    STATUS CHAR(1) DEFAULT 'Y' NOT NULL CHECK(STATUS IN ('Y', 'N'))
);
ALTER TABLE TB_REPLY ADD MODIFY_DATE DATE DEFAULT SYSDATE;

----------------------------- [ 문의사항 테이블 ] ---------------------------------
DROP TABLE TB_INQUIRY;

CREATE TABLE TB_INQUIRY(
    INQUIRY_NO NUMBER NOT NULL PRIMARY KEY,                  -- 문의글번호
    INQUIRY_TITLE VARCHAR2(50) NOT NULL,            -- 문의제목
    INQUIRY_CONTENT VARCHAR2(3000) NOT NULL,        -- 문의내용
    CREATE_DATE DATE DEFAULT SYSDATE,               -- 문의등록일
    STATUS VARCHAR(1) DEFAULT 'Y' CHECK (STATUS IN ('Y', 'N')),  -- 문의상태
    FK_MEMBER_NO NUMBER NOT NULL,                   -- 회원번호
    FOREIGN KEY(FK_MEMBER_NO) REFERENCES TB_MEMBER(MEMBER_NO) ON DELETE CASCADE -- 회원연결
);

COMMENT ON COLUMN TB_INQUIRY.INQUIRY_NO IS '문의번호';
COMMENT ON COLUMN TB_INQUIRY.INQUIRY_TITLE IS '문의제목';
COMMENT ON COLUMN TB_INQUIRY.INQUIRY_CONTENT IS '문의내용';
COMMENT ON COLUMN TB_INQUIRY.CREATE_DATE IS '문의등록일';
COMMENT ON COLUMN TB_INQUIRY.STATUS IS '문의상태';
COMMENT ON COLUMN TB_INQUIRY.FK_MEMBER_NO IS '회원번호';

----------------------------- [ 문의사항 답변 테이블 ] -----------------------------
DROP TABLE TB_INQUIRY_ANWSER;

CREATE TABLE TB_INQUIRY_ANSWER(
    INQUIRY_ANSWER_NO NUMBER PRIMARY KEY,               -- 답변번호
    INQUIRY_ANSWER VARCHAR2(3000) NOT NULL,             -- 답변내용
    WRITER NUMBER NOT NULL REFERENCES TB_MEMBER,                       -- 작성자
    CREATE_DATE DATE DEFAULT SYSDATE,                   -- 작성일
    FK_INQUIRY_NO NUMBER NOT NULL REFERENCES TB_INQUIRY
);
COMMENT ON COLUMN TB_INQUIRY_ANSWER.INQUIRY_ANSWER_NO IS '답변번호';
COMMENT ON COLUMN TB_INQUIRY_ANSWER.INQUIRY_ANSWER IS '답변내용';
COMMENT ON COLUMN TB_INQUIRY_ANSWER.WRITER IS '작성자';
COMMENT ON COLUMN TB_INQUIRY_ANSWER.CREATE_DATE IS '작성일';
COMMENT ON COLUMN TB_INQUIRY_ANSWER.FK_INQUIRY_NO IS '문의번호';

-- 이용자 프로필사진
CREATE TABLE TB_MRMBER_IMAGE(
    MEMBER_IMG_NO NUMBER PRIMARY KEY,
    MEMBER_NO NUMBER NOT NULL REFERENCES TB_MEMBER,
    ORIGIN_IMG_NAME VARCHAR2(255) NOT NULL,
    CHANGE_IMG_NAME VARCHAR2(255) NOT NULL,
    UPLOAD_DATE DATE DEFAULT SYSDATE NOT NULL,
    IMG_STATUS CHAR(1) DEFAULT 'Y' NOT NULL CHECK(IMG_STATUS IN('Y', 'N')),
    IMG_LEVEL NUMBER DEFAULT 2 NOT NULL CHECK(IMG_LEVEL IN(1,2))
);

-- 게시글 좋아요
CREATE TABLE TB_BOARD_LIKE(
    BOARD_NO NUMBER REFERENCES TB_BOARD,
    MEMBER_LIKE_NO NUMBER REFERENCES TB_MEMBER,
    PRIMARY KEY(BOARD_NO, MEMBER_LIKE_NO)
);

-- 댓글 좋아요
CREATE TABLE TB_REPLY_LIKE(
    REPLY_NO NUMBER REFERENCES TB_REPLY,
    MEMBER_LIKE_NO NUMBER REFERENCES TB_MEMBER,
    PRIMARY KEY(REPLY_NO, MEMBER_LIKE_NO)
);

-- 장바구니
CREATE TABLE TB_CART(
    PRODUCT_NO NUMBER NOT NULL REFERENCES TB_PRODUCT,
    MEMBER_NO NUMBER NOT NULL REFERENCES TB_MEMBER,
    PRIMARY KEY(PRODUCT_NO, MEMBER_NO)
);

CREATE TABLE TB_REPORT_CATEGORY(
    REPORT_NO NUMBER PRIMARY KEY,
    REPORT_NAME VARCHAR2(50) NOT NULL
);

CREATE TABLE TB_REPORT (
	REPORT_NO	NUMBER		NOT NULL PRIMARY KEY,
	REPORTER_NO	NUMBER		NOT NULL REFERENCES TB_MEMBER,
	ATTACKER_NO	NUMBER		REFERENCES TB_MEMBER,
	REPORT_TITLE	VARCHAR2(150)		NOT NULL,
	REPORT_CONTENT	NVARCHAR2(2000)		NOT NULL,
	REPORT_DATE	DATE	DEFAULT SYSDATE	NOT NULL,
	RESPONSE_TITLE	VARCHAR2(250)		NULL,
	RESPONSE_CONTENT	NVARCHAR2(2000)		NULL,
	RESPONSE_DATE	DATE		NULL,
    REPORT_TYPE NUMBER NOT NULL REFERENCES TB_REPORT_CATEGORY
);

COMMIT;
