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
	
	<c:if test="${ empty cookie.cookie }">
	<script>
		open('http://www.google.com', '광고지롱', 'width=400, height=600')
	</script>
	</c:if>

</body>
</html>