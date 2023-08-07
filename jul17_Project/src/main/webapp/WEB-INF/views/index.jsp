<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로비</title>
<link href="./css/board.css" rel="stylesheet">
<link href="./css/menu.css" rel="stylesheet">
<link rel="shortcut icon" href="./img/favicon.ico" type="image/x-icon">
<link rel="icon" href="./img/favicon.ico" type="image/x-icon">
</head>
<body>
<%@ include file="menu.jsp" %>
	<h1>망곰의 로비입니다.</h1>
	<img src="./img/gom.gif"><br><br>
	<a href="./board"><button>게시판으로 가보쟝</button></a>
	<br>
	<%=request.getHeader("User-Agent") %>

</body>
</html>

