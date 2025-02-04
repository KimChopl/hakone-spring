import {
  Container,
  Form,
  Input,
  Button,
  ErrorMessage,
} from "./DeleteAccount.styles";

const DeleteAccount = () => {
  return (
    <Container>
      <h2>계정 탈퇴</h2>
      <Form>
        <Input type="password" placeholder="비밀번호 확인" required />
        <Button type="submit">계정 탈퇴</Button>
      </Form>
    </Container>
  );
};

export default DeleteAccount;
