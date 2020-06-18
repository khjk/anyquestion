<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
 <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon">
  <link rel="icon" href="img/favicon.ico" type="image/x-icon">
	<link rel="shortcut icon" type="image/x-icon" href="https://notion-emojis.s3-us-west-2.amazonaws.com/v0/svg-twitter/1f64b.svg">
	<title>Any Questions?</title>


	  <!-- Bootstrap core CSS -->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom fonts for this template -->
  <link href="https://fonts.googleapis.com/css2?family=Roboto+Mono:wght@500&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:200,200i,300,300i,400,400i,600,600i,700,700i,900,900i" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css?family=Merriweather:300,300i,400,400i,700,700i,900,900i" rel="stylesheet">
  <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">
  
  <!-- Custom styles for this template -->
  <link href="css/coming-soon.css" rel="stylesheet">
  <!-- <link href="css/nav-styles.css" rel="stylesheet"> -->
  <link href="css/coming-soon.min.css" rel="stylesheet">

</head>

<body>

<!-- 네브 바 -->
<nav class="navbar navbar-expand-lg navbar-light fixed-top py-3" id="mainNav">
            <div class="container">
                <a class="navbar-brand js-scroll-trigger" href="/index"> </a> <!-- 링크 수정 -->
                <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                <!-- 로그인했을때 -->
                  <c:if test = "${not empty user_id}">
                    <ul class="navbar-nav ml-auto my-2 my-lg-0">
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="#">${user_id}</a></li> <!-- 링크 수정 -->
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="mypage">마이페이지</a></li> <!-- 링크 수정 -->
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="logout" onclick="return logout();">로그아웃</a></li> <!-- 링크 수정 -->
                    </ul>                  
                  </c:if>
                <!-- 로그인 안했을때 -->
                  <c:if test = "${empty user_id}">
                    <ul class="navbar-nav ml-auto my-2 my-lg-0">
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="login">로그인</a></li> <!-- 링크 수정 -->
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="signup">회원가입</a></li> <!-- 링크 수정 -->
                    </ul>
                  </c:if>  
                </div>
            </div>
</nav>

<!-- 코드입장 -->
<div class="overlay"></div>
  <img alt="" src="img/main_1920.jpg" width="1080px">

  <div class="masthead">
    <div class="masthead-bg"></div>
    <div class="container h-100">
      <div class="row h-100">
        <div class="col-12 my-auto">
          <div class="masthead-content text-white py-5 py-md-0">

            <h1 class="mb-3">Any Questions?</h1>
            <p class="mb-5" style="font-weight: 500;">입장코드를 입력해주세요</p>
            
<form action="index" method="post">
            <!-- input 수정 -->
            <div class="input-group">
              <div class="vcode" id="vcode">
                <input class="vcode-input form-control" maxlength="1" id="vcode1" name="first_code">
                <input class="vcode-input form-control" maxlength="1" name="second_code">
                <input class="vcode-input form-control" maxlength="1" name="third_code">
                <input class="vcode-input form-control" maxlength="1" name="fourth_code">
              </div> 
              <div class="vcode">
                <button class="btn btn-secondary" type="submit" formmethod="POST" value="join">join</button>
              </div>
            </div>
</form>


<!-- 코드입장결과 -->
<c:if test = "${EnterResult == 0}">
			<script>
				alert("4자리 코드를 전부 입력해주세요.");
			</script>
</c:if>
<c:if test = "${EnterResult == -1}">
			<script>
				alert("잘못된 코드번호입니다.");
			</script>
</c:if>

<!-- 방만들기 --> 
 <c:if test = "${not empty user_id}"> 
 			<p style="margin-top: 14px; margin-bottom: 14px; font-weight: 500; font-size: 15px;padding-left: 100px;">OR</p>
            <div class="input-group">
            <button class="btn btn-secondary" type="button"><a href="/createchat" style="text-decoration:none; color:#fff;">Create a new room</a></button>
              <!-- <a class="nav-link js-scroll-trigger" href="/createchat">Create a new room</a> --> <!-- 링크 수정 -->
               <!--   <button class="btn btn-secondary" type="button">Create a new room</button>-->
             </div>
  </c:if>
 
<%-- <c:if test = "${not empty nearChats}">  
<div>근처의 User가 참여하고 있는 Event입니다.</div>
	<c:forEach var ="n" items="${nearChats}">
	  <div>Event title : ${n.chat_title}</div>
	  <div>Event code: ${n.chat_code}</div>
	</c:forEach> 
</c:if> --%>
            </div>
          </div>
        </div>
      </div>
    </div>

  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Custom scripts for this template -->
  <script src="js/coming-soon.min.js"></script>
  <script src="js/entercode.js"></script>
  
		
 <!-- 

  	<div class="js-clock">
    	<h1 id="clock">00:00</h1>
    </div>
  -->


  <script type="text/javascript" src="/js/clock.js"></script>

</body>
</html>