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
	<h1>아 내 도파민</h1>
	<button id="requestBtn" class="btn btn-lg btn-danger">도파민을 끊어 냅시다</button>
	<table class="table table-hover">
		<thead>
			<tr>
				<th>상담 일정 시작일</th>
				<th>상담 일정 종료일</th>
				<th>유캔센터명</th>
				<th>유캔센터 주소</th>
				<th>
			</tr>
		</thead>
		<tbody id="resultBody">
			
		</tbody>
	</table>
	<script>
		$(function(){
			let page = 1;
			$('#requestBtn').click(function(){
				$.ajax({
					url : 'horse',
					type : 'get',
					data : {
						pageNo : page
					},
					success : r => {
						console.log(r)
						const item = r.response.body.items.item
						
						const result = item.map(e =>
							`<tr>
								<td>\${e.stDate}</td>
								<td>\${e.edDate}</td>
								<td>\${e.fltTitle}</td>
								<td>\${e.fltPositionAdd}</td>
							<tr>`
						
						).join('');
						const tableBody = document.getElementById('resultBody')
						tableBody.innerHTML += result;
						page += 1;
						
					}
				})				
			})			
		})
	</script>
</body>
</html>