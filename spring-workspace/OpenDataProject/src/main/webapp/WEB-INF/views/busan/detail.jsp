<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=277e050783f777235e5cffc55a5ac24d"></script>
    <style>
    	#content{
    		width : 93%;
    		border : 0.5px solid rgb(0,0,0,0.3);
    		height : 300px;
    	}
    	#title{
    		color:orangered;
    		font-size : 50px;
    	}
    	#content-1{
    		width : 43%;
    		height : 100%;
    	}
    	#content-2{
    		width : 57%;
    		height : 100%;
    		background-image : url('${img}');
    		background-size : 100%;
    		vackground-repeat : no-repeat;
    	}
    	#content-1-1{
    		width : 100%;
    		height : 20%;
    		font-size : 32px;
    	}
    	#content-1-2{
    		width : 100%;
    		height : 80%;
    		font-size : bold;
    	}
    </style>
</head>
<body>
	<h1><label>${ title }</label></h1>
	<div id="content">
		<div id="content1">
			<div id="content-1-1">
				영업일자 : ${ day }
			</div>
			<div id="content-1-2">
				상세 내용 : <br>
				${ desc }
			</div>
		</div>
		<div id="content-2">
		
		</div>
	</div>
	
	<div id="map" style="width:100%;height:350px;"></div>
	
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new kakao.maps.LatLng(${lat}, ${lng}), // 지도의 중심좌표
		        level: 4 // 지도의 확대 레벨
		    };
		
		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
		var imageSrc = '${img}', // 마커이미지의 주소입니다    
		    imageSize = new kakao.maps.Size(64, 69), // 마커이미지의 크기입니다
		    imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
		      
		// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
		    markerPosition = new kakao.maps.LatLng(${lat}, ${lng}); // 마커가 표시될 위치입니다
		
		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition, 
		    image: markerImage // 마커이미지 설정 
		});
		
		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);  
	</script>
	
</body>
</html>