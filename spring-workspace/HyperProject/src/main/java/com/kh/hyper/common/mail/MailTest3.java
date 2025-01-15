package com.kh.hyper.common.mail;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MailTest3 {

	@Autowired
	private JavaMailSenderImpl s;
	
	@GetMapping("sendmail")
	public String sendMail() throws MessagingException {
		
		// MimeMessage객체 생성 -> 이것저것 할 수 있게 해주는거
		MimeMessage message = s.createMimeMessage();
		
		MimeMessageHelper helper = new MimeMessageHelper(message, false, "UTF-8"); // MimeMessage객체, 첨부파일 넣을건지, 인코딩
		
		/*
		helper.setSubject("NotFoundException 건으로 연락드립니다.");
		helper.setText("<h1>안녕하세요 Exception입니다.</h1><br><h3>집나간 NotFoundException을 찾습니다.</h3><br><h4>찾으시거든 아래 RuntimeException으로 연락부탁드립니다. 감사합니다.</h3>", true); // true넣어야 HTML속성이 적용됨
		*/
		helper.setSubject("[jsan]비밀번호 변경 안내 메일입니다.");
		String authCode = "25523";
		String url = "<a href='http://localhost/hyper/auth?authCode=25523'>비밀번호 변경하기</a>";
		
		helper.setText(url, true);
		
		String[] to = {"anjs0802@naver.com"};
		
		helper.setTo(to);
		
		s.send(message);
		
		return "redirect:/";
	}

	@GetMapping("auth")
	public String auth(String authCode) {
		
		// DB에 저장해놓은 auth코드 조회
		
		if(authCode.equals("25523")) {
			System.out.println("성공");
		} else {
			System.out.println("실패");
		}
		return "redirect:/";
		
	}
	
}
