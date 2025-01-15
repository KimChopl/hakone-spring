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
	<input type="text" id="search">
	<button id="btn" class="btn btn-sm btn-outline-info">검색</button>
	
	<script>
		const btn = document.getElementById('btn');
		btn.addEventListener('click', function(){
			const key = document.getElementById('search');
			$.ajax({
				url : 'dictionary',
				type : 'post',
				data : {
					search : key.value
				},
				success : r => {
					console.log(r)
				}
			})
		})
	</script>
</body>
</html>