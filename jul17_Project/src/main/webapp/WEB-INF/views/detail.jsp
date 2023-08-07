<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세페이지</title>
<link href="./css/detail.css" rel="stylesheet">
<link href="./css/menu.css" rel="stylesheet">
<link rel="shortcut icon" href="./img/favicon.ico" type="image/x-icon">
<link rel="icon" href="./img/favicon.ico" type="image/x-icon">
<script src="./js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">
	function edit() {
		if (confirm("수정하시겠습니까?")) {
			location.href = "./edit?bno=${dto.bno}";
		}
	}

	function del() {
		let chk = confirm("삭제하시겠습니까?"); //참 거짓으로 나옵니다.
		//alert(chk);
		if (chk) {
			location.href = "./delete?bno=${dto.bno}";
		}

	}
	
	//댓글 삭제 버튼 만들기 = 반드시 로그인 하고, 자신의 글인지 확인하는 검사 구문 필요.
	function cdel(cno){
		if(confirm("댓글을 삭제하시겠습니까?")){
			location.href = "./cdel?bno=${dto.bno}&cno" + cno;
		}
	}
	
	
	$(function (){
		$(".commentbox").hide();
		$(".openComment").click(function(){
			$(".commentbox").show('show');
			$(".openComment").hide();
		});
		//다른방법의 댓글삭제버튼
		//ajax 이용해서 만들기 
		$(".cdel").click(function(){
			if(confirm("댓글을 삭제하시겠습니까?")){
		    //alert("삭제합니다" + $(this).parent().siblings(".cid").text());
		    let cno = $(this).parent().siblings(".cid").text();
		    //location.href="./cdel?bno=${dto.bno }&cno="+cno;
		    let cno_comments = $(this).parents(".comment");//변수처리
		    $.ajax({
				url: "./cdelR",
				type: "post",
				data : {bno : ${dto.bno }, cno : cno},
				dataType: "json",
				success:function(data){
					//alert(data.result);
					if(data.result == 1){
						cno_comments.remove();	//변수에 담긴 html삭제
						//alert("이런");
					} else {
						alert("통신에 문제가 발생했습니다. 다시 시도해주세요.");
					}
				},
				error:function(error){
					alert("에러가 발생했습니다 " + error);
				}
		    });
			}
		});
	}); 
</script>
</head>
<body>
	<%@ include file="menu.jsp"%>
	<h1>상세페이지.</h1>
	<div class="imgDiv">
		<img class="imgGif" src="./img/co.gif">
	</div>

	<div class="detail-content">
		<div class="topbtn">
			<c:if test="${sessionScope.mid ne null && sessionScope.mid eq dto.m_id}">
				<button class="boardbtn" onclick="edit()">수정</button>&nbsp;
		        <button class="boardbtn" onclick="del()">삭제</button>&nbsp;
            </c:if>
			<a href="./board"><button class="boardbtn">글목록</button></a>
		</div>
		<div class="title-bar">
			<div>${dto.bno }</div>
			<div class="title">${dto.btitle }</div>
			<br>
		</div>
		<div class="name-bar">
			<div class="name">
				<img class="icon" src="./img/mago.gif"> ${dto.m_name } 님
			</div>
			<div class="like">
				<img class="icon" src="./img/like.png"> ${dto.blike }
			</div>
			<br>
			<div class="date">${dto.bdate }</div>
			<div class="ip">${dto.bip }</div>
		</div>
		<br>
		<div class="content">${dto.bcontent }</div>
		
		<!-- 댓글입력 -->
		<c:if test="${sessionScope.mid ne null }">
		<div class= "openComment">
		<img class="cgoimg" src="./img/gom.gif">
		<a class="cgo">댓글 달아볼까?</a>
		</div>
        <div class="commentbox">
        <div>Comment</div>
        <form action="./comment" method="post">
          <label>
        <input type="text" id="commenttextarea" name="comment" placeholder="댓글 입력해주세요.">
        <i></i>
         </label>
         <button type="submit" id="comment">댓글쓰기</button>
         <input type="hidden" name="bno" value="${dto.bno }">
        </form>
        </div>
		</c:if>
        <br><br>

        <!-- 댓글 -->
		<div>
			<c:choose>
				<c:when test="${fn:length(commentsList) gt 0 }">
					<div class="comments">
						<c:forEach items="${commentsList }" var="c">
						<div class="comment">
						  <div class="cname">${c.m_name }</div>
						  <div class="coco">
						  <div class="cid" hidden="">${c.c_no }</div>
						  <div class="cdate">${c.c_date }&nbsp;
						  <c:if test="${sessionScope.mid ne null && sessionScope.mid eq c.m_id}">
						  <button class="cbtn" onclick="cedit()">수정</button>&nbsp;
	                      <button class="cdel" onclick="cdel1(${c.c_no })">삭제</button>&nbsp;
		                  </c:if>
		                  </div>
						  </div>
						  <div class="commentBody">
						  ${c.c_comment }
						  </div>
						</div>
						</c:forEach>
					</div>
				</c:when>
				<c:otherwise>
					<h2>댓글엄성</h2>
				</c:otherwise>
			</c:choose>
		</div>
		<br><br>
	</div>
</body>
</html>