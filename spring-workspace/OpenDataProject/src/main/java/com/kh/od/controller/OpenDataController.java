package com.kh.od.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class OpenDataController {
	
	@GetMapping("air.do")
	public String ariPage() {
		return "air/air";
	}
	@GetMapping("horse.do")
	public String horesPage() {
		return "horse/horse";
	}
	
	

}
