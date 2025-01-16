import {
  HeaderMainDiv,
  HeaderSideDiv,
  HeaderCenterDiv,
  HeaderMainLogo,
  HeaderLeftLogo,
} from "./Header.styles";

const Header = () => {
  return (
    <HeaderMainDiv>
      <HeaderSideDiv>
        <a href="#!" target="_blank">
          <HeaderLeftLogo
            src="https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyNDA4MjVfMTk5%2FMDAxNzI0NTQyMjY1NDAz.GrefkpKZORX00azBJVuY7hRltbJEdgs9NY0yFuJqZgog.hafbYkYKjLG1Z1ZQOhzIMfy9X-XsaeyxtKeli7sRk3og.PNG%2F20231019%25A3%25DF154645.png&type=a340"
            alt="MainLogo"
          />
        </a>
      </HeaderSideDiv>
      <HeaderCenterDiv>
        <HeaderMainLogo>무슨 글자가 들어가야할까요</HeaderMainLogo>
      </HeaderCenterDiv>
      <HeaderSideDiv>
        <p>로그인 / 회원가입</p>
      </HeaderSideDiv>
    </HeaderMainDiv>
  );
};

export default Header;
