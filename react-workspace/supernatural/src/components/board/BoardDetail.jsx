import {
  Container,
  Title,
  Author,
  Content,
  Image,
  EditButton,
  DeleteButton,
  BackButton,
  Message,
} from "./BoardDetail.styles";
import CommentList from "../comment/CommentList";
import CommentForm from "../comment/CommentForm";
import { useNavigate, useParams } from "react-router-dom";
import { useContext, useEffect, useState } from "react";
import axios from "axios";
import { AuthContext } from "../context/AuthContext";

const BoardDetail = () => {
  const { id } = useParams();
  const [board, setBoard] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(false);
  const { auth } = useContext(AuthContext);
  const navi = useNavigate();

  useEffect(() => {
    axios
      .get(`http://localhost/boards/${id}`)
      .then((response) => {
        console.log(response);
        setLoading(false);
        setBoard(response.data);
      })
      .catch((error) => {
        console.log(error);
        setLoading(false);
        setError(true);
      });
  }, []);

  const handleDelete = () => {
    if (window.confirm("삭제 하실?")) {
      axios
        .delete(`http://localhost/boards/${id}`, {
          headers: {
            Authorization: `Bearer ${auth.accessToken}`,
          },
        })
        .then(() => {
          setError(false);
          setLoading(true);
          alert("삭제 완료");
          setTimeout(() => {
            navi("/boards");
          }, 1500);
        })
        .catch((error) => {
          alert(error);
        });
    }
  };
  const handleEdit = () => {
    navi(`/boards/${id}/edit`);
  };
  if (loading) {
    return (
      <Container>
        <Message>로딩 중...</Message>
      </Container>
    );
  }

  if (error) {
    return (
      <Container>
        <Message>게시글을 찾을 수 없습니다.</Message>
      </Container>
    );
  }

  return (
    <Container>
      <Title>{board.boardTitle}</Title>
      <Author>작성자: {board.boardWriter}</Author>
      <Content>{board.boardContent}</Content>
      {board.boardFileUrl && <Image src={board.boardFileUrl} />}
      {auth.username === board.boardWriter && (
        <div>
          <EditButton onClick={handleEdit}>수정하기</EditButton>
          <DeleteButton onClick={handleDelete}>삭제하기</DeleteButton>
        </div>
      )}

      <BackButton onClick={() => navi(-1)}>뒤로가기</BackButton>

      <hr />

      <h3>댓글</h3>
      <CommentForm />
      <CommentList />
    </Container>
  );
};

export default BoardDetail;
