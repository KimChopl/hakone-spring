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
	<input type="text" id="query">
	<button id="a">검색하기</button>
	<span id="result-count"></span>
	<div class="container">
		<div class="row">
			<div class="col" id="b">
				
			</div>
		</div>
	</div>
	
	<script>
		$('#a').click(function(){
			$.ajax({
				url : 'kin',
				data : {
					query : $('#query').val()
				},
				success : r => {
					console.log(r);
					$('#result-count').html(`총 <label style="color:red;">\${r.total}</label>건`);
					
					const item = r.items;
					
					const result = item.map(e =>
						`<div style="width : 300px; height : 450px;">
							<h5>\${e.title}</h5><br>
							<p>\${e.description}</p>
							<a href="\${e.link}" target="_blank">보러가기</a>
							</div>`
					).join('');
					$('#b').html(result);
					
				}
			})
		})
	</script>
</body>
</html>