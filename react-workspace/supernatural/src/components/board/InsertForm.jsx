import { useContext, useEffect, useState } from "react";
import {
  Container,
  Title,
  Form,
  Label,
  Input,
  TextArea,
  FileInput,
  Button,
  Message,
} from "./InsertForm.styles";
import { AuthContext } from "../context/AuthContext";
import { useNavigate } from "react-router-dom";
import axios from "axios";

const InsertForm = () => {
  const [title, setTitle] = useState("");
  const [content, setContent] = useState("");
  const [userId, setUserId] = useState("");
  const [file, setFile] = useState(null);
  const [accessToken, setAccessToken] = useState("");
  const { auth } = useContext(AuthContext);
  const navi = useNavigate();
  useEffect(() => {
    if (!auth.isAuthenticated) {
      alert("로그인 후 이용가능 서비스");
      navi("/signin");
    } else {
      setUserId(auth.username);
      setAccessToken(auth.accessToken);
    }
  }, []);
  const handleFileChange = (e) => {
    const selectedFile = e.target.files[0];
    console.log(selectedFile.type);
    const allowedTypes = ["image/jpg", "image/jpeg", "image/png", "image/gif"];
    const maxSize = 15 * 1024 * 1024;
    if (selectedFile && !allowedTypes.includes(selectedFile.type)) {
      alert("허용되지 않는 파일 박형식");
      return;
    }
    if (selectedFile && selectedFile.size > maxSize) {
      alert("끄앙 너무 커버렷..!");
      return;
    }
    setFile(selectedFile);
  };
  const handleInsert = (e) => {
    e.preventDefault();
    if (!title || !content) {
      alert("제목과 내용은 필수항목");
      return;
    }
    const formData = new FormData();
    formData.append("boardTitle", title);
    formData.append("boardContent", content);
    formData.append("boardWriter", userId);
    if (file) {
      formData.append("file", file);
    }
    axios
      .post("http://localhost/boards", formData, {
        headers: {
          "Content-Type": "multipart/form-data",
          Authorization: `Bearer ${accessToken}`,
        },
      })
      .then((response) => {
        if (response.status === 201) {
          alert(response.data);
          navi("/boards");
        }
      })
      .catch((error) => {
        console.log(error);
      });
  };
  return (
    <Container>
      <Title>게시글 작성</Title>
      <Form onSubmit={handleInsert}>
        <div>
          <Label htmlFor="title">제목</Label>
          <Input
            id="title"
            type="text"
            onChange={(e) => setTitle(e.target.value)}
            value={title}
            required
            placeholder="제목을 입력하세요"
          />
        </div>
        <div>
          <Label htmlFor="content">내용</Label>
          <TextArea
            id="content"
            onChange={(e) => setContent(e.target.value)}
            value={content}
            required
            placeholder="내용을 입력하세요"
          ></TextArea>
        </div>
        <div>
          <Label htmlFor="username">작성자 ID</Label>
          <Input id="username" value={userId} type="text" readOnly />
        </div>
        <div>
          <Label htmlFor="file">파일 첨부: </Label>
          <FileInput
            id="file"
            type="file"
            accept="image/*"
            onChange={handleFileChange}
          />
        </div>
        <Button type="submit">작성</Button>
      </Form>
    </Container>
  );
};

export default InsertForm;
