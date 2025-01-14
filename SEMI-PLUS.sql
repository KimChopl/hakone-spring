


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
    FOREIGN KEY (CATEGORY_TYPE) REFERENCES TB_PRODUCT_CATEGORY(CATEGORY_NO) ON DELETE CASCADE,
    -- 상품카테고리와 연결
    FOREIGN KEY (DELIVERY_TYPE) REFERENCES TB_DELIVERY(DELIVERY_NO) ON DELETE CASCADE,
    -- 배송정보관련이랑 연결
    FOREIGN KEY (UNIT_NO) REFERENCES TB_PRODUCT_UNIT(UNIT_NO) ON DELETE CASCADE,
    -- 상품단위 연결
    FOREIGN KEY (STRORE_NO) REFERENCES TB_MY_STORE(STORE_NO) ON DELETE CASCADE
    -- 나의상점 연결 
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
    ORDER_NO NUMBER PRIMARY KEY,               -- 주문결제 번호
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

--  내상점
CREATE TABLE TB_MY_STORE(
    STORE_NO NUMBER PRIMARY KEY,
    MEMBER_NO NUMBER NOT NULL REFERENCES TB_MEMBER,
    MAIN_CATEGORY_NO NUMBER NOT NULL REFERENCES TB_MAIN_CATEGORY,
    STORE_TITLE VARCHAR2(60) NOT NULL,
    STORE_CONTENT VARCHAR2(4000) NOT NULL,
    STORE_COUNT NUMBER DEFAULT 0 NOT NULL
);

-- 이용자 타입(판매 구매 관리자)
CREATE TABLE TB_MEMBER_TYPE(
    MB_CATEGORY_NO NUMBER PRIMARY KEY,
    MB_CATEGORY_NAME VARCHAR2(15) NOT NULL
);

-- 이용자 정보
CREATE TABLE TB_MEMBER(
    MEMBER_NO NUMBER PRIMARY KEY,
    CATEGORY_NO NUMBER NOT NULL REFERENCES TB_MEMBER_TYPE,
    MEMBER_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEMBER_PWD VARCHAR2(25) NOT NULL,
    NICKNAME VARCHAR2(35) NOT NULL,
    MEMBER_NAME VARCHAR2(30) NOT NULL,
    PHONE VARCHAR2(20),
    STATUS NUMBER DEFAULT 0 NOT NULL CHECK(STATUS IN (0, 1)),
    CREATE_DATE DATE DEFAULT SYSDATE NOT NULL
);

-- 메인 카테고리
CREATE TABLE TB_MAIN_CATEGORY(
    MAIN_CATEGORY_NO NUMBER PRIMARY KEY,
    CATEGORY_NAME VARCHAR2(50) NOT NULL
);

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

-- 농장 정보
CREATE TABLE TB_FARM(
    FARM_NO NUMBER PRIMARY KEY,
    SELLER_NO NUMBER NOT NULL REFERENCES TB_MEMBER,
    CATEGORY_NO NUMBER NOT NULL REFERENCES TB_MAIN_CATEGORY,
    FARM_PRODUCT_NO NUMBER NOT NULL REFERENCES TB_FARM_PRODUCT,
    FARM_TITLE VARCHAR2(150) NOT NULL,
    FARM_CONTENT VARCHAR2(4000) NOT NULL,
    FARM_CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
    BEWARE_LIST VARCHAR2(4000),
    DELETE_ASK CHAR(1) DEFAULT 'N' NOT NULL CHECK(DELETE_ASK IN('N', 'Y')),
    FARM_COUNT NUMBER DEFAULT 0 NOT NULL,
    FARM_PRICE NUMBER DEFAULT 0 NOT NULL,
    FARM_MODIFT_DATE DATE
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
INSERT
  INTO
       TB_FARM_LIKE
VALUES
       (4,1,SYSDATE);
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
    REVIEW_CONTENT VARCHAR2(2000),
    RATING NUMBER DEFAULT 0 NOT NULL CHECK (RATING IN(1,2,3,4,5)),
    REVIEW_POST_NO NUMBER NOT NULL
);

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

-- 주소 카테고리(도 / 광역시)
CREATE TABLE TB_STATE_CATEGORY(
    STATE_CODE CHAR(3) NOT NULL PRIMARY KEY,
    STATE_NAME VARCHAR2(20) NOT NULL
);

-- 주소
CREATE TABLE TB_ADDRESS(
    ADDRESS_NO NUMBER PRIMARY KEY,
    STATE_CODE CHAR(3) NOT NULL REFERENCES TB_STATE_CATEGORY,
    MEMBER_NO NUMBER NOT NULL REFERENCES TB_MEMBER,
    ADDRESS_TYPE NUMBER DEFAULT 1 NOT NULL CHECK(ADDRESS_TYPE IN(1, 2)),
    DISTRICT VARCHAR2(300) NOT NULL
);

ALTER TABLE TB_MEMBER ADD MODIFY_DATE DATE DEFAULT SYSDATE;


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

-- 문의사항
CREATE TABLE TB_INQUIRY(
    INQUIRY_NO NUMBER PRIMARY KEY,
    INQUIRY_WRITER NUMBER NOT NULL REFERENCES TB_MEMBER,
    INQUIRY_TITLE VARCHAR2(150) NOT NULL,
    INQUIRY_CONTENT VARCHAR2(4000) NOT NULL,
    CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
    MODIFY_DATE DATE DEFAULT SYSDATE,
    STATUS CHAR(1) DEFAULT 'Y' NOT NULL CHECK(STATUS IN ('Y', 'N'))
);

-- 문의사항 답변
CREATE TABLE TB_INQUIRY_ANSWER(
    INQUIRY_ANSWER_NO NUMBER PRIMARY KEY,
    INQUIRY_ANSWER VARCHAR2(4000) NOT NULL,
    REF_INO NUMBER NOT NULL REFERENCES TB_INQUIRY,
    WRITER CHAR(50) NOT NULL,
    CREATE_DATE DATE DEFAULT SYSDATE NOT NULL
);

-- 이용자 프로필사진(내상점 대표사진)
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


COMMIT;

COMMENT ON COLUMN "TB_MEMBER"."MEMBER_NO" IS '시퀀스로 설정예정';

COMMENT ON COLUMN "TB_MEMBER"."CATEGORY_NO" IS '1/2/3';

COMMENT ON COLUMN "TB_MEMBER"."MEMBER_ID" IS 'UNIQUE제약 설정';

COMMENT ON COLUMN "TB_MEMBER"."NICKNAME" IS '작성 안하면 아이디로 설정';

COMMENT ON COLUMN "TB_MEMBER"."STATUS" IS '탈퇴유무';
COMMENT ON COLUMN "TB_BOARD"."STATUS" IS '있으면 Y, 지워지면 N';
COMMENT ON COLUMN "TB_PRODUCT_ORDER"."ORDER_NO" IS '결제번호';

COMMENT ON COLUMN "TB_PRODUCT_ORDER"."REQUEST_LETTER" IS '요청메시지';

COMMENT ON COLUMN "TB_PRODUCT_ORDER"."BUY_COUNT" IS '구매수량';

COMMENT ON COLUMN "TB_PRODUCT_ORDER"."BUY_DATE" IS '구매일자';

COMMENT ON COLUMN "TB_PRODUCT_ORDER"."PRODUCT_NO" IS '상품번호';

COMMENT ON COLUMN "TB_PRODUCT_ORDER"."REQUSET_NO" IS '요청번호';

COMMENT ON COLUMN "TB_PRODUCT_ORDER"."MEMBER_NO" IS '회원번호';

COMMENT ON COLUMN "TB_MY_STORE"."STORE_NO" IS '상점번호';

COMMENT ON COLUMN "TB_MY_STORE"."MEMBER_NO" IS '시퀀스로 설정예정';

COMMENT ON COLUMN "TB_MY_STORE"."MAIN_CATEGORY_NO" IS '메인카테고리연결';

COMMENT ON COLUMN "TB_MY_STORE"."STORE_TITLE" IS '상점명';

COMMENT ON COLUMN "TB_MY_STORE"."STORE_CONTENT" IS '상점설명';

COMMENT ON COLUMN "TB_MY_STORE"."STORE_HITS" IS '조회수';

COMMENT ON COLUMN "TB_STATE_CATEGORY"."STATE_CODE" IS '지역코드번호';

COMMENT ON COLUMN "TB_STATE_CATEGORY"."STATE_NAME" IS '지역명';

COMMENT ON COLUMN "TB_BOOK"."BOOK_NO" IS 'BOOK_NO';

COMMENT ON COLUMN "TB_BOOK"."BOOK_FARM_NO" IS '체험번호';

COMMENT ON COLUMN "TB_BOOK"."BOOK_USER_NO" IS '예약자';

COMMENT ON COLUMN "TB_BOOK"."BOOK_DATE" IS '예약 날짜';

COMMENT ON COLUMN "TB_BOOK"."PLAY_DATE" IS '체험일';

COMMENT ON COLUMN "TB_BOOK"."BOOK_CHECK" IS '예약 확정 여부';

COMMENT ON COLUMN "TB_BOOK"."BOOK_CANCEL" IS '예약 쉬소 여부';

COMMENT ON COLUMN "TB_BOOK"."BOOK_PAY" IS '결제여부';

COMMENT ON COLUMN "TB_BOOK"."PLAY_CHECK" IS '체험 진행 여부';

COMMENT ON COLUMN "TB_BOOK"."BOOK_COMPLETE" IS '완료여부';

COMMENT ON COLUMN "TB_BOOK"."ADULT_NO" IS '성인 인원';

COMMENT ON COLUMN "TB_BOOK"."KID_NO" IS '미성년 인원';

COMMENT ON COLUMN "TB_BOOK"."DELETE_PLAYER" IS '체험자가 삭제';

COMMENT ON COLUMN "TB_BOOK"."DELETE_SELLER" IS '등록자가 삭제';

COMMENT ON COLUMN "TB_ADDRESS"."ADDRESS_NO" IS '시퀀스를 써서 주소를 구분하기';

COMMENT ON COLUMN "TB_ADDRESS"."MEMBER_NO" IS '영어, 숫자 조합';

COMMENT ON COLUMN "TB_ADDRESS"."ADDRESS_TYPE" IS '메인배송지인지 서브배송지인지';

COMMENT ON COLUMN "TB_ADDRESS"."DISTRICT" IS '광역시, 도를 제외한 나머지 주소';

COMMENT ON COLUMN "TB_PRODUCT_CATEGORY"."CATEGORY_NO" IS '1/2/3/4/5/6/7/8';

COMMENT ON COLUMN "TB_PRODUCT_CATEGORY"."CATEGORY_NAME" IS '유기농 채소/유기농 과일/못난이 채소/못난이 과일/ 돼지고기/ 소고기 /기타고기 /유제품';

COMMENT ON COLUMN "TB_MAIN_CATEGORY"."MAIN_CATEGORY_NO" IS '카테고리 번호';

COMMENT ON COLUMN "TB_MAIN_CATEGORY"."CATEGORY_NAME" IS '게시글 / 판매 / 체험 / 리뷰/내상점';

COMMENT ON COLUMN "TB_MEMBER_TYPE"."MB_CATEGORY_NO" IS '1/2/3';

COMMENT ON COLUMN "TB_MEMBER_TYPE"."MB_CATEGORY_NAME" IS '관리자 판매자 일반사용자 정지유저';

COMMENT ON COLUMN "TB_IMAGE"."IMG_NO" IS '사진번호';

COMMENT ON COLUMN "TB_IMAGE"."ORIGIN_IMG_NAME" IS '사진원본명';

COMMENT ON COLUMN "TB_IMAGE"."CHANGE_IMG_NAME" IS '사진수정명';

COMMENT ON COLUMN "TB_IMAGE"."IMG_PATH" IS '저장폴더경로';

COMMENT ON COLUMN "TB_IMAGE"."UPLOAD_DATE" IS '업로드날짜';

COMMENT ON COLUMN "TB_IMAGE"."IMG_STATUS" IS '있으면Y, 없으면 N';

COMMENT ON COLUMN "TB_IMAGE"."IMG_LEVEL" IS '대표사진 1 / 서브사진 2';

COMMENT ON COLUMN "TB_IMAGE"."IMG_BR_NO" IS '다리 번호';

COMMENT ON COLUMN "TB_REPLY"."REF_BNO" IS '참조하는 게시물번호';

COMMENT ON COLUMN "TB_REPLY"."REPLY_WRITER" IS '시퀀스로 설정예정';

COMMENT ON COLUMN "TB_REPLY"."STATUS" IS '있으면 Y 없으면 N';
COMMENT ON COLUMN "TB_PRODUCT_UNIT"."UNIT_NO" IS '1,2,3';

COMMENT ON COLUMN "TB_PRODUCT_UNIT"."UNIT_NAME" IS '수량 / KG / BOX';
COMMENT ON COLUMN "TB_IMAGE_BRIGE"."IMG_BRIGE_NO" IS '다리 번호';

COMMENT ON COLUMN "TB_IMAGE_BRIGE"."IMG_CA_NO" IS '카테고리 번호';

COMMENT ON COLUMN "TB_IMAGE_BRIGE"."IMG_POST_NO" IS '각 게시글 / 후기 번호';
COMMENT ON COLUMN "TB_ORDER_REQUEST"."REQUEST_NO" IS '1,2,';

COMMENT ON COLUMN "TB_ORDER_REQUEST"."REQUEST_NAME" IS '문앞 / 경비실';
COMMENT ON COLUMN "TB_DELIVERY"."DELIVERY_PRICE" IS '배송금액칸';

COMMENT ON COLUMN "TB_REVIEW"."REVIEW_NO" IS '후기 번호';

COMMENT ON COLUMN "TB_REVIEW"."REVIEW_MB_NO" IS '회원번호';

COMMENT ON COLUMN "TB_REVIEW"."REVIEW_CA_NO" IS '카테고리 번호';

COMMENT ON COLUMN "TB_REVIEW"."REVIEW_TITLE" IS '제목';

COMMENT ON COLUMN "TB_REVIEW"."REVIEW_CONTENT" IS '내용';

COMMENT ON COLUMN "TB_REVIEW"."RATING" IS '별점';

COMMENT ON COLUMN "TB_REVIEW"."REVIEW_POST_NO" IS '각 게시물 번호';

COMMENT ON COLUMN "TB_REVIEW"."Field" IS '작성일';

COMMENT ON COLUMN "TB_REVIEW"."Field2" IS '수정일';

COMMENT ON COLUMN "TB_FARM_LIKE"."LIKE_USER_NO" IS '회원번호';

COMMENT ON COLUMN "TB_FARM_LIKE"."LIKE_BY_FARM" IS '체험번호';

COMMENT ON COLUMN "TB_FARM_LIKE"."GOOD_DATE" IS '좋아요날짜';
COMMENT ON COLUMN "TB_INQUIRY"."INQUIRY_WRITER" IS '시퀀스로 설정예정';

COMMENT ON COLUMN "TB_INQUIRY"."STATUS" IS '있으면 Y 없으면  N';

COMMENT ON COLUMN "TB_INQUIRY_ANSWER"."WRITER" IS '문의사항 작성자는 admin만 가능';
COMMENT ON COLUMN "TB_CART"."PRODUCT_NO" IS '상품번호';

COMMENT ON COLUMN "TB_CART"."MEMBER_NO" IS '회원번호';

COMMENT ON COLUMN "TB_MANGE_MESSAGE"."MESSAGE_NO" IS '메세지 번호';

COMMENT ON COLUMN "TB_MANGE_MESSAGE"."MANGE_NO" IS '메니저 아이디';

COMMENT ON COLUMN "TB_MANGE_MESSAGE"."MESSAGE_TITLE" IS '제목';

COMMENT ON COLUMN "TB_MANGE_MESSAGE"."MESSAGE_CONTENT" IS '내용';

COMMENT ON COLUMN "TB_MANGE_MESSAGE"."SEND_DATE" IS '보낸날짜';

COMMENT ON COLUMN "TB_MESSAGE_BRIGE"."BRIGE_MSG_NO" IS '메세지 번호';

COMMENT ON COLUMN "TB_MESSAGE_BRIGE"."SEND_MB_NO" IS '회원번호';

COMMENT ON COLUMN "TB_MESSAGE_BRIGE"."READ_MESSAGE" IS '읽음유무';

COMMENT ON COLUMN "TB_MESSAGE_BRIGE"."DELETE_STATUS" IS '삭제 유무';

COMMENT ON COLUMN "TB_FACILITY"."FACILITY_NO" IS '시설번호';

COMMENT ON COLUMN "TB_FACILITY"."FACILITY_NAME" IS '시설목록';

COMMENT ON COLUMN "TB_FARM_PRODUCT"."PRODUCE_NO" IS '농산물 번호';

COMMENT ON COLUMN "TB_FARM_PRODUCT"."PRODUCE_NAME" IS '사과, 감자, 오이 등등';

COMMENT ON COLUMN "TB_FARM"."FARM_NO" IS '체험번호';

COMMENT ON COLUMN "TB_FARM"."SELLER_NO" IS '회원번호';

COMMENT ON COLUMN "TB_FARM"."CATEGORY_NO" IS '카테고리 번호';

COMMENT ON COLUMN "TB_FARM"."FARM_PRODUCT_NO" IS '농산물 번호';

COMMENT ON COLUMN "TB_FARM"."FARM_TITLE" IS '체험제목';

COMMENT ON COLUMN "TB_FARM"."FARM_CONTENT" IS '체험내용';

COMMENT ON COLUMN "TB_FARM"."CREATE_DATE" IS '작성일';

COMMENT ON COLUMN "TB_FARM"."BEWARE_LIST" IS '주의사항';

COMMENT ON COLUMN "TB_FARM"."DELETE_ASK" IS 'Y/N';

COMMENT ON COLUMN "TB_FARM"."COUNT" IS '조회수';

COMMENT ON COLUMN "TB_FARM"."PRICE" IS '가격';

COMMENT ON COLUMN "TB_FARM"."MODIFY_FARM_DATE" IS '수정일';

COMMENT ON COLUMN "TB_FAC_BRIGE"."FACILITY_NO" IS '시설번호';

COMMENT ON COLUMN "TB_FAC_BRIGE"."FARM_NO" IS '체험번호';

COMMENT ON COLUMN "TB_PRODUCT"."PRODUCT_NO" IS '상품번호';

COMMENT ON COLUMN "TB_PRODUCT"."PRODUCT_NAME" IS '상품명';

COMMENT ON COLUMN "TB_PRODUCT"."PRODUCT_PRICE" IS '상품가격';

COMMENT ON COLUMN "TB_PRODUCT"."PRODUCT_CONTENT" IS '상품설명';

COMMENT ON COLUMN "TB_PRODUCT"."PRODUCT_NUMBER" IS '상품수량';

COMMENT ON COLUMN "TB_PRODUCT"."PRODUCT_HITS" IS '조회수';

COMMENT ON COLUMN "TB_PRODUCT"."PRODUCT_DATE" IS '상품등록일';

COMMENT ON COLUMN "TB_PRODUCT"."PRODUCT_TYPE" IS '1/2/3/4/5/6/7/8 상품카테고리';

COMMENT ON COLUMN "TB_PRODUCT"."PRODUCT_UNIT" IS '단위번호';

COMMENT ON COLUMN "TB_PRODUCT"."PRODUCT_DELIVERY" IS '배송상태';

COMMENT ON COLUMN "TB_PRODUCT"."PRODUCT_STORE" IS '상점번호';
COMMENT ON COLUMN "Untitled"."MEMBER_NO" IS '시퀀스로 설정예정';
