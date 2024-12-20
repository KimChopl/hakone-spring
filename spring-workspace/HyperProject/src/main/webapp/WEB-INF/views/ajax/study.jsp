<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js" ></script>


</head>
<body>

	<h1>AJAX로 요청 보내고 응답 받기</h1>	
	<h3>1. 요청 시 값 전달. 응답결과 받기</h3>
	아이디 : <input type="text" id="userId"/> <br>
	<button onclick="requestIdCheck();">눌러보기</button>
	
	결과 : <label id="result">응답 없음</label>
	
	<script>
		function requestIdCheck(){
			const inputId = document.getElementById('userId').value;
			//console.log(inputId);
			$.ajax({
				url : 'ajax1.do', // 필수 정의 속성(매핑값)
				type : 'get', // 요청시 전달 방식
				data : {
					'userId' : inputId
				},
				success : function(e){ // 비동기 통신에 성공했을 때 수행
					console.log(e);
					document.getElementById('result').innerText = e;
				}
				
			});
			
		}
	</script>
	
	<br>
	<hr>
	<h3>2. VO 단일객체 조회해서 출력하기</h3>
	
	<div id="board-content">
		제목 ↓ <p id="title"></p>
		작성자 ↓ <p id="writer"></p>
		내용 ↓ <p id="content"></p>
		조회수 ↓ <p id="count"></p>
	</div>
	게시글번호 : <input type="text" id="boardNo">
	<button onclick="selectBoard()">조회하기</button>
	
	<script>
		function selectBoard(){
			const boardNo = document.getElementById('boardNo').value;
			
			$.ajax({
				url : 'ajax2.do',
				type : 'get',
				data : {
					no : boardNo
				},
				success : result => {
					console.log(result);
					
					document.getElementById('title').innerText = result.boardTitle;
					document.getElementById('writer').innerText = result.boardWriter;
					document.getElementById('content').innerText = result.boardContent;
					document.getElementById('count').innerText = result.count;
					
				}
			})
		}
	</script>

</body>
</html>