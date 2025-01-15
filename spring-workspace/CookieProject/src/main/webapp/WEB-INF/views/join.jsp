<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
	<c:choose>
		<c:when test="${ not empty cookie.saveId }">
			<input type="text" value="${ cookie.saveId.value }">
			<input type="checkbox" name="saveId" id="id" checked>
		</c:when>
		<c:otherwise>
			<input trpe="text">
			<input type="checkbox">
		</c:otherwise>
	</c:choose>
</body>
</html>