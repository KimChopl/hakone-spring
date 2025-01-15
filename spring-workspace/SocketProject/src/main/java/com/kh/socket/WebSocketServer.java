package com.kh.socket;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

/*
 *  web socket server
 *  1. 소켓핸들러 상속
 *  2. 인터페이스 구현
 */
public class WebSocketServer extends TextWebSocketHandler {
	// 소스 -> 임플리 메소드
	
	
	// 클라이언트가 웹 소켓 서버에 접속을 하면 호출되는 메소드
	@Override
	public void afterConnectionEstablished(WebSocketSession session /*이건 HttpSession과는 완전 다른 놈*/) throws Exception {
		System.out.println("이힣ㅎ힣");
		System.out.println(session); // => StandardWebSocketSession[id=5742dcc0-e272-77da-3e34-6773d6763e18, uri=ws://localhost/socket/test]
	}

	// 클라이언트로부터 메세지를 수신받을 때 호출되는 메소드
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("띠링띠링");
		System.out.println(session);
		System.out.println(message);
		
		session.sendMessage(message);
	}
	
	// 클라이언트가 웹 소켓 서버에 접속을 종료 요청을 하면 호출되는 메소드
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("히잉...");
		System.out.println(session + ", " + status); // =>  CloseStatus[code=1000, reason=null] 접속이 종료된 원인과 관련된 정보
	}

	

}
