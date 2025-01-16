import "./App.css";
import { printNumber, printString } from "./components/modules/FirstModule"; // export된 함수를 import하는 방법 컴포넌트가 여러개일 때는 이 방법 사용
import Cahp00 from "./components/Chapter/Chapter00/Chapter00";
import Chap01 from "./components/Chapter/Chapter01/Chapter01";
import Header from "./components/practies/Header/Header";
import Content from "./components/practies/Content/Content";
import Footer from "./components/practies/Footer/Footer";
import Navbar from "./components/practies/Navbar/Navbar";
// 컴포넌트 만들기 => 컴포넌트 만드는 함수는 대문자로 시작

function App() {
  printNumber();
  printString();
  const chap00 = false;

  return (
    <div className="App">
      {/*주석달기 중괄호 안에서 주석 사용하면 가능*/}
      {/* <Cahp00 />*/}
      {
        chap00 ? (
          <Cahp00 />
        ) : (
          <div>히히</div>
        ) /*조건문쓰기. 단, if문은 문자열로 인식하기 때문에 논리연산자나 삼항연산자를 사용해 조건문 구현*/
      }
      <br />
      <br />
      <br />
      <br />
      <Chap01 />
      <br />
      <br />
      <br />
      <br />
      <br />
      <br />
      <br />
      <Header />
      <Navbar />
      <Content />
      <Footer />
      <br />
      <br />
      <br />
    </div>
  );
}

export default App; // 내보낼 컴포넌트가 단 하나일 때 사용하는 방법
