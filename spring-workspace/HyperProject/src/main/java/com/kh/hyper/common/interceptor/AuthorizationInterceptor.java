package com.kh.hyper.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.hyper.member.model.vo.Member;

public class AuthorizationInterceptor extends HandlerInterceptorAdapter {
	
	public boolean preHandler(HttpServletRequest request, HttpServletResponse response, Object H) throws Exception {
		
		HttpSession ssn = request.getSession();
		Member member = (Member)ssn.getAttribute("loginUser");
		String boardWriter = request.getParameter("boardWriter");
		
		if(member != null && boardWriter.equals(member.getUserId())) {
			return true;
		} else {
			ssn.setAttribute("alertMsg", "??");
			response.sendRedirect(request.getContextPath());
			return false;
		}
		
	}
	
}
