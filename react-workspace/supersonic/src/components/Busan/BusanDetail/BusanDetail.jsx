import axios from "axios";
import { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import CommentList from "../Comments/CommentsList";

const BusanDetail = () => {
  const { id } = useParams();
  const [food, setFood] = useState(null);
  const navi = useNavigate();
  const [content, setContent] = useState("");
  const [writer, setWriter] = useState("");
  const [submitting, setSubmitting] = useState(true);
  //alert(id);
  useEffect(() => {
    axios.get(`http://localhost/hyper/busan/${id}`).then((r) => {
      // axios로 값을 받게 되면 json형태로 값이 돌아오기 때문에 파싱을 따로 할 필요가 없음.
      const response = r.data.getFoodKr.item[0];
      if (response) {
        setFood(response);
      }
    });
  }, [id]);
  const writerHandler = (e) => {
    setWriter(e.target.value);
    a();
  };
  const contentHandler = (e) => {
    setContent(e.target.value);
    a(); // 여기서 넣어줘야 버튼 상태가 바뀜
  };
  const a = () => {
    if (content.trim() !== "" && writer.trim() !== "") {
      setSubmitting(false);
    } else {
      setSubmitting(true);
    }
  };
  const hanlerSubmit = (e) => {
    if (content.trim() === "" || writer.trim() === "") {
      e.preventDefault();
      alert("내용을 모두 입력하세요");
      return;
    }
    setSubmitting(false); // from테그가 동작한 이후에 설정되기 때문에 글자가 입력되었을 때랑 상관이 없음.

    axios
      .post(`http://localhost/hyper/comments`, {
        foodNo: id,
        content: content,
        writer: writer,
      }) // axios 사용 시 뒷단에 값 전달하기.
      .then((r) => console.log(r));
  };
  return (
    <>
      <div>상세보기쓰</div>
      {food ? (
        <div>
          <div>
            <h1>{food.TITLE}</h1>
          </div>
          <p>{food.ITEMCNTNTS}</p>
          <p>{food.ADDR1}</p>
          <img src={food.MAIN_IMG_NORMAL} alt="음식사진" />
        </div>
      ) : (
        <div>존재하지 않는 요청입니다.</div>
      )}
      <button onClick={() => navi(-1)}>뒤로가기</button>{" "}
      {/* navigation을 통해서 페이지 왔다갔다 하기 */}
      <hr />
      <form onSubmit={hanlerSubmit}>
        내용 : <textarea value={content} onChange={contentHandler}></textarea>{" "}
        <br />
        작성자 : <input
          type="text"
          value={writer}
          onChange={writerHandler}
        />{" "}
        <br />
        <button type="submit" disabled={submitting}>
          {submitting ? "작성 중.." : "작성하기"}
        </button>
      </form>
      <CommentList foodNo={id} />
    </>
  );
};

export default BusanDetail;
