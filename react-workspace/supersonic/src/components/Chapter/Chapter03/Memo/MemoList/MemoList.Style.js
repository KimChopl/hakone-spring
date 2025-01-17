import styled from "styled-components";

export const StyledMemo = styled.div`
  width: 300px;
  height: 300px;
  margin: 20px;
  padding: 7px;
  background-color: #ffff006e;
  box-shadow: 2px 3px 5px #707070;
  display: inline-block;
`;
export const StyledContent = styled.div`
  width: 95%;
  height: 75%;
  margin: auto;
  margin-top: 10px;
  margin-bottom: 12px;
  font-size: 25px;
  color: ${(props) => (props.color > 20 ? "blue" : "black")};
`;

export const StyledWriter = styled.p`
  width: 95%;
  height: 25%;
  margin: auto;
  font-weight: bold;
  text-align: right;
`;
