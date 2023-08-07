<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>망곰 로그인</title>
<link href="./css/login.css" rel="stylesheet">
<link href="./css/menu.css" rel="stylesheet">
<link rel="shortcut icon" href="./img/favicon.ico" type="image/x-icon">
<link rel="icon" href="./img/favicon.ico" type="image/x-icon">
<script src="https://kit.fontawesome.com/51db22a717.js"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"
	integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
	crossorigin="anonymous"></script>
<script type="text/javascript">
	let text = "<p>올바른 아이디를 입력하세요.</p>"; //전역변수 
	//호이스팅이 뭐에요? let vs var ? 

	function checkID() {
		let msg = document.getElementById("msg"); //지역변수
		//msg.innerHTML += "<p>" + document.getElementById("id").value + "아이디를 변경했습니다.</p>"
	}

/* 	function check() {
		//아이디 비밀번호 필수값 체크
		//alert("!");
		let id = document.getElementById("id");
		let pw = document.getElementById("pw");
		//alert(id.value);
		//alert(id.value.length);
		if (id.value.length <= 2) {
			alert("아이디는 2글자 이상이어야 합니다.");
			msg.innerHTML = text;
			id.focus();
			return false;
		}
		if (pw.value.length <= 2) {
			alert("비밀번호는 2글자 이상이어야 합니다.");
			pw.focus();
			return false;
		}
	} */
	//Jquery
	$(function() {
		$(".login").click(function() {

			let id = $("#id").val();
			let pw = $("#pw").val();
			if (id.length < 3) {
				alert("아이디 3자리 이상 입력하세요");
				$("#id").focus();
			} else {
				if (pw.length < 3) {
					alert("비밀번호 3자리 이상 입력하세요");
					$("#pw").focus();
				} else {
					//아이디하고 암호하고 정확하게 입력되었습니다.
					let form = $("<form></form>");
					form.attr("method", "post");
					form.attr("action", "./login");
					form.append($("<input/>", {type:"hidden", name:"id", value: id}));
					form.append($("<input/>", {type:"hidden", name:"pw", value: pw}));
					form.appendTo("body");
					form.submit();
				}
			}
		});
	});
</script>
</head>
<body>
	<%@ include file="menu.jsp"%>
	<div class="main-container">
		<div class="main-wrap">
			<header>

				<div class="logo-wrap">
					<img src="./img/ha.png">
				</div>
			</header>
			<!-- <form action="./login" method="post"></form> -->
			<section class="login-input-section-wrap">
				<div class="login-input-wrap">
					<input placeholder="아이디" type="text" name="id" id="id"
						required="required" maxlength="10" onchange="checkID()"></input>
				</div>
				<div class="login-input-wrap password-wrap">
					<input placeholder="비밀번호" type="password" name="pw" id="pw"
						required="required" maxlength="15"></input>
				</div>
				<div class="login-button-wrap">
					<button type="submit" class="login">로그인</button>
					<span id="msg"></span>
				</div>
				<div class="join">
					<div>
						<a href="/members">아이디 찾기</a> <a href="#none">비밀번호 찾기</a> <a
							href="/join">회원가입</a>
					</div>
				</div>
				<div class="login-stay-sign-in">
					<!-- <i class="far fa-check-circle"></i> <span>망곰 기억하기</span> -->
				</div>
			</section>

			<footer>

				<div class="copyright-wrap">
					<span> Copyright © Mangom Corp. All Rights Reserved. </span>
				</div>
			</footer>
		</div>
	</div>
</body>
</html>