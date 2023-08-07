<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <link href="./css/sign.css" rel="stylesheet">
    <link href="./css/menu.css" rel="stylesheet">
    
</head>

<body>
	<%@ include file="menu.jsp"%>
    <div>
        <div class="container">
            <h2>회원가입을 위해<br>정보를 입력해주세요.</h2>

            <!-- input도 inline요소중에 하나다. -->
            <!-- inline이란 하나의 태그가 레코드(가로)방향을 모두 차지하는게 아니라, 자신이 속한 영역만 가지게 되는 것이다. -->
            <label for="email">* 이메일<br>
                <input type="text" id="email"><br><br>
            </label>
            <label for="name">* 이름<br>
                <input type="text" id="name"><br><br>
            </label>
            <label for="password1">* 비밀번호<br>
                <input class="pw" id="password1" type="password"><br><br>
            </label>
            <label for="password2">* 비밀번호 확인<br>
                <input class="pw" id="password2" type="password"><br><br> </label>

            <!-- 선택 영역 두번째 -->
            <!-- name을 부여함으로 인하여 radio의 선택 가능한 것들을 하나의 그룹으로 묶어준다. -->
            <form>
                <input type="radio" class="radio" name="gender">&nbsp 여성
                <input type="radio" class="radio" name="gender">&nbsp 남성
            </form>
            <br><br>
            <form>
                <input type="checkbox" class="agree">&nbsp 이용약관 개인정보 수집 및 정보이용에 동의합니다.
            </form>
            <hr>
            <hr>
            <button>가입하기</button>
            <!-- 기능자체는 input의 타입을 button으로 하면 사용은 가능하지만, 굳이 button 태그를 사용하는 이유는 -->
            <!-- 커스터마이징이 button 태그가 더 용이하기 때문이다. -->
            <!-- <input type="button" value="가입하기"> -->
        </div>
    </div>
</body>
</html>