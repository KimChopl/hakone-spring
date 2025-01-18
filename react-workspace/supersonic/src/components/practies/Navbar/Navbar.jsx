import { NavberMain, HoverUl } from "./Navbar.styles";
import { CContainer, CRow, CCol } from "@coreui/react";
import "@coreui/coreui/dist/css/coreui.min.css";
import { useNavigate } from "react-router-dom";

const Navbar = () => {
  const navi = useNavigate();
  return (
    <NavberMain>
      <CContainer>
        <CRow>
          <CCol>
            <HoverUl onClick={() => navi("/00")}>1</HoverUl>
          </CCol>
          <CCol>
            <HoverUl onClick={() => navi("/01")}>2</HoverUl>
          </CCol>
          <CCol>
            <HoverUl onClick={() => navi("/02")}>3</HoverUl>
          </CCol>
          <CCol>
            <HoverUl onClick={() => navi("/03")}>4</HoverUl>
          </CCol>
          <CCol>
            <HoverUl onClick={() => navi("/memo")}>5</HoverUl>
          </CCol>
          <CCol>
            <HoverUl onClick={() => navi("/h")}>Homework</HoverUl>
          </CCol>
        </CRow>
      </CContainer>
    </NavberMain>
  );
};

export default Navbar;
