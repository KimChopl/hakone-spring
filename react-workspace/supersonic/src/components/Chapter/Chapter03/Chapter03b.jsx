import { useState, useEffect } from "react";

const Chap03b = () => {
  const [num, setNum] = useState(245);
  const btn = () => {
    setNum((num) => num - 1);
  };
  useEffect(() => {
    alert(num + "번클릭");
  }, [num]); // ,[] 넣으면 로드되고 딱 한 번만 사용하겠다는 의미 배열 안에 State를 넣을 수 있음 => 배열에 State를 넣으면 State가 변동 될 때마다 수행함 => 여러개 가능
  /*
    Mount => 첫 렌더링
    UPDATE => 재렌더링
    위 시점에서 무언가를 수행하려면 useEffect Hook 사용

    Hook 사용 시 주의사항
    - 블럭 최상위에서만 Hook 호출 => 반복, 조건 함수 내부에서 호출 할 수 없음
    - React 함수 컴포넌트 내부에서만 사용 가능
  */
  return (
    <>
      <button onClick={btn}>감소</button>
      <p>{num}</p>
    </>
  );
};

export default Chap03b;
