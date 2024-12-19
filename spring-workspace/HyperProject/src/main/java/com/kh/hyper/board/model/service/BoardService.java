package com.kh.hyper.board.model.service;

import java.util.Map;

import com.kh.hyper.board.model.vo.Board;

public interface BoardService {
	
	Map<String, Object> selectBoardList(int currentPage);
	
	Board selectById(Long boardNo);
	
	void insertBoard(Board board);
	
	void updateBoard(Board board);
	
	void deleteBoard(Long boardNo);

}
