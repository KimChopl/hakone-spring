package com.kh.od.api.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.net.URLEncoder;

import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.google.gson.Gson;

@RestController
@RequestMapping(produces="text/xml; charset=UTF-8")
public class AirController {
	
	@GetMapping("air")
	public Gson airPollution(String sidoName, HttpSession ssn) throws IOException {
		
		// java언어로 만든 Client 프로그램으로 API서버로 요청 보내고 응답 받기
		
		String url = "http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty";
		url += "?serviceKey=%2FbEm2MzPgq8b1wvJoMA3I%2Bi%2FoTi3rgaTQSHROwI29QDna%2F1bIIhYT56PnyH4Hg4yMZxTaC7Tq3Wx7SC8pKuBiA%3D%3D";
		if(sidoName == null) {
			sidoName = "전국";
		}
		url += "&sidoName=" + URLEncoder.encode(sidoName, "UTF-8");
		url += "&returnType=json";
		
		// HttpURLContection 객체를 통해 API서버로 요청
		// java.net.URL 객체 생성
		
		URL sendUrl = new URL(url);
		
		// URL객체를 통해 HttpURLConnection 생성
		HttpURLConnection urlConnection = (HttpURLConnection)sendUrl.openConnection();
		
		// 요청에 필요한 Header설정
		urlConnection.setRequestMethod("GET");
		
		// API서버와 Stream연결
		BufferedReader br =  new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));

		/*
		while(br.ready()) {
			System.out.println(br.readLine());
		}
		*/
		String result = br.readLine();
		System.out.println(result);
		Gson gson = new Gson();
		gson.toJson(result);
		// 자원반납
		br.close();
		urlConnection.disconnect();
		
		return gson;
		
	}
	
	
	@GetMapping("search.air")
	public ResponseEntity<String> searchAir(String sidoName) throws IOException, URISyntaxException {
		
		String url = "http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty";
		url += "?serviceKey=%2FbEm2MzPgq8b1wvJoMA3I%2Bi%2FoTi3rgaTQSHROwI29QDna%2F1bIIhYT56PnyH4Hg4yMZxTaC7Tq3Wx7SC8pKuBiA%3D%3D";
		if(sidoName == null) {
			sidoName = "전국";
		}
		url += "&sidoName=" + URLEncoder.encode(sidoName, "UTF-8");
		//url += "&returnType=json";
		
		/*
		URL sendUrl = new URL(url);
		
		HttpURLConnection urlConnection = (HttpURLConnection)sendUrl.openConnection();
		
		urlConnection.setRequestMethod("GET");
		
		BufferedReader br =  new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
		
		String result = br.readLine();
		
		br.close();
		urlConnection.disconnect();
		 */

		RestTemplate rt = new RestTemplate();
		
		URI uri = new URI(url);
		
		String response = rt.getForObject(uri, String.class);
		
		return ResponseEntity.ok(response);
		
	}

}
