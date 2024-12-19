package com.kh.hyper.common;

import org.springframework.stereotype.Component;

import com.kh.hyper.exception.NotMatchLengthException;
import com.kh.hyper.exception.UserFoundException;
import com.kh.hyper.exception.UserIdNotFoundException;
import com.kh.hyper.member.model.dao.MemberMapper;
import com.kh.hyper.member.model.vo.Member;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class MemberVaildator {

	private final MemberMapper mp;
	
	public void validateDuplicateMember(Member m) {
		Member exitingmember = mp.login(m);
		if(exitingmember != null && !m.getUserId().equals(exitingmember.getUserId())) {
			throw new UserFoundException("이미 있는 아이디");
		}
	}
	
	public void validateIdLength(Member m) {
		if(m.getUserId().length() > 30 || m.getUserId().length() < 6) {
			throw new NotMatchLengthException("길이가 맞지 않음");
		}
	}
	
	public void validateJoinMember(Member m) {
		 validateDuplicateMember(m);
		validateIdLength(m);
	}
	
	public Member validateMemberExists(Member m) {
		Member exitingMember = mp.login(m);
		if(exitingMember != null) {
			return exitingMember;
		}
		throw new UserIdNotFoundException("계정이 없다아");
	}
	
}
