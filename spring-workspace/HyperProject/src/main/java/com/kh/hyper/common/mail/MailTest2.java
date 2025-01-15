package com.kh.hyper.common.mail;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MailTest2 {

	private final JavaMailSenderImpl sender;
	
	@PostMapping("mail.test")
	public String sendMail(String subject, String text) {
		
		SimpleMailMessage msg = new SimpleMailMessage();
		
		msg.setSubject(subject);
		msg.setText(text);
		
		String[] to = {"1227wanho@gmail.com", "anjs0802@naver.com", "khacademy1002@gmail.com"};
		
		msg.setTo(to);
		
		sender.send(msg);
		
		return "redirect:/";
	}
	
	@GetMapping("mailpage")
	public String mailPage() {
		return "mail/mail-test";
	}
	
}
