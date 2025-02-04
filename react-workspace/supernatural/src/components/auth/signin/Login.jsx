import {
  LoginContainer,
  Form,
  Input,
  Button,
  ErrorMessage,
} from "./Login.styles";
import axios from "axios";
import { useState, useContext } from "react";
import { AuthContext } from "../../context/AuthContext";

const Login = () => {
  const [userId, setUserId] = useState("");
  const [userPwd, setUserPwd] = useState("");
  const { login } = useContext(AuthContext);
  const handleLogin = (e) => {
    e.preventDefault();
    axios
      .post("http://localhost/members/login", {
        userId: userId,
        userPwd: userPwd,
      })
      .then((response) => {
        console.log(response);
        const { username, tokens } = response.data;
        login(username, tokens.accessToken, tokens.refreshToken);
        window.location = "/";
      })
      .catch((error) => {
        console.log(error);
      });
  };

  return (
    <LoginContainer>
      <h2>로그인</h2>
      <Form onSubmit={handleLogin}>
        <Input
          type="text"
          onChange={(e) => setUserId(e.target.value)}
          value={userId}
          placeholder="사용자명"
          required
        />
        <Input
          type="password"
          onChange={(e) => setUserPwd(e.target.value)}
          value={userPwd}
          placeholder="비밀번호"
          required
        />
        <Button type="submit">로그인</Button>
      </Form>
    </LoginContainer>
  );
};

export default Login;
