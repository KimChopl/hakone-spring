import { useContext, useState } from "react";
import {
  Container,
  Form,
  Input,
  Button,
  ErrorMessage,
} from "./DeleteAccount.styles";
import { AuthContext } from "../../context/AuthContext";
import { useNavigate } from "react-router-dom";
import axios from "axios";

const DeleteAccount = () => {
  const [userPwd, setUserPwd] = useState("");
  const { auth, logout } = useContext(AuthContext);
  const navi = useNavigate();
  const [error, setError] = useState("");
  const handleDeleteUser = (e) => {
    e.preventDefault();
    setError("");
    axios
      .delete("http://localhost/members", {
        data: {
          password: userPwd,
        },
        headers: {
          Authorization: `Bearer ${auth.accessToken}`,
        },
      })
      .then((response) => {
        alert(response.data);
        logout();
        navi("/");
      })
      .catch((error) => {
        console.log(error);
        setError("탈퇴실패");
      });
  };
  return (
    <Container>
      {error && <ErrorMessage>{error}</ErrorMessage>}
      <h2>계정 탈퇴</h2>
      <Form onSubmit={handleDeleteUser}>
        <Input
          type="password"
          onChange={(e) => setUserPwd(e.target.value)}
          value={userPwd}
          placeholder="비밀번호 확인"
          required
        />
        <Button type="submit">계정 탈퇴</Button>
      </Form>
    </Container>
  );
};

export default DeleteAccount;
