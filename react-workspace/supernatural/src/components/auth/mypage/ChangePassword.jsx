import { useContext, useState } from "react";
import {
  Container,
  Form,
  Input,
  Button,
  ErrorMessage,
} from "./ChangePassword.styles";
import { AuthContext } from "../../context/AuthContext";
import axios from "axios";

const ChangePassword = () => {
  const [beforePwd, setBeforePwd] = useState("");
  const [changePwd, setChangePwd] = useState("");
  const { auth } = useContext(AuthContext);
  const handleChangePwd = (e) => {
    e.preventDefault();
    setError("");
    setSuccess("");
    axios
      .put(
        "http://localhost/members",
        {
          beforePwd: beforePwd,
          changePwd: changePwd,
        },
        {
          headers: {
            Authorization: `Bearer ${auth.accessToken}`,
          },
        }
      )
      .then(() => {
        setSuccess("변경 성공");
        setBeforePwd("");
        setChangePwd("");
      })
      .catch((error) => {
        console.log(error);
        setError(error.response.data || "변경 실패 잠시 후 다시 시도");
      });
  };
  const [success, setSuccess] = useState("");
  const [error, setError] = useState("");

  return (
    <Container>
      <h2>비밀번호 변경</h2>
      <Form onSubmit={handleChangePwd}>
        <Input
          type="password"
          onChange={(e) => setBeforePwd(e.target.value)}
          value={beforePwd}
          placeholder="현재 비밀번호"
          required
        />
        <Input
          type="password"
          onChange={(e) => setChangePwd(e.target.value)}
          value={changePwd}
          placeholder="새 비밀번호"
          required
        />
        <Button type="submit">비밀번호 변경</Button>
        {error && <ErrorMessage>{error}</ErrorMessage>}
        {success && <p style={{ color: "skyblue" }}>{success}</p>}
      </Form>
    </Container>
  );
};

export default ChangePassword;
