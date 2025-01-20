package com.kh.hyper.api.model.service;

import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URLEncoder;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.kh.hyper.api.model.dao.CommentMapper;
import com.kh.hyper.api.model.dto.BusanDTO;

import lombok.RequiredArgsConstructor;


@Service
@RequiredArgsConstructor
public class BusanServiceImpl implements BusanService {
	
	private final CommentMapper cm;

	@Override
	public String getBusan(int page) {
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/6260000/FoodService/getFoodKr"); /*URL*/
		URI url = null;
        try {
        	urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=BrWa3Fka63QTF54zG7oxdZGzOn1JAxyLZlksuF5C1GzlZwLBHUz8efmQqtRirC%2Fp%2BI9ftZZshTvS3Npzbmf5Mw%3D%3D"); /*Service Key*/
			urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + page);
			urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("6", "UTF-8")); /*한 페이지 결과 수*/
			urlBuilder.append("&" + URLEncoder.encode("resultType","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*JSON방식으로 호출 시 파라미터 resultType=json 입력*/
			url = new URI(urlBuilder.toString());
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
        RestTemplate rt = new RestTemplate();
        String response =  rt.getForObject(url, String.class);
        return response;
	}

	@Override
	public String getBusanDetail(int pk) {
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/6260000/FoodService/getFoodKr"); /*URL*/
		URI url = null;
        try {
			urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=BrWa3Fka63QTF54zG7oxdZGzOn1JAxyLZlksuF5C1GzlZwLBHUz8efmQqtRirC%2Fp%2BI9ftZZshTvS3Npzbmf5Mw%3D%3D");
			urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
			urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /*한 페이지 결과 수*/
			urlBuilder.append("&" + URLEncoder.encode("resultType","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*JSON방식으로 호출 시 파라미터 resultType=json 입력*/
			urlBuilder.append("&UC_SEQ=" + pk);
			url = new URI(urlBuilder.toString());
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}  catch (URISyntaxException e) {
			e.printStackTrace();
		}
        RestTemplate rt = new RestTemplate();
        String response =  rt.getForObject(url, String.class);

        
		return response;
	}

	@Override
	public void save(BusanDTO comment) {
		
		cm.save(comment);
		
	}

	@Override
	public List<BusanDTO> getComment(Long foodNo) {
		return cm.getComment(foodNo);
	}

}
