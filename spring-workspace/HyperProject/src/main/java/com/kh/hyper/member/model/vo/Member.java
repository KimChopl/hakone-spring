package com.kh.hyper.member.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/*
 * Lombok
 * 
 * 자동 코드 생성 라이브러리
 * 
 * 설치 방법 귀찮음
 * 1. 라이브러리 다운
 * 2. .jar 실행, 작업할 IDE 체크
 * 3. 재실행
 * 
 * 
 * 주의 사항
 * 
 */
/*
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
*/
@Data // 싹 다 만듬 -> 필요없는거 못 뺌 -> 유연성 떨어짐
public class Member {
	private String userId;
	private String userPwd;
	private String userName;
	private String email;
	private String gender;
	private String age;
	private String phone;
	private String address;
	private Date enrollDate;
	private Date modifyDate;
	private String status;
	
}
