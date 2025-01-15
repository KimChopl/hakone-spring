<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>이히ㅣ히히ㅣㅎㅎ</h1>
	
	<button onclick="connect()">히힣접속</button>
	<button onclick="disConnect()">잘자 안녕</button>
	
	<hr>
	<input type="text" id="client-message">
	<button onclick="send()">저언소옹</button>
	
	<script>
		var socket;
		
		function connect(){
			const uri ='ws://localhost/socket/test'
			socket = new WebSocket(uri) // 톰켓에 연결해주기
			
			socket.onopen = () => { // 서버와 연결에 성공했을 때 호출되는 핸들러
				alert('안녕!');
			}
			socket.onclose = () => { // 서버와 연결을 종료할 때 호출되는 핸들러
				alert('안녕...')
			}
			socket.onerror = e => {
				alert(`에러코드 : \${e} <br> 다시 시도하셈`)
			}
			socket.onmessage = e => {
				console.log(e);
			}
			
		}
		
		function disConnect(){
			socket.close()
			
		}
		
		function send(){
			const msg = document.getElementById('client-message')
			const message = msg.value
			socket.send(message);
			msg.value = '';
		}
	</script>
	
</body>
</html>