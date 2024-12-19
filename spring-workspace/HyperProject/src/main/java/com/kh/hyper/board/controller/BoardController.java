package com.kh.hyper.board.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.hyper.board.model.service.BoardService;
import com.kh.hyper.board.model.vo.Board;
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
	
	@PostMapping("boards")
	public ModelAndView saveBoard(Board board, MultipartFile upfile, HttpSession ssn) {
		
		//String originName = upfile.getOriginalFilename();
		//if(originName.equals("")) {
			
			//log.info("{} : {} ", board, upfile.getOriginalFilename());
		//}
		bs.insertBoard(board, upfile);
		ssn.setAttribute("alertMsg", "등록 완료");
		return mv.setViewNameAndData("redirect:boards", null);
	}
	
	@GetMapping("board/${id}")
	public ModelAndView selectByIdBoard(@PathVariable(name="id") Long id) {
		log.info("{}", id);
		return mv.setViewNameAndData(null, null);
	}
	
}
