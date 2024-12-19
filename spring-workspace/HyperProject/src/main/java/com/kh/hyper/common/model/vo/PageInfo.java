package com.kh.hyper.common.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@AllArgsConstructor
@Builder
public class PageInfo {
	
	private int listCount;
	private int currentPage;
	private int baordLimit;
	private int pageLimit;
	
	private int maxPage;
	private int startPage;
	private int endPage;
	
}