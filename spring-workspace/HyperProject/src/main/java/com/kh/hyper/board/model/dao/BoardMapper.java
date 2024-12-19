package com.kh.hyper.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.hyper.board.model.vo.Board;

@Mapper
public interface BoardMapper {
	int selectTotalCount();
	
	List<Board> selectBoardList(RowBounds rb);
}
