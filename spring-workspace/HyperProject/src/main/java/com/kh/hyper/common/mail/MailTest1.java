package com.kh.hyper.common.mail;

import java.util.Properties;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;

// 직접 객체를 생성해서 이메일 보내기
public class MailTest1 {
	
	public static void main(String[] args) {
		
		JavaMailSenderImpl sender = new JavaMailSenderImpl();
		
		// 계정설정
		sender.setHost("smtp.gmail.com");
		sender.setPort(587); // 고정(구글에서는)
		
		// 옵션설정 세팅 시 오타 안나게 조심
		Properties options = new Properties();
		options.put("mail.smtp.auth", true);
		options.put("mail.smtp.starttls.enable", true);
		sender.setJavaMailProperties(options);
		
		// 메시지 생성
		SimpleMailMessage message = new SimpleMailMessage();
		message.setSubject("hi"); // 제목
		message.setText("메롱"); // 내용
		message.setTo(); // 받는이 (배열로도 가능 -> 다중 이메일)
		
		/*
		 * 참조 - setCC(참조할 주소)
		 * 
		 * 숨은참조 - setBcc(숨은 참조할 주소)
		 */
		
		//보내기
		sender.send(message);
		
	}
	
}
