<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<nav>
	<ul>
		<li onclick="link('')">메인</li>
		<li onclick="link('board')">게시판</li>
		<li onclick="link('board2')">게시판2</li>
		<li onclick="link('mooni')">클럽</li>
		<li onclick="link('notice')">공지</li>
		<!-- <li onclick="link('sign')">회원가입</li> -->
	<c:choose>
	  <c:when test="${sessionScope.mname eq null }">
		<li class="lir" onclick="link('login')">로그인</li>
	  </c:when>
	  <c:otherwise>
		<li class="lir" onclick="link('logout')">로그아웃</li>
	  </c:otherwise>
	</c:choose>
	</ul>
</nav>

	<%-- <div class="hi_login">${sessionScope.mname }(${sessionScope.mid })님 반갑습니다.</div> --%>

<script>
function link(url){
	location.href="./"+url;
}
</script>
