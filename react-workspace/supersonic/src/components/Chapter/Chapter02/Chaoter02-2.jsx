const ChildComponent = (p) => {
  return (
    <>
      <div>자식 컴포넌트입니다.</div>
      <div>
        부모에서 받은 props를 수정하거나 조작하게되면 puer가 깨지게 되기 때문에
        직접적으로 값을 변경해서는 안됨
      </div>
      <p>
        ~ Chap02-2 <br />
        - React는 Component라는 개념을 이용해서 재사용이 가능한 조각들을
        만들어냄 <br />
        - Component를 정의하는 방법으로는 클래스와 함수가 있음 <br />
        클래스는 비권장방법임으로 함수로 정의하는 것이 바람직함 <br />
        - Component들을 조합해서 View를 재구성해 사용할 수 있음 <br />
        <br />* Component를 정의할 때는 반드시 대문자로 시작해야함. React는
        소문자로 시작하는 Component는 Component가 아닌 DOM요소로 인식하기 때문
      </p>
    </>
  );
};

const Chap022 = (p) => {
  return (
    <>
      <div>주의 점</div>
      <ChildComponent name={p.name} age="몇살이게?" />
    </>
  );
};

export default Chap022;
