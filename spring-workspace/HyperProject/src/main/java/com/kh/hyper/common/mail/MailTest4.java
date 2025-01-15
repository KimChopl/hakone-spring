package com.kh.hyper.common.mail;

import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MailTest4 {

	private final JavaMailSenderImpl s;
	
	@GetMapping("file-mail")
	public String sendFile() throws MessagingException {
		
		MimeMessage m = s.createMimeMessage();
		
		MimeMessageHelper h = new MimeMessageHelper(m, true, "UTF-8");
		
		String[] to = {"anjs0802@naver.com"};
		
		h.setTo(to);
		h.setSubject("[anjs]요청파일 제공");
		h.setText("<label>말씀하신 자료 첨부합니다.</label>");
		DataSource so = new FileDataSource("C:\\anjs\\front-workspace\\02_CSS\\resources\\image\\1.jpg");
		h.addAttachment(so.getName(), so);
		
		s.send(m);
		
		return "redirect:/";
	}
	
}
