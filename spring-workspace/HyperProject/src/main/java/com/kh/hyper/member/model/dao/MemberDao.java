package com.kh.hyper.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.hyper.member.model.vo.Member;

@Repository
public class MemberDao {

	public Member login(SqlSessionTemplate ssn, Member m) {
		return ssn.selectOne("memberMapper.login", m);
	}

	public int join(SqlSessionTemplate ssn, Member m) {
		return ssn.insert("memberMapper.join", m);
	}

}
