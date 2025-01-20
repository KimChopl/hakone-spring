package com.kh.hyper.api.model.service;

import java.util.List;

import com.kh.hyper.api.model.dto.BusanDTO;

public interface BusanService {

	String getBusan(int page);
	
	String getBusanDetail(int pk);
	
	void save(BusanDTO comment);
	
	List<BusanDTO> getComment(Long foodNo);
	
}
