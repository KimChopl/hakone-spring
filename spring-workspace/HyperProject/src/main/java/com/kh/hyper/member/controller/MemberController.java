package com.kh.hyper.member.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

//import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.hyper.common.ModelAndViewUtil;
import com.kh.hyper.member.model.service.MemberService;
import com.kh.hyper.member.model.vo.Member;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor // 롬복에서 제공하는 에노테이션
public class MemberController {
	/*
	@RequestMapping(value="login.me") // RequestMapping 타입의 애노테이션을 등록함으로 HandlerMapping을 등록할 수 있음
	public void login() {
		System.out.println("login.me 요청 받음");
	}
	 * */
	/*
	 * Spring에서 요청시 전달 값(Parameter)를 받아서 사용하는 방법
	 * 
	 * 1. HttpServletRequest를 이용해서 전달받기 -> 기존방식과 동일
	 *  => 핸들러의 매개변수로 HttpServletRequest타입을 작성하면 DispatcherServlet이 해당 메소드를 호풀할 떄 request 객체를 전달해서 매개변수로 주입해줌
	 *  
	 * 2. @RequestParam 이용하는 방법
	 *  => request.getParameter()를 대신 수행해줌 -> value 속성에 jsp로 작성한 키 값을 적으면 알아서 해당 매개변수에 주입해줌
	 *  
	 * 3. @RequestParam 생략하기
	 *  => 매개변수 명을 jsp에서 전달한 key값과 동일하게 세팅해줘야 함 -> key값의 의미가 명확하지 않고 defaultValue 속성을 사용하지 못함
	 *  
	 * 4. 커맨드 객체 방식
	 *  => 전달되는 키값과 객체의 필드명이 동일해야함
	 *  => 객체의 기본생성자가 반드시 존재해야함
	 *  => 객체의 setter 매소드가 반드시 존재해야함
	 *  
	 *  스프링에서 해당 객체를 객체의 기본생성자를 통해서 생성한 후 내부적으로 setter매소드를 찾아서 요청 시 전달값을 해당 필드에 담아줌
	 */
	/*
	 * 1. 
	@RequestMapping(value="login.me")
	public String login(HttpServletRequest r) {
	
		String id = r.getParameter("id");
		String pwd = r.getParameter("pwd");
		
		System.out.println(id + " : " + pwd);
		
		return "main";
	}
	 */
	/* 2.
	@RequestMapping("login.me")
	public String login(@RequestParam(value="id", defaultValue = "hihih") String id, @RequestParam(value="pwd") String pwd) {
		System.out.println(id + " : " + pwd);
		return "main";
	}
	*/
	/*
	 * 3.
	@RequestMapping("login.me")
	public String login(String id, String pwd) {
		//System.out.println(id + " : " + pwd);
		
		Member m = new Member();
		m.setUserId(id);
		m.setUserPwd(pwd);
		return "main";
	}
	 */
	/*
	 * 4.
	 */
	// @Autowired // 필드 주입 => 편함
	private final MemberService ms;
	private final ModelAndViewUtil mv;
	//private final BCryptPasswordEncoder pwe; // 롬복사용시 final이 붙지 않으면 생성자가 생기지 않음
	
	/*@Autowired // 생성자 주입 => 실행하자마자 bean에 등록 -> NullPointException 제거 => 매개변수와 일치하는 타입의 bean객체를 검색해서 인자값으로 주입함
	public MemberController(MemberService ms, BCryptPasswordEncoder pwe) {
		this.ms = ms;
		this.pwe = pwe;
	}*/
	
	/*
	@RequestMapping("login.me")
	public String login(Member m) {
		//System.out.println(m);
		// Service 클래스의 수정이 일어날 경우 Service 클래스를 의존하고 있던 Controller가 영향을 받게 됨
		Member loginUser = ms.login(m);
		System.out.println(loginUser);
		 * 
		if(loginUser != null) {

		} else {
			
		}
		return null;
		return null;
	}
		 */
	/*
	 * Client의 요청 처리 후 응답데이터를 담아서 응답페이지로 포워딩 또는 URL재요청 하는 방법
	 * 
	 *  1. 스프링에서 제공하는 Model 객체 사용
	 *  포워딩할 응답 뷰로 전달하고자 하는 데이터를 맵형식(key value)으로 담을 수 있는 영역 Model 객체는 requestScope
	 *  
	 *  단 setAttribute()가 아닌 addAttribute()사용
	@PostMapping("login.me")
	public String login(Member m, Model model, HttpSession session) {
		Member loginUser = ms.login(m);
		if(loginUser != null) {
			session.setAttribute("loginUser", loginUser);
			
			//return "main"; // => 포워딩임 지금 필요한건 Redirect
			return "redirect:/";
		} else { // 애러문구를 reqyestScope에 담아서 포워딩
			model.addAttribute("errorMsg", "로그인 실패");
			// String Type return -> viewName에 대입 -> DispatcherServlet으로 이동 -> ViewResolver로 이동
			// 	-prefix : /WEB-INF/views/ + return viewName + suffix : .jsp  
			return "common/error_page";
		}
	}
	 */
	/*
	 *  2. ModelAndView타입 사용하기
	 *  View는 응답 뷰에 대한 정보를 담음
	 *  Model과 View를 합침 => ModelAndView
	 */
	
	@PostMapping("login.me")
	public ModelAndView login(Member m, HttpSession hs, HttpServletRequest request) {
	
		
		
		//BCryptPasswordEncoder : matches()
		// matches(평문 , 암호문) => 암호문에 포함되어있는 버전과 반복횟수와 salt 값을 가지고 인자로 전달된 평문을 다시 암호화를 거쳐서 두 번째 인자로 전달된 암호문과 같은지 다른지를 비교한 결과 값을 반환
		/*
		if(loginUser != null && pwe.matches(m.getUserPwd(), loginUser.getUserPwd())) { // 포트서킷 연산 -> 앞에서 false가 나오면 뒤는 연산하지 않음
			hs.setAttribute("loginUser", loginUser);
			mv.setViewName("redirect:/");
			
		} else {
			mv.addObject("errorMsg", "로그인 실패").setViewName("common/error_page");
		}*/
		Member loginUser = ms.login(m);
		hs.setAttribute("loginUser", loginUser);
		//mv.setViewName("redirect:/");
		return mv.setViewNameAndData("redirect:/", null);
	}
	
	@GetMapping("logout.me")
	public String logout(HttpSession hs) {
		hs.removeAttribute("loginUser");
		return "redirect:/";
	}
	
	@GetMapping("enrollform.me")
	public String enrollForm() {
		return "member/enroll_form";
	}
	
	@PostMapping("join.me")
	public ModelAndView join(Member m /*HttpServletRequest res*/) {
		//System.out.println(m);
			//res.setCharacterEncoding("UTF-8"); // 얘 써도 한글이 여전히 꺠짐 -> 값을 이미 뽑았기 때문에 인코딩을 해도 의미가 없음 -> filter를 통해 인코딩 해주어야함 -> 인코딩 등록 필요
												 // int 자료형의 자리에 빈 문자열이 올 경우 빈 문자열을 Binding해 int로 parsing 하지 못하는 문제가 발생 -> NumberFormatException발생
												 // 민감한 정보와 관련해서 입력값 그대로를 받아오는 경우가 생김 -> ex) 비밀번호 => 암호화가 필요함
		// 암호화하기 -> Spring Security Modules에서 제공(.xml) -> passwordEncoder를 .xml파일을 이용해서 configurationBean으로 Bean등록 ==> web.xml에서 seurity-context.xml 파일을 로딩할 수 있도록 추가
		//log.info("평문 : {}", m.getUserPwd());
		//String encPwd = pwe.encode(m.getUserPwd());
		//log.info("암호화 : {}", encPwd);
		//m.setUserPwd(encPwd);
		ms.join(m);
		/*
		 * 
		if(result > 0) {
			mv.setViewName("redirect:/");
		} else {
			mv.addObject("errorMsg", "회원가입 실패").setViewName("common/error_page");
		}
		 */
		//mv.setViewName("redirect:/");
		return mv.setViewNameAndData("redirect:/", null);
	}
	
	@GetMapping("myPage.me")
	public String myPage() {
		return "member/my_page";
	}
	
	@PostMapping("update.me")
	public ModelAndView update(Member m, HttpSession ssn) {
		ms.update(m);
		/*
		 * 
		if(result > 0) {
			ssn.setAttribute("loginUser", ms.login(m));
			ssn.setAttribute("alertMsg", "놓치니까 개빡세누");
			mv.setViewName("redirect:myPage.me");
		} else {
			mv.addObject("errorMsg", "수정 실패").setViewName("common/error_page");
		}
		 */
		ssn.setAttribute("loginUser", ssn.getAttribute("loginUser"));
		ssn.setAttribute("alertMsg", "놓치니까 개빡세누");
		String viewName = "redirect:myPage.me";
		
		return mv.setViewNameAndData(viewName, null);
	}
	
	@PostMapping("delete.me")
	public ModelAndView delete(String userPwd, HttpSession ssn) {
		//Member loginUser = ((Member)ssn.getAttribute("loginUser"));
		//String encPwd = loginUser.getUserPwd();
		/*if(pwe.matches(userPwd, encPwd)) {
			if(ms.delete(loginUser, ssn) > 0) {
			} else {
				ssn.setAttribute("alertMsg", "탈퇴 실패");
				return "redirect:myPage.me";
			}
		} else {
			ssn.setAttribute("alertMsg", "탈퇴 실패");
			return "redirect:myPage.me";
		}*/
		ms.delete(userPwd, ssn);
		ssn.removeAttribute("loginUser");
		ssn.setAttribute("alertMsg", "탈퇴 완료");
		//mv.setViewName("redirect:/");
		String viewName = "redirect:/";
		return mv.setViewNameAndData(viewName, null);
	}
	
	/*
	private ModelAndView setViewNameAndData(String viewName, String key, Object data) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName(viewName);
		if(key != null && data != null) {
			
		mv.addObject(key, data);
		}
		return mv;
	}
	*/
}
