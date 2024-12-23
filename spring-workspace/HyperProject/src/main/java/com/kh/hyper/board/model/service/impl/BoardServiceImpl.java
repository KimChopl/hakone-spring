package com.kh.hyper.board.model.service.impl;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.hyper.board.model.dao.BoardMapper;
import com.kh.hyper.board.model.service.BoardService;
import com.kh.hyper.board.model.vo.Board;
import com.kh.hyper.board.model.vo.Reply;
import com.kh.hyper.common.model.vo.PageInfo;
import com.kh.hyper.common.template.Pagination;
import com.kh.hyper.exception.BoardDeleteException;
import com.kh.hyper.exception.BoardNotFoundException;
import com.kh.hyper.exception.EnoughBoardContentException;
import com.kh.hyper.exception.FailToFileUploadException;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class BoardServiceImpl implements BoardService {
	
	private final BoardMapper mp;
	private final ServletContext context;
	
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
	
	private void checkContent(Board board) {
		if(board == null || board.getBoardTitle() == null || board.getBoardTitle().trim().isEmpty() ||
				board.getBoardContent() == null || board.getBoardContent().trim().isEmpty() || 
				board.getBoardWriter() == null || board.getBoardWriter().trim().isEmpty()) {
			throw new EnoughBoardContentException("충분치 못한 입력값");
		}
	}
	
	private Board setChangeBoard(Board board) {
		String boardTitle = changeScript(board.getBoardTitle());
		String boardContent = changeScript(board.getBoardContent());
		board.setBoardTitle(changeCrlf(boardTitle));
		board.setBoardContent(changeCrlf(boardContent));
		return board;
	}
	
	private String changeScript(String value) {
		/*
		 *  < == &lt;
		 *  > == &gt;
		 *  \ == &quot;
		 *  & == &amp;
		 * 
		 */
		//String boardTitle = board.getBoardTitle().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("&", "&amp;");
		return value.replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;");//.replaceAll("&", "&amp;");
	}
	
	private String changeCrlf(String value) {
		return value.replaceAll("\n", "<br>");
	}
	
	private void checkImage(Board board, MultipartFile upfile) {
		String originName = upfile.getOriginalFilename();
		if(!("".equals(originName))) {
			String LastFileName = originName.substring(originName.lastIndexOf('.'));
			//log.info(LastFileName);
			String currentTime = new SimpleDateFormat("yyMMddHHmm").format(new Date());
			int randNo = (int)Math.random() * 12354 + 12354;
			
			String changeName = randNo + currentTime + LastFileName;
			
			String savePath = context.getRealPath("resources/upload_files/");
			
			try {
				upfile.transferTo(new File(savePath + changeName));
			} catch (IllegalStateException | IOException e) {
				throw new FailToFileUploadException("잘못된 파일");
			}
			board.setOriginName(originName);
			board.setChangeName("resources/upload_files/" + changeName);
		}
	}
	
	private void checkCurrentPage(int currentPage, PageInfo pi) {
		if(currentPage > pi.getMaxPage() || currentPage < 1) {
			throw new BoardNotFoundException("장난질 침");
		}
	}
	
	private void checkBoardNo(Long boardNo) {
		if(boardNo < 1) {
			throw new BoardNotFoundException("게시글 없음");
		}
	}
	
	private void boardCountUp(Long boardNo) {
		int result = mp.countUp(boardNo);
		if(result < 1) {
			throw new BoardNotFoundException("게시글 없어짐");
		}
	}
	
	private void checkDelete(Board board) {
		if(board == null) {
			throw new BoardDeleteException("삭제된 게시글");
		}
	}

	@Override
	public Map<String, Object> selectBoardList(int currentPage) {
		
		
		//log.info("{}", totalCount);
		//log.info("{}", currentPage);
		int totalCount = getTotalCount();
		//PageInfo pi = Pagination.getPageInfo(totalCount, currentPage, 5, 5);
		
		PageInfo pi = getPageInfo(totalCount, currentPage);
		
		//log.info("{}", pi);
		checkCurrentPage(currentPage, pi);
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
	public void insertBoard(Board board, MultipartFile upfile) {
		checkContent(board);
		checkImage(board, upfile);
		
		
		Board changeBoard = setChangeBoard(board);
		/*
		String originName = upfile.getOriginalFilename();
		if(!("".equals(originName))) {
			String LastFileName = originName.substring(originName.lastIndexOf('.'));
			//log.info(LastFileName);
			String currentTime = new SimpleDateFormat("yyMMddHHmm").format(new Date());
			int randNo = (int)Math.random() * 12354 + 12354;
			
			String changeName = randNo + currentTime + LastFileName;
			
			String savePath = context.getRealPath("resources/upload_files/");
			
			try {
				upfile.transferTo(new File(savePath + changeName));
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			board.setOriginName(originName);
			board.setChangeName("reources/upload_files/" + changeName);
		}
		*/
		/*
		if("".equals(board.getBoardTitle()) || "".equals(board.getBoardContent()) || "".equals(board.getBoardWriter())) {
			throw new EnoughBoardContentException("충분치 못한 입력값");
		}
		*/
		mp.insertBoard(changeBoard);
	}

	
	@Override
	public Map<String, Object> selectById(Long boardNo) {
		checkBoardNo(boardNo);
		boardCountUp(boardNo);
		Board board = mp.selectDetailBoard(boardNo);
		//log.info("{}", board);
		checkDelete(board);
		Map<String, Object> map = new HashMap();
		map.put("board", board);
		return map;
	}

	@Override
	public void updateBoard(Board board, MultipartFile upfile) {
		Board beforeBoard = mp.selectDetailBoard(board.getBoardNo());
		if(beforeBoard.getChangeName() != null) {
			deleteImage(beforeBoard.getChangeName());
		}
		checkImage(board, upfile);
		Board afterBoard = setChangeBoard(board);
		int result = mp.updateBoard(afterBoard);
		if(result < 1) {
			throw new BoardDeleteException("수정 실패");
		}
	}
	
	private void checkingDelete(Long boardNo) {
		if(mp.deleteBoard(boardNo) <= 0 ) {
			throw new BoardDeleteException("삭제 실패");
		}
	}
	private void deleteImage(String changeName) {
		if(!("".equals(changeName))) {
			try {
				log.info("{}", new File (context.getRealPath(changeName)));
				new File(context.getRealPath(changeName)).delete();
			} catch(RuntimeException e){
				throw new BoardDeleteException("사진 삭제 실패");
			}
		} 
	}
	@Override
	public void deleteBoard(Long boardNo, String changeName) {
		Board board = new Board();
		board.setBoardNo(boardNo);
		checkDelete(board);
		checkingDelete(boardNo);
		deleteImage(changeName);
	}

	@Override
	public int insertReply(Reply reply) {
		return mp.insertReply(reply);
	}


	@Override
	public List<Reply> selectReply(Long boardNo) {
		return mp.selectReply(boardNo);
	}


}
