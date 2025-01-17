import { useState } from "react";

const MemoForm = (props) => {
  const [writer, setWriter] = useState("");

  const [content, setContent] = useState("");

  const inputMemo = (e) => {
    setContent(e.target.value);
  };

  const inputWriter = (e) => {
    setWriter(e.target.value);
  };

  const insertMemo = () => {
    if (content.length === 0 && writer.length === 0) {
      alert("내용 또는 작성자 입력");
      return;
    } else {
      const memo = { writer: writer, content: content };
      props.setMemos([...props.memos, memo]); // 배열에 요소추가 -> setter를 사용해야하기 때문에 push는 사용하지 않음
      setWriter("");
      setContent("");
    }
  };

  return (
    <>
      <h4>{content}</h4>
      내용 : <input type="text" onChange={inputMemo} value={content} />
      <br />
      <h4>{writer}</h4>
      작성자 : <input type="text" onChange={inputWriter} value={writer} />{" "}
      <br />
      <button onClick={insertMemo}>작성하기</button>
    </>
  );
};

export default MemoForm;
