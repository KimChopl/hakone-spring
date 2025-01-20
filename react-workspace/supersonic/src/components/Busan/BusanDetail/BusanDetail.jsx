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
  const [submitting, setSubmitting] = useState(false);
  //alert(id);
  useEffect(() => {
    axios.get(`http://localhost/hyper/busan/${id}`).then((r) => {
      const response = r.data.getFoodKr.item[0];
      if (response) {
        setFood(response);
      }
    });
  }, [id]);
  const writerHandler = (e) => {
    setWriter(e.target.value);
  };
  const contentHandler = (e) => {
    setContent(e.target.value);
  };
  const hanlerSubmit = () => {
    if (content.trim() === "" || writer.trim() === "") {
      alert("내용을 모두 입력하세요");
      return;
    }
    setSubmitting(true);

    axios
      .post(`http://localhost/hyper/comments`, {
        foodNo: id,
        content: content,
        writer: writer,
      })
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
      <button onClick={() => navi(-1)}>뒤로가기</button>
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
