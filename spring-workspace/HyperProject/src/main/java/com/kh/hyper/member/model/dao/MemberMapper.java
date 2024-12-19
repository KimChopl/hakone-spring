package com.kh.hyper.member.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kh.hyper.member.model.vo.Member;

@Mapper
public interface MemberMapper {
	
	Member login(Member m);
	
	int join(Member m);

	int update(Member m);

	int delete(Member m);
	
	int test();
	

}
