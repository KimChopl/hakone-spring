package com.kh.hyper.exception.controller;

import org.springframework.dao.DuplicateKeyException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import com.kh.hyper.exception.BoardNotFoundException;
import com.kh.hyper.exception.EnoughBoardContentException;
import com.kh.hyper.exception.NotMatchLengthException;
import com.kh.hyper.exception.PasswordNotAccordException;
import com.kh.hyper.exception.UserFoundException;
import com.kh.hyper.exception.UserIdNotFoundException;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@ControllerAdvice
public class ExceptionhandlingController {
	
	private ModelAndView createErrorResponse(String errorMsg, Exception e) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("errorMsg", errorMsg).setViewName("common/error_page");
		log.info("{}", e.getMessage(), e);
		return mv;
	}
	
	/*@ExceptionHandler(DuplicateKeyException.class)
	protected ModelAndView handlerTransactionError(DuplicateKeyException e) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("errorMsg", "잘못된 요청").setViewName("common/error_page");
		log.info("{}", e.getMessage(), e);
		return mv;
		
	}*/
	
	@ExceptionHandler(DuplicateKeyException.class)
	protected ModelAndView handlerTransactionError(DuplicateKeyException e) {
		return createErrorResponse("잘못된 요청", e);
		
	}
	
	/*
	@ExceptionHandler(RuntimeException.class) // 예외 타입만 보고 호출 됨 => 아이디가 잘못됐든 비밀번호가 잘못 됐든 같은 애가 호출
	protected ModelAndView NoSuchUserIdError(RuntimeException e) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("errorMsg", "아이디가 존재하지 않음").setViewName("common/error_page");
		log.info("{}", e.getMessage(), e);
		return mv;
	}*/
	
	@ExceptionHandler(UserIdNotFoundException.class) // 예외 타입만 보고 호출 됨 => 아이디가 잘못됐든 비밀번호가 잘못 됐든 같은 애가 호출
	protected ModelAndView NoSuchUserIdError(UserIdNotFoundException e) {
		/*ModelAndView mv = new ModelAndView();
		mv.addObject("errorMsg", "아이디가 존재하지 않음").setViewName("common/error_page");
		log.info("{}", e.getMessage(), e);
		return mv;*/
		return createErrorResponse("아이디가 존재하지 않음", e);
	}
	
	@ExceptionHandler(PasswordNotAccordException.class)
	protected ModelAndView PasswordNotAccordError(PasswordNotAccordException e) {
		/*ModelAndView mv = new ModelAndView();
		mv.addObject("errorMsg", "비밀번호가 일치하지 않음").setViewName("common/error_page");
		log.info("{}", e.getMessage(), e);
		return mv;*/
		return createErrorResponse("비밀번호가 일치하지 않음", e);
	}
	
	@ExceptionHandler(UserFoundException.class)
	protected ModelAndView UserFoundError(UserFoundException e) {
		/*ModelAndView mv = new ModelAndView();
		mv.addObject("errorMsg", "아이디 입력 오류").setViewName("common/error_page");
		log.info("{}", e.getMessage(), e);
		return mv;*/
		return createErrorResponse("아이디 입력 오류", e);
	}
	
	@ExceptionHandler(NotMatchLengthException.class)
	protected ModelAndView LengthError(NotMatchLengthException e) {
		/*ModelAndView mv = new ModelAndView();
		mv.addObject("errorMsg", "길이가 맞지 않음").setViewName("common/error_page");
		log.info("{}", e.getMessage(), e);*/
		return createErrorResponse("길이가 맞지 않음", e);
	}
	
	@ExceptionHandler(BoardNotFoundException.class)
	protected ModelAndView NoSuchBoardError(BoardNotFoundException e) {
		return createErrorResponse("존재하는 게시글이 없음", e);
	}
	
	@ExceptionHandler(EnoughBoardContentException.class)
	protected ModelAndView boardNotValue(EnoughBoardContentException e) {
		return createErrorResponse("필수 입력 구역이 비어있음", e);
	}
	
}
