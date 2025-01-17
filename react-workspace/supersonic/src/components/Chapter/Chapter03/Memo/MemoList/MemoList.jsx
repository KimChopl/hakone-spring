import { StyledContent, StyledWriter, StyledMemo } from "./MemoList.Style";

const MemoList = (props) => {
  return (
    <>
      {props.memos ? (
        props.memos.map((e) => {
          return (
            <StyledMemo key={e.content}>
              <StyledContent color={e.content.length}>
                {e.content}
              </StyledContent>
              <StyledWriter>{e.writer}</StyledWriter>
            </StyledMemo>
          );
        })
      ) : (
        <h2>메모가 존재하지 않습니다.</h2>
      )}
    </>
  );
};

export default MemoList;
