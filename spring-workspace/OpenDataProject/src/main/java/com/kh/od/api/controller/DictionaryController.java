package com.kh.od.api.controller;

import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URLEncoder;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
@RequestMapping(value="dictionary", produces="application/json; charset=UTF-8")
public class DictionaryController {
	
	@PostMapping
	public ResponseEntity<?> getDictionary(String search) throws UnsupportedEncodingException, URISyntaxException{
		/*
		StringBuilder uriBuilder = new StringBuilder("https://opendict.korean.go.kr/api/search");
		uriBuilder.append("?key=4C30E97A29E82C5CC5322481C28DCDA0");
		uriBuilder.append("&q=" + URLEncoder.encode(search, "UTF-8"));
		uriBuilder.append("&req_type=json");
		//uriBuilder.append("&advanced=y");
		//uriBuilder.append("&target=1");
		 * */
		StringBuilder uriBuilder = new StringBuilder("https://api.api-ninjas.com/v1/cocktail?name=" + URLEncoder.encode(search, "UTF-8"));
		uriBuilder.append("&X-Api-Key=FH0siyZKpe5eZe0zYMk5xg==CSEd97YwoV8UK9pV");
		URI uri = new URI(uriBuilder.toString());
		RestTemplate rt = new RestTemplate();
		String response =  rt.getForObject(uri, String.class);
		System.out.println(response);
		
		
		return ResponseEntity.ok(response);
		
		
	}
}
