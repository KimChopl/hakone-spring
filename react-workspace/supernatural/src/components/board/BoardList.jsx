import { useContext, useEffect, useState } from "react";
import {
  Container,
  Title,
  Message,
  AddButton,
  PostList,
  PostItem,
  PostTitle,
  Author,
  LoadMoreButton,
} from "./BoardList.styles";
import { useNavigate } from "react-router-dom";
import axios from "axios";
import { AuthContext } from "../context/AuthContext";

const BoardList = () => {
  const [boards, setBoard] = useState([]);
  const [page, setPage] = useState(0);
  const [hasMore, setHasMore] = useState(true);
  const navi = useNavigate();
  const { auth } = useContext(AuthContext);
  useEffect(() => {
    axios
      .get("http://localhost/boards", {
        params: {
          page: page,
        },
      })
      .then((response) => {
        setBoard([...boards, ...response.data]);
        if (response.data.length < 3) {
          setHasMore(false);
        }
      })
      .catch((error) => {
        console.log(error);
      });
  }, [page]);
  const moreMore = () => {
    setPage(page + 1);
  };
  return (
    <Container>
      <Title>게시글 목록</Title>
      {auth.isAuthenticated && (
        <AddButton onClick={() => navi("/boards/insert")}>
          새 게시글 작성
        </AddButton>
      )}
      <PostList>
        {boards.map((board) => (
          <PostItem
            key={board.boardNo}
            onClick={() => navi(`/boards/${board.boardNo}`)}
          >
            <PostTitle>{board.boardTitle}</PostTitle>
            <Author>작성자: {board.boardWriter}</Author>
          </PostItem>
        ))}
      </PostList>
      {hasMore && <LoadMoreButton onClick={moreMore}>더보기</LoadMoreButton>}
    </Container>
  );
};

export default BoardList;
