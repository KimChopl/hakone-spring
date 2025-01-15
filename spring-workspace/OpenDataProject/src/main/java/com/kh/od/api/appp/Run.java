package com.kh.od.api.appp;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

public class Run {
	/*
	 * {	"lastBuildDate":"Mon, 13 Jan 2025 17:29:16 +0900",	
	 *   	"total":3605,	
	 *   	"start":1,	
	 *   	"display":10,	
	 *   	"items":[		
	 *   	{			"title":"<b>그린팩토리<\/b> 기업이 하고 있는 활동이 뭔가요?",			
	 *   				"link":"https:\/\/kin.naver.com\/qna\/detail.naver?d1id=11&dirId=1122&docId=449822335&qb=6re466aw7Yyp7Yag66as&enc=utf8&section=kin.qna&rank=1&search_sort=0&spq=0",			
	 *   				"description":"<b>그린팩토리<\/b>는 폐기물 문제를 해결하고자 하는 기업인거는 아는데 무슨 폐기물을 수거하고 무슨 폐기물을 이용해 제품을 생산하는지 <b>그린팩토리<\/b>가 하는 활동을 자세히 알려주세요 
	 *   								<b>그린팩토리<\/b>는 폐기물을 수거하고 재활용하여 제품을... "		},		
	 *   
	 *   ...
	 */

	 public static void main(String[] args) {
	        String clientId = "7oxRMuQ5yhgTz4zLwmoC"; //애플리케이션 클라이언트 아이디
	        String clientSecret = "fk5HtikJuo"; //애플리케이션 클라이언트 시크릿


	        String text = null;
	        try {
	            text = URLEncoder.encode("KH정보교육원", "UTF-8");
	        } catch (UnsupportedEncodingException e) {
	            throw new RuntimeException("검색어 인코딩 실패",e);
	        }


	        String apiURL = "https://openapi.naver.com/v1/search/kin.json?query=" + text;    // JSON 결과
	        //String apiURL = "https://openapi.naver.com/v1/search/blog.xml?query="+ text; // XML 결과


	        Map<String, String> requestHeaders = new HashMap();
	        requestHeaders.put("X-Naver-Client-Id", clientId);
	        requestHeaders.put("X-Naver-Client-Secret", clientSecret);
	        String responseBody = get(apiURL,requestHeaders);


	        System.out.println(responseBody);
	    }


	    private static String get(String apiUrl, Map<String, String> requestHeaders){
	        HttpURLConnection con = connect(apiUrl);
	        try {
	            con.setRequestMethod("GET");
	            for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
	                con.setRequestProperty(header.getKey(), header.getValue());
	            }


	            int responseCode = con.getResponseCode();
	            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
	                return readBody(con.getInputStream());
	            } else { // 오류 발생
	                return readBody(con.getErrorStream());
	            }
	        } catch (IOException e) {
	            throw new RuntimeException("API 요청과 응답 실패", e);
	        } finally {
	            con.disconnect();
	        }
	    }


	    private static HttpURLConnection connect(String apiUrl){
	        try {
	            URL url = new URL(apiUrl);
	            return (HttpURLConnection)url.openConnection();
	        } catch (MalformedURLException e) {
	            throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
	        } catch (IOException e) {
	            throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
	        }
	    }


	    private static String readBody(InputStream body){
	        InputStreamReader streamReader = new InputStreamReader(body);


	        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
	            StringBuilder responseBody = new StringBuilder();


	            String line;
	            while ((line = lineReader.readLine()) != null) {
	                responseBody.append(line);
	            }


	            return responseBody.toString();
	        } catch (IOException e) {
	            throw new RuntimeException("API 응답을 읽는 데 실패했습니다.", e);
	        }
	    }
	    
}
