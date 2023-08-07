<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문희사항</title>
<link href="./css/board.css" rel="stylesheet">
<link href="./css/menu.css" rel="stylesheet">
<link rel="shortcut icon" href="./img/favicon.ico" type="image/x-icon">
<link rel="icon" href="./img/favicon.ico" type="image/x-icon">
</head>
<body>
<%@ include file="menu.jsp" %>
<h1>클럽개장!</h1>
	<c:forEach var="i" begin="1" end="20">
		<img src="./img/go1.gif" class="mang">
		<img src="./img/go2.gif" class="mang">
		<img src="./img/go3.gif" class="mang">
		<img src="./img/go4.gif" class="mang">
		<img src="./img/go5.gif" class="mang">
	</c:forEach>
</body>
</html>