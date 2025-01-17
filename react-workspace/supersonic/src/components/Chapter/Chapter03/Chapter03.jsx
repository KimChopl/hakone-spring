import { useState } from "react";
/*
  Component 내부에서 변경 가능한 데이터값을 관리 해야하는 경우
  props는 불변객체이기 때문에
  React는 화면에 표시하는 데이터, 변화하는 상태 등은 모두 State를 이용해서 관리함.
   => 클릭, 값 체크, 모달, 에러, 숫자, 문자, 배열, 객체 등등

   함수형 Component는 state를 관리하기 위해 userState라는 Hook을 이용함
    => Hook : React 16.8 버전부터 추가된 기능. React를 사용하면서 쓸 수 있는 함수들
*/

export const Chap03 = () => {
  let [i, setNum] = useState(0); // Hook 생성 리턴값이 두개가 반환됨 => [0] : 내가 전달한 값, [1] : setter함수
  // state변수를 사용한다 생각하기
  // userState()를 호출 할 때 인자값전달 => 초기값 세팅
  // 초기 값에는 모든 타입이 들어갈 수 있음
  const btnClick = () => {
    i += 1;
    setNum((i) => i + 1); // 재렌더링을 일으키는 역할
  };
  /*
    돌아가는 구조
    1. 버튼 클릭 시 setter함수를 이용해서 State를 변경함
    2. 변경된 State가 있으면 변경된 해당 함수 재호출
    3. 변경된 부분 확인
    4. 변경된 부분이 화면에 출력 => 새로고침없이 변경
   
   
    Component 재렌더링
      함수형 Component는 State가 변경될 때마다 처음부터 다시 실행
      React는 가상 DOM을 사용하여 변경된 부분만 실제 DOM에 반영함 => 재렌더링

    React 재렌더링 조건
      1. setter를 사용한 State의 변경
      2. props값이 변경
      3. 재렌더링된 Component의 모든 하위 Component들

    주의사항
    State는 항상 setter를 이용해서 변경해야 하며 값을 대입하려 하면 안됨
  */
  return (
    <>
      <h1>State</h1>
      <button onClick={btnClick}>클릭클릭클릭</button>
      <br />
      <label>{i}</label>
    </>
  );
};
