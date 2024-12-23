package com.kh.hyper.board.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.kh.hyper.board.model.vo.Board;
import com.kh.hyper.board.model.vo.Reply;

public interface BoardService {
	
	Map<String, Object> selectBoardList(int currentPage);
	
	Map<String, Object> selectById(Long boardNo);
	
	void insertBoard(Board board, MultipartFile upfile);
	
	void updateBoard(Board board, MultipartFile upfile);
	
	void deleteBoard(Long boardNo, String changeName);
	
	int insertReply(Reply reply);
	

	List<Reply> selectReply(Long boardNo);
	

}
