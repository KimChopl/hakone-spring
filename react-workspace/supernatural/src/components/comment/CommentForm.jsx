import {
  FormContainer,
  TextArea,
  SubmitButton,
  ErrorMessage,
} from "./CommentForm.styles";

const CommentForm = () => {
  return (
    <FormContainer>
      <TextArea placeholder="댓글을 작성하세요..." rows="4" />
      <SubmitButton type="submit">작성하기</SubmitButton>
    </FormContainer>
  );
};

export default CommentForm;
