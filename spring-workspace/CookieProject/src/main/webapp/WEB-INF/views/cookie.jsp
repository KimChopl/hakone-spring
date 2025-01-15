<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>내가만든 쿠키 너를 위해 구웠지</h1>
	
	<%--
		EL 구문을 이용해서 쿠키접근
		${cookie.쿠키명}
	 --%>
	 <div>
	 	쿠키를 부른 가수죠 ${ cookie.cookie.value }입니다.
	 </div>
	 <div>
	 	${ empty cookie.cookie }
	 </div>
</body>
</html>