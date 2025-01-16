import { NavberMain } from "./Navbar.styles";
import { CContainer, CRow, CCol } from "@coreui/react";
import "@coreui/coreui/dist/css/coreui.min.css";

const Navbar = () => {
  return (
    <NavberMain>
      <CContainer>
        <CRow>
          <CCol>
            <ul>1</ul>
          </CCol>
          <CCol>
            <ul>2</ul>
          </CCol>
          <CCol>
            <ul>3</ul>
          </CCol>
        </CRow>
      </CContainer>
    </NavberMain>
  );
};

export default Navbar;
