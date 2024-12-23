package com.kh.hyper.member.model.service;

import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Transactional;

import com.kh.hyper.common.MemberVaildator;
import com.kh.hyper.common.PasswordEncryptor;
import com.kh.hyper.exception.NotMatchLengthException;
import com.kh.hyper.exception.PasswordNotAccordException;
import com.kh.hyper.exception.UserFoundException;
import com.kh.hyper.exception.UserIdNotFoundException;
import com.kh.hyper.member.model.dao.MemberMapper;
import com.kh.hyper.member.model.vo.Member;

import lombok.RequiredArgsConstructor;

@EnableTransactionManagement // 이 클래스 안에서 다중 트렌젝션 하겠다
@RequiredArgsConstructor
@Service
public class MemberServiceImpl implements MemberService {

	//private final MemberDao md;
	//private final SqlSessionTemplate ssn; // 기존의 MyBatis의 sqlSession
	
	private final MemberMapper mp;
	private final PasswordEncryptor pwe;
	private final MemberVaildator mvd;
	
	/*
	public MemberServiceImpl(MemberDao md, SqlSessionTemplate ssn) {
		this.md = md;
		this.ssn = ssn;
	}
	*/
	
	@Override
	public Member login(Member m) {
		//Member loginUser = md.login(ssn, m);
		// 스프링이 사용 후 자동으로 객체를 반납해주도록 설정했기 때문에 close()호출하지 않음
		//return loginUser;
		//return mp.login(m);
		// 경우의 수
		// 1. 아이디 없음
		// 2. 비밀번호 안맞음
		// 3. 정상적으로 조회 성공
		Member loginUser = mp.login(m);
		
		if(loginUser == null) {
			throw new UserIdNotFoundException("아이디조회 실패"); // 예외를 발생시켜 ExceptionHandler를 통해 작업 할 수 있음
		}
		
		if(pwe.matches(m.getUserPwd(), loginUser.getUserPwd())) {
			return loginUser;			
		} else {
			throw new PasswordNotAccordException("비밀번호 불일치");
		}
		
	}

	@Override
	@Transactional // 다중 트랜잭션 할 곳 지정
	public void join(Member m) {

		//mp.test();  
		//return mp.join(m); // 예외가 발생하면 정상적인 화면을 띄울 수 없음
		/*
		try {
			mp.join(m);
			mp.test();
			return 1;
		} catch(DuplicateKeyException e) {
			return 0;
		} // 예외처리를 통해 정상적인 화면이 뜰 수 있도록 해주어야함
		 * */
		//Member userInfo = mp.login(m);
		//mvd.vildateDuplicateMember(m);
		//mvd.vildateIdLength(m);
		/*
		if(userInfo != null && m.getUserId().equals(userInfo.getUserId())) {
			throw new UserFoundException("이미 있는 아이디");
		}
		
		if(m.getUserId().length() > 30 || m.getUserId().length() < 6) {
			throw new NotMatchLengthException("길이가 맞지 않음");
		}
		 */
		mvd.validateJoinMember(m);
		m.setUserPwd(pwe.encode(m.getUserPwd()));
		mp.join(m);
		
	}

	@Override
	public void update(Member m) {
		
		/*
		Member userInfo = mp.login(m);
		if(userInfo == null) {
			throw new UserIdNotFoundException("없는 아이디");
		}
		if(m.getUserName().length() > 5) {
			throw new NotMatchLengthException("길이가 맞지 않음");
		}*/
		mvd.validateMemberExists(m);
		mp.update(m);
	}

	@Override
	public void delete(String userPwd, HttpSession ssn) {
		Member loginUser = (Member)ssn.getAttribute("loginUser");
		//Member userInfo = mp.login(loginUser);
		
		Member userInfo = mvd.validateMemberExists(loginUser);
		loginUser.setUserPwd(userInfo.getUserPwd());
		/*
		if(userInfo == null) {
			throw new UserIdNotFoundException("이미 없는디?");
		}
		*/
		if(!!pwe.matches(loginUser.getUserPwd(), userInfo.getUserPwd())) {
			throw new PasswordNotAccordException("비밀번호 불일치");
		}
		mp.delete(userInfo);
	}

	@Override
	public String checkId(String userId) {
		return mp.checkId(userId) > 0 ? "NNNNN" : "NNNNY";
	}
	

	

}
