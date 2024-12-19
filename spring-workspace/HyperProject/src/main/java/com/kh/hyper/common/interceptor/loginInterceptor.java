package com.kh.hyper.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class loginInterceptor extends HandlerInterceptorAdapter {
	/*
	 * 	interceptor
	 * 
	 * 	RequestHandler가 호출되기 전 실행한 후 가로채서 실행할 내용을 작성 가능
	 * 
	 *  preHandler : 핸들러 호출 전 낚아챔
	 *  postHandler : 핸들러 호출 후 낚아챔
	 * 
	 */
	public boolean preHandler(HttpServletRequest request, HttpServletResponse response, Object H) throws Exception {
		HttpSession ssn = request.getSession();
		if(ssn.getAttribute("loginUser") != null) {
			return true;
		} else {
			ssn.setAttribute("alertMsg", "??");
			response.sendRedirect(request.getContextPath());
			return false;
		}
	}
}
