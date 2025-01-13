package com.kh.od.api.controller;

import java.net.URI;
import java.net.URISyntaxException;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
@RequestMapping(value="horse", produces="application/json; charset=UTF-8")
public class HorseController {
	
	@GetMapping
	public ResponseEntity<String> youCanCenter(@RequestParam(name="pageNo") int pageNo) throws URISyntaxException {
		System.out.println(pageNo);
		String url = "https://apis.data.go.kr/B551015/API304/ucan_info";
		url += "?serviceKey=%2FbEm2MzPgq8b1wvJoMA3I%2Bi%2FoTi3rgaTQSHROwI29QDna%2F1bIIhYT56PnyH4Hg4yMZxTaC7Tq3Wx7SC8pKuBiA%3D%3D";
		url += "&pageNo=" + pageNo;
		url += "&numOfRows=3";
		url += "&_type=json";
		
		RestTemplate rt = new RestTemplate();
		
		URI uri = new URI(url);
		String response = rt.getForObject(uri, String.class);
		return ResponseEntity.ok(response);
	}
	//https://openapi.naver.com/v1/search/kin
	
	
}
