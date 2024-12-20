package com.kh.hyper.ajax.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.hyper.board.model.service.BoardService;
import com.kh.hyper.board.model.vo.Board;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AjaxController {

	
	@Autowired
	private BoardService bs;
	
	/*
	 * 	Spring 사용 전 HttpServletResponse 객체로 응답데이터 응답함
	 * 
	 */
	/*
	@GetMapping("ajax1.do")
	public void ajaxMethod1(HttpServletResponse r, String userId) throws IOException {
		log.info(userId);
		// 요청처리
		
		// 있음
		
		// 응답형식 지정
		r.setContentType("text/html; charset=UTF-8");
		
		// 출력
		r.getWriter().print("두두둥장");
		
		
		
	}*/
	
	/*
	 * 	2. 응답할 데이터를 문자열로 반환
	 * 		=> HttpServletResponse를 사용하지 않고 String을 사용 => ModelAndView의 ViewName 필드에 삽입
	 * 			=> DispatcherServlet => ViewResolver => prefix + String + subfix
	 *  => 데이터로 돌리고 싶은데? => MseeageConverter(@ResponseBody) => 텍스트 형식을 정해주어야 함
	 */
	
	@GetMapping(value="ajax1.do", produces="text/html; charset=UTF-8")
	@ResponseBody
	public String ajaxMethod1(String userId) {
		return userId + " 두두둥장";
	}
	
	@ResponseBody
	@GetMapping(value="ajax2.do", produces = "application/json; charset=UTF-8")
	public Board ajaxmethod2(Long no) {
		Map<String, Object> board = bs.selectById(no);
		log.info("{}", board);
		
		return (Board)board.get("board");
	}
	
}
