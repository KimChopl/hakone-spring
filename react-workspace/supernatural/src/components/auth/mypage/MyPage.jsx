import { useState } from "react";
import { Container, Tabs, Tab, Content } from "./MyPage.styles";
import ChangePassword from "./ChangePassword";
import DeleteAccount from "./DeleteAccount";

const MyPage = () => {
  const [active, setActive] = useState("changePassword");
  return (
    <Container>
      <h2>마이페이지</h2>
      <Tabs>
        <Tab onClick={() => setActive("changePassword")}>비밀번호 변경</Tab>
        <Tab onClick={() => setActive("deleteAccount")}>계정 탈퇴</Tab>
      </Tabs>
      <Content>
        {active === "changePassword" ? <ChangePassword /> : <DeleteAccount />}
      </Content>
    </Container>
  );
};

export default MyPage;
