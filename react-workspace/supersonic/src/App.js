import "./App.css";
import { printNumber, printString } from "./components/modules/FirstModule"; // export된 함수를 import하는 방법 컴포넌트가 여러개일 때는 이 방법 사용
import Chap01 from "./components/Chapter/Chapter01/Chapter01";
import Header from "./components/practies/Header/Header";
import Footer from "./components/practies/Footer/Footer";
import Chap02 from "./components/Chapter/Chapter02/Chapter02";
import Chap022 from "./components/Chapter/Chapter02/Chaoter02-2";
import Chap02Exam from "./components/Chapter/Chapter02/Chapter02Exam";
import { Chap03 } from "./components/Chapter/Chapter03/Chapter03";
import Chap03b from "./components/Chapter/Chapter03/Chapter03b";
import Chap03c from "./components/Chapter/Chapter03/Chapter03c";
import Memo from "./components/Chapter/Chapter03/Memo/Memo";
import { Routes, Route } from "react-router-dom";
import Chap00 from "./components/Chapter/Chapter00/Chapter00";
import Navbar from "./components/practies/Navbar/Navbar";
import Homework from "./components/homework/Homework";

const arr = [
  {
    time: "1교시",
    content: "props학습",
  },
  {
    time: "2교시",
    content: "props학습",
  },
  {
    time: "3교시",
    content: "props는 끝나지 않아요",
  },
  {
    time: "4교시",
    content: "사실 끝났지롱 state학습",
  },
];

const test = {};

// 컴포넌트 만들기 => 컴포넌트 만드는 함수는 대문자로 시작

function App() {
  printNumber();
  printString();
  const chap00 = false;

  /*
    요청 url에 따라서 다른 Component를 보여줄 수 있는 lib
    -> ReactRouter
    -> 16버전 이상의 react에서는 6버전 사용 => npm install react-router-dom@6
    -> index.js에서 App Component를 BrowserRouter로 감싸주기
  */
  return (
    <div className="App">
      {/*주석달기 중괄호 안에서 주석 사용하면 가능*/}
      {/* <Cahp00 />*/}
      {/*
        chap00 ? (
          ((<Cahp00 />), (<Chap01 />), (<Chap02 keys={"히히"} />))
        ) : (
          <div></div>
        ) /*조건문쓰기. 단, if문은 문자열로 인식하기 때문에 논리연산자나 삼항연산자를 사용해 조건문 구현*/}
      {/*chap00 && <Chap022 name="메롱" /> &&
        arr.map((e) => <Chap02Exam test={test} data={e} key={e.time} />) && (
          <Chap03 />
        ) && <Chap03b /> && <Chap03c />*/}
      {/*<Memo />*/}
      <Header />
      <Navbar />
      <Routes>
        <Route path="/" element={<div>메인페이지</div>} />
        <Route path="00" element={<Chap00 />} />
        <Route path="01" element={<Chap01 />} />
        <Route path="02" element={<Chap02 />} />
        <Route path="022" element={<Chap022 />} />
        <Route path="03" element={<Chap03 />} />
        <Route path="03b" element={<Chap03b />} />
        <Route path="03c" element={<Chap03c />} />
        <Route
          path="02e"
          element={arr.map((e) => (
            <Chap02Exam test={test} data={e} key={e.time} />
          ))}
        />
        <Route path="memo" element={<Memo />} />
        <Route path="/*" element={<h1>잘못된 요청</h1>} />
        <Route path="h" element={<Homework />} />
      </Routes>
      <Footer />
      <br />
      <br />
      <br />
    </div>
  );
}

export default App; // 내보낼 컴포넌트가 단 하나일 때 사용하는 방법

/*
  숙제 겸 실습
  메인 컴포넌트를 하나 만들고  자식 컴포넌트로 각각 입력 모듈, 목록 출력 모듈 
  메인 컴포넌트에서 입력 및 출력을 할 수 있도록 구현

  조건)
  img태그를 사용하여 출력이 될 때 이미지도 함께 출력이 되어야함.
  option -> 능력이 된다면 JS Date를 이용하여 날짜도 함께 출력하기
*/
