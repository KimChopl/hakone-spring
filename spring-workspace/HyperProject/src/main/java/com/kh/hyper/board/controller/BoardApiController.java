package com.kh.hyper.board.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.hyper.board.model.service.BoardService;
import com.kh.hyper.board.model.vo.Reply;
import com.kh.hyper.common.model.vo.ResponseData;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController // ajax 사용하기 위해 반환 값을 주소가 아닌 data만 넘겨줄 때 사용 => ResponseBody + Controller
@RequestMapping("reply")
@RequiredArgsConstructor
@Slf4j
public class BoardApiController {
	
	private final BoardService bs;
	
	@PostMapping
	public ResponseEntity<ResponseData> ajaxInsertReply(Reply reply) {
		int result = bs.insertReply(reply);
		ResponseData response = ResponseData.builder().message("등록 완료").status(HttpStatus.OK.toString()).data(result).build();
		return new ResponseEntity<ResponseData>(response, HttpStatus.OK);
	}
	
	@GetMapping(produces="application/json; charset=UTF-8")
	public ResponseEntity<ResponseData> ajaxSelectReply(Long boardNo){
		List<Reply> reply =  bs.selectReply(boardNo);
		ResponseData response = ResponseData.builder().message("조회 성공").status(HttpStatus.OK.toString()).data(reply).build();
		return new ResponseEntity<ResponseData>(response, HttpStatus.OK);
	}
	
}
