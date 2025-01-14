package com.kh.od.api.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.net.URLEncoder;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
@RequestMapping(value="busan", produces="application/json; charset=UTF-8")
public class BusanController {

	@GetMapping
	public ResponseEntity<?> getBusan(String page) throws IOException, URISyntaxException{
		
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/6260000/FoodService/getFoodKr"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=%2FbEm2MzPgq8b1wvJoMA3I%2Bi%2FoTi3rgaTQSHROwI29QDna%2F1bIIhYT56PnyH4Hg4yMZxTaC7Tq3Wx7SC8pKuBiA%3D%3D"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode(page, "UTF-8")); /*페이지번호*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("resultType","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*JSON방식으로 호출 시 파라미터 resultType=json 입력*/
        URI url = new URI(urlBuilder.toString());
        RestTemplate rt = new RestTemplate();
        String response =  rt.getForObject(url, String.class);
		
		return ResponseEntity.ok(response);
	}
	
}
