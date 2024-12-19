package com.kh.hyper.common;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class PasswordEncryptor {
	private final BCryptPasswordEncoder pwe;
	
	public String encode(String rawPassword) {
		return pwe.encode(rawPassword);
	}
	
	public boolean matches(String rawPassword, String encodedPassword) {
		return pwe.matches(rawPassword, encodedPassword);
	}
	
}
