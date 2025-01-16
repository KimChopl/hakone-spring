import "./App.css";

function App() {
  return (
    <div className="App">
      <h1 className="title">React란</h1>

      <p>
        U.I(User Interface)를 구현하기 위한 JavaScript Library
        <br />
        코드 단위를 Compoenet로 구분하여 Component를 조합해서 복잡한 U.I를
        구성할 수 있음
        <br />
        SPA(Single Page Applocation)를 구현하기 위한 도구로 사용됨
        <br />
        <br />
        <strong>화면을 예쁘게 만드는 것과 React는 전혀 연관이 없음</strong>
        <br />
        React를 사용하기 위해서 Node.js라는 JavaScript Runtime을 설치
        <br />
        npm(Node Package Manager)라는 페키지 메니저 + JSX(Bable)문법을 활용할 수
        있음
        <br />
        따음표를 사용하지 않을 수 있게 됨<br />
      </p>
      <hr />
      <h2>JSX란</h2>
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
      </p>
    </div>
  );
}

export default App;
