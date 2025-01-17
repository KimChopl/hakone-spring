const Chap02Exam = (props) => {
  const { time, content } = props.data;
  return time ? (
    <div>
      <p>시간 : {time}</p>
      <p>학습내용 : {content}</p>
    </div>
  ) : (
    <div></div>
  );
};

export default Chap02Exam;
