import { HeaderContainer, Logo, Nav, NavItem } from "./Header.styles";
import { useNavigate } from "react-router-dom";
import { useContext } from "react";
import { AuthContext } from "../context/AuthContext";

const Header = () => {
  const navi = useNavigate();
  const goTo = (path) => {
    navi(path);
  };
  const { auth, logout } = useContext(AuthContext);
  const handleLogout = () => {
    //axios로 refreshToken 삭제

    logout();
  };
  return (
    <HeaderContainer>
      <Logo>KH 정보교육원 참예쁘다~~</Logo>
      <Nav>
        <NavItem onClick={() => goTo("/")}>홈</NavItem>
        <NavItem>게시판</NavItem>
        {auth.isAuthenticated ? (
          <>
            <NavItem>{auth.username}님 반갑습니다.</NavItem>
            <NavItem onClick={() => goTo("/mypage")}>마이페이지</NavItem>
            <NavItem onClick={handleLogout}>로그아웃</NavItem>
          </>
        ) : (
          <>
            <NavItem onClick={() => goTo("/signup")}>회원가입</NavItem>
            <NavItem onClick={() => goTo("/signin")}>로그인</NavItem>
          </>
        )}
      </Nav>
    </HeaderContainer>
  );
};

export default Header;
