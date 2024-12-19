package com.kh.hyper.member.model.service;

import javax.servlet.http.HttpSession;

import com.kh.hyper.member.model.vo.Member;

public interface MemberService {
	//Member login(Member m);
	
	//int join(Member m);
	
	//int update(Member m);
	
	//int delete(String userPwd, HttpSession ssn);
	
	Member login(Member m);
	
	void join(Member m);
	
	void update(Member m);
	
	void delete(String userPwd, HttpSession ssn);
	
	void aa();
}
