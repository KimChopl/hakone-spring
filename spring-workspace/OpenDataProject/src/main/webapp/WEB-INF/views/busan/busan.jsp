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
</head>
<body>
	
	<h1 align="center">세금이 인정한 부산 맛집</h1>
	
	<table class="table table-hover table-dark">
		<thead>
			<tr>
				<th>제목</th>
				<th>대표 매뉴</th>
				<th>구군</th>
				<th>주소</th>
				<th>이미지</th>
				<th>상세 보기</th>
			</tr>
		</thead>
		<tbody class="table-info" style="color:black">
			
		</tbody>
	</table>
	<hr>
	<button id="more" class="btn btn-sm btn-outline-success">더보기</button>
	<script>
		$(function(){
			let pageNo = 1;
			function getBusan(){
				$.ajax({
					url : 'busan',
					data : {
						page : pageNo
					},
					success : r => {
						
						const items = r.getFoodKr.item
						const result = items.map(e =>
							`<tr>
								<td>\${e.TITLE}</td>
								<td>\${e.RPRSNTV_MENU}</td>
								<td>\${e.GUGUN_NM}</td>
								<td>\${e.ADDR1}</td>
								<td>
								<img src="\${e.MAIN_IMG_THUMB}" width="200px" height="160px" />
								</td>
								<td>
									<button class="btn btn-sm btn-outline-danger" onclick="goDetail(\${e.UC_SEQ})">상세 보기</button>
								</td>`
						).join('');
						$('tbody').append(result)
						pageNo += 1;
					}
				})
			};
			$('#more').click(getBusan);
			getBusan();
		})
		function goDetail(p){
			location.href = "detail/"+p;
		}
	</script>
</body>
</html>