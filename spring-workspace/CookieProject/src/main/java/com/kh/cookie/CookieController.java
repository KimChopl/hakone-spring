package com.kh.cookie;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CookieController {

	@GetMapping("create")
	public String create(HttpServletResponse r) {
		
		// cookie 만들기 name, value 필수
		Cookie cookie = new Cookie("cookie", "NewJeans");
		
		Cookie saveId = new Cookie("saveId", "user01");
		
		// 만료시간(필수아님)
		cookie.setMaxAge(60*60*24);
		
		// 객체를 생성한 다음 응답정보에 첨부
		r.addCookie(cookie);
		r.addCookie(saveId);
		
		return "cookie";
	}
	
	@GetMapping("delete")
	public String delete(HttpServletResponse r) {
		
		// 쿠키는 따로 삭제명령이 없음
		// 만료시간을 0 으로 설정
		
		Cookie cookie = new Cookie("cookie", "ddd");
		Cookie saveId = new Cookie("saveId", "user01");
		
		saveId.setMaxAge(0);
		cookie.setMaxAge(0);
		
		r.addCookie(cookie);
		r.addCookie(saveId);
		
		return "cookie";
	}
	
	@GetMapping("join")
	public String join() {
		return "join";
	}
	
	@GetMapping("ad")
	public String ad() {
		return "ad";
	}
	
	@GetMapping("hani")
	public String hani() {
		return "hani";
	}
	
}
