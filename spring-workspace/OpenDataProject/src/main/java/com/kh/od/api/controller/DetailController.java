package com.kh.od.api.controller;

import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URLEncoder;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.client.RestTemplate;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Controller
public class DetailController {
	
	@GetMapping("detail/{p}")
	public String goDetail(@PathVariable(name="p") int p, Model m) throws UnsupportedEncodingException, URISyntaxException {
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/6260000/FoodService/getFoodKr"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=%2FbEm2MzPgq8b1wvJoMA3I%2Bi%2FoTi3rgaTQSHROwI29QDna%2F1bIIhYT56PnyH4Hg4yMZxTaC7Tq3Wx7SC8pKuBiA%3D%3D"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("resultType","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*JSON방식으로 호출 시 파라미터 resultType=json 입력*/
        urlBuilder.append("&UC_SEQ=" + p);
        URI url = new URI(urlBuilder.toString());
        RestTemplate rt = new RestTemplate();
        String response =  rt.getForObject(url, String.class);

        // java에서 GSON이용해서 값 가공해서 보내기
        JsonObject jo = JsonParser.parseString(response).getAsJsonObject();
        //System.out.println(jo.getAsJsonObject("getFoodKr").getAsJsonArray("item")); // 값 뽑아오는 방법
        JsonObject item = jo.getAsJsonObject("getFoodKr").getAsJsonArray("item").get(0).getAsJsonObject();
        
        String lat = item.get("LAT").getAsString();
        String lng = item.get("LNG").getAsString();
        String day = item.get("USAGE_DAY_WEEK_AND_TIME").getAsString();
        String img = item.get("MAIN_IMG_NORMAL").getAsString();
        String desc = item.get("ITEMCNTNTS").getAsString();
        String title = item.get("TITLE").getAsString();
        
        m.addAttribute("lat", lat);
        m.addAttribute("lng", lng);
        m.addAttribute("day", day);
        m.addAttribute("img", img);
        m.addAttribute("desc", desc);
        m.addAttribute("title", title);
        
        return "busan/detail";
	}

}
