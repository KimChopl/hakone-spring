<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>airairairairairairairairair</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
	<h1>지역별 대기오염 상태</h1>
	시 / 도 : <br>
	<select id="sidoName">
		<option>전국</option>
		<option>서울</option>
		<option>부산</option>
		<option>대구</option>
		<option>인천</option>
		<option>광주</option>
		<option>대전</option>
		<option>울산</option>
		<option>경기</option>
		<option>강원</option>
		<option>충북</option>
		<option>충남</option>
		<option>전북</option>
		<option>전남</option>
		<option>경북</option>
		<option>경남</option>
		<option>제주</option>
		<option>세종</option>
	</select>
	<br>
	<button class="btn btn-sm btn-info" id="btn1">해당 지역 대기 정보 확인하기</button>
	<br><br>
	
	<table class="table table-hover">
		<thead class="thead-dark">
			<tr>
				<th>측정소명</th>
				<th>미세먼지농도</th>
				<th>일산화탄소농도</th>
				<th>측정일시</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th colspan="4">지역 선택 후 조회 버튼 클릭</th>
			</tr>
		</tbody>
	</table>
	
	<script>
		$(function(){
			const sidoName = document.getElementById('sidoName');
			const btn1 = document.getElementById('btn1');
			btn1.onclick = () => {
				$.ajax({
					url : "search.air",
					type : "get",
					data : {
						sidoName : sidoName.value
					},
					success : function(r){
						console.log(r);
						/* json 가공
						console.log(r.response.body.items)
						const replies = [...r.response.body.items]
						const result = replies.map(e => 
							`<tr>
								<td>\${e.stationName}</td>
								<td>\${e.pm10Value}</td>
								<td>\${e.coValue}</td>
								<td>\${e.dataTime}</td>
							<tr>`
						).join('');
						$('tbody').html(result);
						*/
						
						//xml 가공
						console.log($(r).find('item')[0])
						const items = $(r).find('item')
						let value = '';
						items.each((i, item) => {
							value += `<tr>
								<td>\${$(item).find('stationName').text()}</td>
								<td>\${$(item).find('pm10Value').text()}</td>
								<td>\${$(item).find('coValue').text()}</td>
								<td>\${$(item).find('dataTime').text()}</td>
							<tr>`
						});
						
						$('tbody').html(value);
					}
						
					
				})
			}
		})
	</script>
	
</body>
</html>