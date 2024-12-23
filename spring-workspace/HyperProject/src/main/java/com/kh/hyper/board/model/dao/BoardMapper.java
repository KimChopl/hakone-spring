package com.kh.hyper.board.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.hyper.board.model.vo.Board;
import com.kh.hyper.board.model.vo.Reply;

@Mapper
public interface BoardMapper {
	int selectTotalCount();
	
	List<Board> selectBoardList(RowBounds rb);

	void insertBoard(Board board);

	int countUp(Long boardNo);

	Board selectDetailBoard(Long boardNo);
	
	int deleteBoard(Long boardNo);
	
	int updateBoard(Board board);

	int insertReply(Reply reply);

	List<Reply> selectReply(Long boardNo);
}
