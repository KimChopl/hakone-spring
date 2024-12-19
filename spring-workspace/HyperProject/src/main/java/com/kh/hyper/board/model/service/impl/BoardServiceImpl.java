package com.kh.hyper.board.model.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;

import com.kh.hyper.board.model.dao.BoardMapper;
import com.kh.hyper.board.model.service.BoardService;
import com.kh.hyper.board.model.vo.Board;
import com.kh.hyper.common.model.vo.PageInfo;
import com.kh.hyper.common.template.Pagination;
import com.kh.hyper.exception.BoardNotFoundException;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class BoardServiceImpl implements BoardService {
	
	private final BoardMapper mp;
	
	private int getTotalCount() {
		int totalCount = mp.selectTotalCount();
		if(totalCount == 0) {
			throw new BoardNotFoundException("게시글 없음");
		}
		
		return totalCount;
	}
	
	private PageInfo getPageInfo(int totalCount, int page) {
		return Pagination.getPageInfo(totalCount, page, 5, 5);
	}
	
	private List<Board> getBoardList(PageInfo pi){
		int offset = (pi.getCurrentPage() - 1) * pi.getBaordLimit();
		RowBounds rb = new RowBounds(offset, pi.getBaordLimit());
		return mp.selectBoardList(rb);
	}

	@Override
	public Map<String, Object> selectBoardList(int currentPage) {
		
		
		//log.info("{}", totalCount);
		//log.info("{}", currentPage);
		int totalCount = getTotalCount();
		//PageInfo pi = Pagination.getPageInfo(totalCount, currentPage, 5, 5);
		
		PageInfo pi = getPageInfo(totalCount, currentPage);
		
		//int offset = (pi.getCurrentPage() - 1) * pi.getBaordLimit();
		//RowBounds rb = new RowBounds(offset, pi.getBaordLimit());
		//List<Board> list = mp.selectBoardList(rb);
		//log.info("{}", list);
		List<Board> boards = getBoardList(pi);
		
		Map<String, Object> map = new HashMap();
		map.put("boards", boards);
		map.put("pi", pi);
		return map;
	}

	@Override
	public Board selectById(Long boardNo) {
		return null;
	}

	@Override
	public void insertBoard(Board board) {

	}

	@Override
	public void updateBoard(Board board) {

	}

	@Override
	public void deleteBoard(Long boardNo) {

	}

}
