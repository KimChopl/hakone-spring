const WhatIsJSX = () => {
  return (
    <div>
      <h2 className="title">JSX란</h2>
      <p>
        JSX(JavaScriptXML)는 JavaScript + XML을 사용한 자바스크립트의 확장 문법{" "}
        <br />
        리액트 문법 : React.createElement(태그명, 속성값, content);
        <br />
        JSX 문법 : &lt;div&gt; content &lt;/div&gt;
        <br />
        <br />
        JSX 문법을 사용해서 JavaScript코드 내부에 React의 Element를 생성할 수
        있음 <br />
        U.I를 구현하기 위해 React와 JSX를 함께 사용하길 권장하며, JavaScript의
        모든 기능을 사용할 수 있음
        <br />
        <br />
        <br />
        ReactElement란
        <br />
        Component를 구성하는 요소
        <br />
        화면에 만들어내고 싶은(기술할) 요소를 작성하여 React가 브라우저 화면에
        렌더링 할 수 있게 함 <br />
        특정 : 불변객체
        <br />
        <br />
        React는 index.html안에 있는 root 아이디 속성값을 가진 div요소안에 있는
        모든 요소들을 관리함
        <br />
        index.js에서 root.reder() 호출해서 element를 전달함 <br />
        React를 이용해서 U.I를 변경하는 방법은 ReactElement를 만들고 인자로
        전달하는 방법만 있음.
        <br />
        ReactElement들을 하나의 Component로 만듬
      </p>
      <hr />
    </div>
  );
};

export default WhatIsJSX;
