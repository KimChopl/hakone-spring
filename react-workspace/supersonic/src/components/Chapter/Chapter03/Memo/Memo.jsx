import { useState } from "react";
import MemoForm from "./MemoForm/MemoForm";
import MemoList from "./MemoList/MemoList";
import { StyledTitle, StyledHr } from "./Memo.Style";

const Memo = () => {
  /*
        아래 State가 DB에서 돌아온 값이라고 가정하게 되면
        아래 값들이 다른 Component로 보내줘서 그 곳에서 값을 가공할 수 있도록 해주어야함.
        자식 요소들 중 여러개가 아래 값들을 사용할 경우에 해당함.
        Component를 나눌떄 outPut과 input으로 나눌 수 있을 듯함
    */
  const [memos, setMemos] = useState([
    { writer: "송하영", content: "송하영 졸귀임 ㅇㅈ?" },
    { writer: "이채영", content: "그런 건 이름 좀 바꾸고해;;" },
    { writer: "호날두", content: "SIIiiiOOOooooo oooooooooooo" },
    { writer: "강지윤", content: "유은호씨 당신이 먼저 꼬신거에요." },
  ]);

  return (
    <>
      <StyledTitle>메모하기</StyledTitle>
      <StyledHr />
      <MemoList memos={memos} />
      <StyledHr />
      <MemoForm memos={memos} setMemos={setMemos} />
      <StyledHr />
    </>
  );
};

export default Memo;
