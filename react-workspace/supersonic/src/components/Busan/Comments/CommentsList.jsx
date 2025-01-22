import { useEffect, useState } from "react";

const CommentList = (props) => {
  const id = props.foodNo;
  const [comments, setComments] = useState([]);
  const [flag, isFlag] = useState(true);
  useEffect(() => {
    const requestUrl = `http://localhost/comments/${id}`;
    console.log(requestUrl);
    fetch(requestUrl)
      .then((result) => {
        console.log(result);
        return result.json(); // json으로 파싱해주는 작업 필요 => fetch 사용할 때만
      })
      .then((data) => {
        console.log(data);
        setComments([...comments, ...data]);
        isFlag(false);
      })
      .catch((err) => console.log(err));
  }, []);
  return (
    <>
      {comments != [] ? (
        comments.map((e, i) => {
          return (
            <div key={i}>
              <h4>{e.writer}</h4>
              <p>{e.content}</p>
            </div>
          );
        })
      ) : (
        <h4>댓글이 없음</h4>
      )}
    </>
  );
};
export default CommentList;
