package com.kh.hyper.api.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import com.kh.hyper.api.model.dto.BusanDTO;

@Mapper
public interface CommentMapper {

	@Insert("INSERT INTO TB_FOOD_REPLY VALUES(#{writer}, #{content}, #{foodNo})")
	void save(BusanDTO comment);
	
	List<BusanDTO> getComment(Long foodNo);
	
}
