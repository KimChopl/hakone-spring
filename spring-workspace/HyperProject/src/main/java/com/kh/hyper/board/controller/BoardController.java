package com.kh.hyper.board.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.hyper.board.model.service.BoardService;
import com.kh.hyper.board.model.vo.Board;
import com.kh.hyper.board.model.vo.Reply;
import com.kh.hyper.common.ModelAndViewUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class BoardController {

	private final BoardService bs;
	private final ModelAndViewUtil mv;
	
	
	@GetMapping("boards")
	public ModelAndView selectBoardList(@RequestParam(value="page", defaultValue="1") int page) {
		Map<String, Object> map = bs.selectBoardList(page);
		
		return mv.setViewNameAndData("/board/list", map);
	}
	
	@GetMapping("insert.board")
	public String insertBoard() {
		return "board/insert_board";
	}
	
	@PostMapping("boards")						// 파일 여러개를 받을 때는 MultipartFile[] => 배열로 받으면됨
	public ModelAndView saveBoard(Board board, MultipartFile upfile, HttpSession ssn) {
		
		//String originName = upfile.getOriginalFilename();
		//if(originName.equals("")) {
			
			//log.info("{} : {} ", board, upfile.getOriginalFilename());
		//}
		bs.insertBoard(board, upfile);
		ssn.setAttribute("alertMsg", "등록 완료");
		return mv.setViewNameAndData("redirect:boards", null);
	}
	
	@GetMapping("boards/{id}")
	public ModelAndView selectByIdBoard(@PathVariable(name="id") Long id) { // 요철 uri에서 뒷 부분을 변수로 사용할 떄 사용
		//log.info("{}", id);
		Map<String, Object> map = bs.selectById(id);
		return mv.setViewNameAndData("board/detail", map);
	}
	
	@PostMapping("boards/delete")
	public ModelAndView deleteBoard(Long boardNo, String changeName) {
		bs.deleteBoard(boardNo, changeName);
		return mv.setViewNameAndData("redirect:/boards", null);
	}
	
	@PostMapping("boards/update-form")
	public ModelAndView updateForm(Long boardNo) {
		Map<String, Object> map = bs.selectById(boardNo);
		return mv.setViewNameAndData("board/update", map);
	}
	
	@PostMapping("boards/update")
	public ModelAndView updateBoard(Board board, MultipartFile upfile) {
		//log.info("{} : {}", board, upfile);
		bs.updateBoard(board, upfile);
		return mv.setViewNameAndData("redirect:/boards", null);
	}
	
	
	/*
	 * SELECT : GET
	 * INSERT : POST
	 * UPDATE : PUT
	 * DELETE : DELETE
	 * 
	 */
	
	/*
	@ResponseBody
	@PostMapping(value="reply")
	public int ajaxInsertReply(Reply reply) {
		log.info("{}", reply);
		return bs.insertReply(reply);
	}
	
	@ResponseBody
	@GetMapping(value="reply", produces="application/json; charset=UTF-8")
	public List<Reply> ajaxSelectReply(Long boardNo){
		return bs.selectReply(boardNo);
	}
	*/
	@GetMapping("map")
	public String mapForwad() {
		return "common/map";
	}
}
