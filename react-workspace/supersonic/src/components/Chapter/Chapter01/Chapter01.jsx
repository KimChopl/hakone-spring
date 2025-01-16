import "./Chapter01.style.css";
import { StyledDiv } from "./Chapter01.styles";
const Chap01 = () => {
  const message = "와이리 졸린데 이시간만 되면 잠이 옵니다.";
  // 변수 대입된 값을 React Element에 출력할 때 중괄호를 이용해서 현부 식별자를 감싸줌
  const Element = <div>react 요소를 변수에 대입하기</div>;
  // JSX 식에는 부모 요소가 하나 있어야 합니다. return은 값을 하나만 보낼 수 있기 때문 -> 메인 div 안에 넣어줘야함
  // 감쌀 태그가 없다면 React에서 제공하는 Fragment를 사용하거나 <> </>를 사용해서 감싸주기

  /*
    React Element에 class속성과 style 부여하기
    JSX는 XML 기반 기술이기 때문에 HTML에서의 class 속성을 그대로 사용할 수 없음 -> className 사용
  */
  return (
    <>
      <div>
        <h1>Chap01</h1>
        컴포넌트 중 생길 수 있는 문제 <br />
        {message} &#61;&gt; &#123;변수&#125; 로 변수 대입
      </div>
      <div> div 요소 하나 더 보내기 </div>
      {Element}
      <hr />
      <div className="style-div">스타일 부여하기</div>
      <div style={{ background: "red", fontSize: "40px" }}>
        하지말것 인라인으로 스타일 주기
      </div>
      <StyledDiv>
        이렇게 스타일을 주는 방법도 있지요 <br />
        npm install styled-component
      </StyledDiv>
    </>
  );
};

export default Chap01;
