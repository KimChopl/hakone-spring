import { useEffect, useState } from "react";
import axios from "axios";
import styled from "styled-components";
import { useNavigate } from "react-router-dom";

const StyledWrap = styled.div`
  width: 1200px;
  height: auto;
  min-height: 900px;
  margin: auto;
  border-top: 1px solid #c8c8c8;
`;

const StyledTitle = styled.div`
  font-size: 52px;
  font-weight: bold;
  color: #515151;
  test-align: center;
  margin: 20px 0px;
`;

const StyleInnerWrap = styled.div`
  width: 1200px;
  margin: auto;
  height: auto;
  min-height: 600px;
  border-top: 1px solid gray;
  padding: 15px;
`;

const StyledCard = styled.div`
  width: 350px;
  height: 450px;
  display: inline-block;
  margin: 15px;
  box-shadow: 1px 3px 5px #b0b0b0;
  padding: 5px;
`;
const StyledImage = styled.img`
  width: 300px;
  height: 380px;
`;

const StyledMenu = styled.p`
  text-align: center;
  font-size: 15px;
  color: blue;
`;

const BusanList = () => {
  /*
    useEffect(() => {
    let url = "http://localhost/hyper/busan?page=1";
    fetch(url)
      .then((response) => response.json())  받아온 값 문자열에서 JSON으로 변환
      .then(
        (data) => console.log(data)
    )
    .catch((err) => console.log("오류 발생", err))
    .finally(console.log("반드시 실행되는 거"));
    }, []);
    */

  /*
    공공데이터로 바로 url을 보내면 서비스키가 외부에 노출되기 떄문에 사용하지 않음 => 뒷단으로 보내야함
    여러 예외 처리를 위해 뒷단에서 처리할 필요가 있음
  */
  const [foods, setFoods] = useState([]);
  const [page, setPage] = useState(1);
  const [hasMore, setHasMore] = useState(true);

  const navigate = useNavigate();

  useEffect(() => {
    /*
   axios({
    url: "http://localhost/hyper/busan?page=1",
    method: "get",
    }).then((result) => console.log(result));
    */
    axios.get(`http://localhost/hyper/busan?page=${page}`).then((result) => {
      const response = result.data.getFoodKr.item;
      setFoods([...foods, ...response]);
      if (response.length < 6) {
        setHasMore(false);
      }
    });
  }, [page]);

  const handleMorePage = () => {
    setPage(page + 1);
  };

  return (
    <>
      <StyledWrap>
        <StyledTitle>식당목록</StyledTitle>
        <StyleInnerWrap>
          {foods.length === 0 ? (
            <h3>조회된 항목이 없습니다.</h3>
          ) : (
            foods.map((e) => {
              return (
                <StyledCard
                  key={e.UC_SEQ}
                  onClick={() => navigate(`foods/${e.UC_SEQ}`)}
                >
                  <StyledImage src={e.MAIN_IMG_THUMB} alt="음식 사진 자리" />
                  <h5>{e.MAIN_TITLE}</h5>
                  <StyledMenu>{e.ADDR1}</StyledMenu>
                </StyledCard>
              );
            })
          )}
        </StyleInnerWrap>
        {hasMore && <button onClick={handleMorePage}>more</button>}
      </StyledWrap>
    </>
  );
};

export default BusanList;
