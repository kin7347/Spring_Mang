<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>망곰 회원가입</title>

      <link href="./css/join.css" rel="stylesheet">
    <link href="./css/menu.css" rel="stylesheet">
    <link rel="shortcut icon" href="./img/favicon.ico" type="image/x-icon">
<link rel="icon" href="./img/favicon.ico" type="image/x-icon">
<script src="./js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#idCheck").click(function(){
		let id = $("#id").val();
		if(id == "" || id.length < 3){
			//alert("아이디는 5글자 이상이어야 합니다");
			$("#id").focus();
			$("#resultMSG").text("아이디는 3글자 이상이어야 합니다.");
			$("#resultMSG").css("color","red");
			$("#id").css("background-color", "white");
			$("#id").css("color", "black");
		}else{
			$.ajax({
				url : "./checkID",   //checkID?id=poseidon
				type : "post",
				data :{"id": id},		
			    dataType: "json",
				success:function(data){
					//alert(data.result);
					if(data.result == 1){
				    $("#id").css("background-color", "red");
				    $("#id").css("color", "white");
					$("#resultMSG").css("color","red");
					$("#resultMSG").text("이미 등록된 아이디입니다.");
					}else{
					$("#id").css("background-color", "green");
					$("#id").css("color", "white");
				    $("#resultMSG").css("color","green");
					$("#resultMSG").text("사용가능한 아이디입니다.");
					}
				},
				error:function(request, status, error){
				    $("#resultMSG").css("color","red");
				    $("#resultMSG").text("오류가 발생했습니다. 가입불가능");
				}
			}); //ajax 끝
		}
			return false; //멈추기
	});
});
</script>
</head>
<body>
    <%@ include file="menu.jsp"%>
    <div class="member">
        <img class="logo" src="./img/join.png" style=" width: 100px; height: 100px; margin-bottom: -20px; margin-top: 5px;">
        <form action="./join" method="post">

        <div class="field">
        <div class="field-id">
            <b>아이디</b>
        </div>
        <div class="field-chk">
        <button id="idCheck">중복검사</button>
        </div>
            <input type="text" name="id" id="id">
            <span id="resultMSG" class="chkID"></span>
        </div>
        <div class="field">
            <b>비밀번호</b>
            <input class="userpw" type="password" name="pw1">
        </div>
        <div class="field">
            <b>비밀번호 재확인</b>
            <input class="userpw-confirm" type="password" name="pw2">
        </div>
        <div class="field">
            <b>이름</b>
            <input type="text" name="name">
        </div>
        
        <div class="field">
            <b>주소</b>
            <input type="text" name="addr">
        </div>
        <div class="field">
            <b>MBTI</b>
                    <select name="mbti">
                    <option >선택하세요</option>
                    <optgroup label="너 E야?">
                    <option value="ESTJ">ESTJ</option>
                    <option value="ESTP">ESTP</option>
                    <option value="ESFJ">ESFJ</option>
                    <option value="ESFP">ESFP</option>
                    <option value="ENTJ">ENTJ</option>
                    <option value="ENTP">ENTP</option>
                    <option value="ENFJ">ENFJ</option>
                    <option value="ENFP">ENFP</option>
                    </optgroup>
                    <optgroup label="너 I야?">
                    <option value="ISTJ">ISTJ</option>
                    <option value="ISTP">ISTP</option>
                    <option value="ISFJ">ISFJ</option>
                    <option value="INTJ">INTJ</option>
                    <option value="INTP">INTP</option>
                    <option value="INFJ">INFJ</option>
                    <option value="INFP">INFP</option>
                    </optgroup>
                    </select> 
        </div>
        <div class="field birth">
            <b>생년월일</b>
            <div>
                <input type="date" name="birth">                
            </div>
        </div>
        <div class="field gender">
            <b>성별</b>
            <div>
                <label for="m"><input type="radio" name="gender" id="m" value="0">남자</label>
                <label for="f"><input type="radio" name="gender" id="f" value="1">여자</label>
            </div>
        </div>        
        <div class="field submit">
        <input type="submit" value="가입하기">
        </div>
        </form>

        <div class="member-footer">
            <div>
                <a href="#none">이용약관</a>
                <a href="#none">개인정보처리방침</a>
                <a href="#none">법적고지</a>
                <a href="#none">고객센터</a>
            </div>
            <span><a href="#none">Copyright © Mangom
						Corp. All Rights Reserved.</a></span>
        </div>
    </div>

</body>
</html>