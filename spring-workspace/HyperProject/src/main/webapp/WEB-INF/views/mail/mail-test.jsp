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

	<form action="mail.test" method="post">
		제목 <br> <input type="text" name="subject">
		내용 <br> <textarea name="text"></textarea>
		<br><br>
		<button>보내버렷</button>
	</form>

</body>
</html>