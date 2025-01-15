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
    <style>
    	body{
    		background-color : rgb(235, 235, 235);
    	}
    	
    	.my-msg{
    		min-width : 200px;
    		min-height : 40px;
    		height : auto;
    		width : 300px;
    		margin-left : auto;
    		background-color : lightyellow;
    	}
    	
    	.msg{
    		min-width : 200px;
    		min-height : 40px;
    		height : auto;
    		width : 300px;
    		margin-right : auto;
    		background-color : lightpink;
    	}
    </style>
</head>
<body>

	<h1>이히ㅣ히히ㅣㅎㅎ</h1>
	
	<button onclick="connect()" class="btn btn-outline-primary">히힣접속</button>
	<button onclick="disConnect()" class="btn btn-outline-danger">잘자 안녕</button>
	
	<hr>
	<div class="form-group" style="width : 95%; height : 200px;">
	<input type="text" id="client-message" class="form-control">
	<button onclick="send()" class="btn btn-outline-success">저언소옹</button>
	</div>
	
	<div style="border : 1px solid rgba(0, 0, 0, 0.1); width : 80%; height : 600px; margin : auto; background-color : rgb(250, 250, 250); padding : 35px;" id="wrap">
	
	</div>
	
	<script>
		var socket;
		var nickName
		
		function connect(){
			nickName = prompt('닉네임 입력');
			const uri ='ws://localhost/socket/groups'
			socket = new WebSocket(uri) // 톰켓에 연결해주기
			
			socket.onopen = () => { // 서버와 연결에 성공했을 때 호출되는 핸들러
				alert('안녕!');
			}
			socket.onclose = () => { // 서버와 연결을 종료할 때 호출되는 핸들러
				alert('안녕...')
			}
			socket.onerror = e => {
				alert(`에러코드 ${e} 다시 시도하셈`)
			}
			socket.onmessage = e => {
				console.log(e);
				const $div = $('<div></div>');
				$div.text(e.data);
				const nick = nickName.split(':')[0]
				if(nick === nickName){
					
				} else{
					
				}
				$('#wrap').append($div)
			}
			
		}
		
		function disConnect(){
			socket.close()
			
		}
		
		function send(){
			const msg = document.getElementById('client-message')
			const message = msg.value
			socket.send(nickName +':' + message);
			msg.value = '';
		}
	</script>
	
</body>
</html>