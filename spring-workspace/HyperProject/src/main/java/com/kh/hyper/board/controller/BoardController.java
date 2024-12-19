package com.kh.hyper.board.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.hyper.board.model.service.BoardService;
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
	
}
