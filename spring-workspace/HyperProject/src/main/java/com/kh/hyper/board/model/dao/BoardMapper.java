package com.kh.hyper.board.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.hyper.board.model.vo.Board;

@Mapper
public interface BoardMapper {
	int selectTotalCount();
	
	List<Board> selectBoardList(RowBounds rb);

	void insertBoard(Board board);
}
