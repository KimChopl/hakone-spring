import { useState } from "react";

const Chap03c = () => {
  const [text, setText] = useState("");
  const [texts, setTexts] = useState("");
  const inputText = (e) => {
    setText(e.target.value);
    if (e.target.value.length > 10) {
      setTexts("글자수 초과");
    } else {
      setTexts("");
    }
  };
  return (
    <>
      <h1>input 체험</h1>
      <input type="text" onChange={inputText} /> <br />
      <span>{texts}</span>
      <br />
      <span>{text}</span>
    </>
  );
};

export default Chap03c;
