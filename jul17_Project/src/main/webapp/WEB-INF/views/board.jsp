<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 입니다.</title>
<link href="./css/board.css" rel="stylesheet">
<link href="./css/menu.css" rel="stylesheet">
<link rel="shortcut icon" href="./img/favicon.ico" type="image/x-icon">
<link rel="icon" href="./img/favicon.ico" type="image/x-icon">
<script type="text/javascript">
	function linkPage(pageNo){
		location.href = "./board?pageNo="+pageNo;
	}	
</script>
</head>
<body>
<%@ include file="menu.jsp" %>
	<h1>망곰의 게시판입니다.</h1>
	<!-- 로그인 했다면 글쓰기 버튼이 보여요 -->
	로그인한 이름 : ${sessionScope.mname } / ${sessionScope.mid } 
	<c:if test="${sessionScope.mname ne null }">
	<button onclick="location.href='./write'">글쓰기</button><br><br>	
    </c:if>
	
	<br>
	<div>
	<c:forEach var="i" begin="1" end="5">
		<img src="./img/man.gif" class="mang">
	</c:forEach>
	</div>
		<%-- 길이 검사 : ${fn:length(list) } --%>
	<c:choose>
		<c:when test="${fn:length(list) gt 0 }">
	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>글쓴이</th>
				<th>날짜</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list }" var="row">
			<!-- onclick 자바스크립트 페이지 이동,URL? 파라미터 = 값 --> 
				<tr onclick="location.href='./detail?bno=${row.bno }'">
					<td class="td1">${row.bno }</td>
					<td class="title">${row.btitle } &nbsp 
					<small class = com>
					<c:if test="${row.commentcount ne 0 }">${row.commentcount}</c:if>
					</small>
					</td>
					<td class="td1">${row.m_name }</td>
					<td class="td1">${row.bdate }</td>
					<td class="td1">${row.blike }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<div class="page_wrap">
	<div class="page_nation">
	<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage"/>
	</div>
	</div>
	</c:when>
		<c:otherwise><h1>출력할 데이터가 없습니다.</h1></c:otherwise>
	</c:choose>

			<footer>
				<div class="copyright-wrap">
					<span> Copyright © Mangom
						Corp. All Rights Reserved.
					</span>
				</div>
			</footer>
</body>
</html>