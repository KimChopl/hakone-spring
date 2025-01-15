<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<script>
		const arr =['하니', '뉴진스', '준비 갈 완료']
		
		localStorage.setItem('arr', JSON.stringify(arr)) // 로컬 스토리지에 값을 넣을 때는 JSON형태로 넣어주기
		
		const localArr = JSON.parse(localStorage.getItem('arr')) // JSON형태를 다시 js 형태로 변환
		console.log(localArr)
		
		localArr.push('귀여움')
		
		localStorage.setItem('arr1', JSON.stringify(localArr))
		
		// 삭제 : remoceItem(키값)
		localStorage.removeItem('arr')		
	</script>
	
</body>
</html>