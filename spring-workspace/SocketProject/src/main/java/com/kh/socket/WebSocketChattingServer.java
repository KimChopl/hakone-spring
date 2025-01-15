package com.kh.socket;

import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class WebSocketChattingServer extends TextWebSocketHandler {

	/*
	 *  사용자 저장소
	 *   - 중복불가
	 *   - 동기화 지원(나간 사람한테 메세지 안보내기)
	 */
	private Set<WebSocketSession> users = new CopyOnWriteArraySet<WebSocketSession>();
	
	// 핸드쉐이커어쩌구 쓰면 HttpSession의 값을 뽑을 수 있음
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		users.add(session);
		System.out.println("ㅎㅇ" + users.size() + "명 접속 중");
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		TextMessage newMessage = new TextMessage((CharSequence)message.getPayload());
		
		for(WebSocketSession ws : users) {
			ws.sendMessage(newMessage);
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		users.remove(session);
		System.out.println("ㅂㅇ" + users.size() + "명 접속 중");
	}

	
}
