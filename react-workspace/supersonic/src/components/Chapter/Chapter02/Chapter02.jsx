import styled from "styled-components";

const StyledDiv = styled.div`
  border: 1px solid gray;
  width: 600px;
  height: 150px;
  margin: auto;
  background-color: ${(props) => (props.color ? props.color : "white")};
`;

const Info = (props) => {
  //console.log(porps);

  // 구조분해 하기
  const { title, titi, tata } = props.insertVal;
  return (
    <>
      <StyledDiv color={props.color}>
        <h6>{title}</h6>
        <p>{titi}</p>
        <strong>{tata}</strong>
      </StyledDiv>
    </>
  );
};

const Chap02 = (props) => {
  const response = {
    // AJAX요청 후 돌아 온 값으로 가정
    title: "아",
    titi: "우아우",
    tata: "오우아우",
  };
  const maybe = {
    title: "백지헌",
    titi: "보단",
    tata: "아니다 백지헌이지",
  };
  const What = {
    title: "변수명",
    titi: "진짜",
    tata: "뭘로 만드냐",
  };
  const list = [response, maybe, What];
  return (
    <>
      <h2>{props.keys}</h2>
      {/*
      <Info insertVal={response} color={"lightgreen"} />
      <Info insertVal={maybe} color={"cyan"} />
      <Info insertVal={What} />
      */}
      {list.map((e, i) => {
        //console.log(e);
        //console.log(i);
        return <Info insertVal={e} key={e.title} />;
      })}
    </>
  );
};

export default Chap02;

// 자식 컴포넌트는 부모 컨포넌트로부터 데이터를 전달 받을 수 있음
// -> key value 형식으로 넘길 수 있음
// -> 넘겨진 값을 매개변수 자리에 props를 사용하여 전달 받은 값을 사용함
