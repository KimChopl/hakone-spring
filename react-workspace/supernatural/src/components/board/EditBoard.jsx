import { useNavigate, useParams } from "react-router-dom";
import {
  Container,
  Title,
  Form,
  Label,
  Input,
  TextArea,
  FileInput,
  ImagePreview,
  SubmitButton,
  CancelButton,
  Message,
} from "./EditBoard.styles";
import { useContext, useEffect, useState } from "react";
import { AuthContext } from "../context/AuthContext";
import axios from "axios";

const EditBoard = () => {
  const { id } = useParams();
  const navi = useNavigate();
  const { auth } = useContext(AuthContext);
  const [boardTitle, setBoardTitle] = useState("");
  const [boardContent, setBoardContent] = useState("");
  const [boardWriter, setBoardWriter] = useState("");
  const [file, setFile] = useState();
  const [exsitingFileUrl, setExsitingFileUrl] = useState();
  const [loading, setLoading] = useState(false);
  useEffect(() => {
    if (!auth.isAuthenticated) {
      alert("로그인이 필요한 서비스");
      navi("/signin");
    } else {
      axios.get(`http://localhost/boards/${id}`).then((response) => {
        setBoardContent(response.data.boardContent);
        setBoardTitle(response.data.boardTitle);
        setBoardWriter(response.data.boardWriter);
        setExsitingFileUrl(response.data.boradFileUrl || "");
      });
    }
  }, [id]);
  const handleFile = (e) => {
    if (e.target.files && e.target.files[0]) {
      setFile(e.target.files[0]);
    }
  };
  const handleUpdate = (e) => {
    e.preventDefault();
    const formData = new FormData();
    formData.append("boardTitle", boardTitle);
    formData.append("boardContent", boardContent);
    formData.append("boardWriter", boardWriter);
    if (file) {
      formData.append("file", file);
    }
    axios
      .put(`http://localhost/boards/${id}`, formData, {
        headers: {
          "Content-Type": "multipart/form-data",
          Authorization: `Bearer ${auth.accessToken}`,
        },
      })
      .then((response) => {
        setLoading(true);
        setTimeout(() => {
          navi(`boards/${id}`);
        }, 3000);
      });
  };
  if (loading) {
    return <div className="bg"></div>;
  }
  return (
    <Container>
      <Title>게시글 수정</Title>
      <Form onSubmit={handleUpdate}>
        <Label>제목</Label>
        <Input
          type="text"
          value={boardTitle}
          onChange={(e) => setBoardTitle(e.target.value)}
          required
        />

        <Label>내용</Label>
        <TextArea
          rows="10"
          value={boardContent}
          onChange={(e) => setBoardContent(e.target.value)}
          required
        />

        <Label>첨부 파일</Label>
        {exsitingFileUrl && (
          <>
            <ImagePreview src={exsitingFileUrl} alt="기존 첨부 파일" />
            <Label>파일 변경:</Label>
          </>
        )}
        <FileInput type="file" onChange={handleFile} />

        <SubmitButton type="submit">수정버튼</SubmitButton>
      </Form>
      <CancelButton onClick={() => navi(-1)}>취소</CancelButton>
    </Container>
  );
};

export default EditBoard;
