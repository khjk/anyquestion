<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="shortcut icon" type="image/x-icon" href="https://notion-emojis.s3-us-west-2.amazonaws.com/v0/svg-twitter/1f64b.svg">
<title>Any Questions?</title>

<!-- font -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
 <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon">
  <link rel="icon" href="img/favicon.ico" type="image/x-icon">
<!-- css -->
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link href="css/login1.css" rel="stylesheet">
<link href="css/nav-styles.css" rel="stylesheet">

<!-- <link href="css/coming-soon.css" rel="stylesheet">
<link href="css/coming-soon.min.css" rel="stylesheet"> -->

</head>
<body>

<div class="vid-container"> 

  <!-- 네브 바 -->
<nav class="navbar navbar-expand-lg navbar-light fixed-top py-3" id="mainNav">
  <div class="container">
      <a class="navbar-brand js-scroll-trigger" href="index">Any Questions?</a>  <!-- 링크 수정 -->
      <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
          <ul class="navbar-nav ml-auto my-2 my-lg-0">
              <li class="nav-item"><a class="nav-link js-scroll-trigger" href="login">로그인</a></li> <!-- 링크 수정 -->
              <li class="nav-item"><a class="nav-link js-scroll-trigger" href="signup">회원가입</a></li> <!-- 링크 수정 -->
          </ul>
      </div>
  </div>
</nav>

  <div class="overlay"></div>

  <img class="bgvid" alt="" src="img/main_1920.jpg">

  <div class="inner-container">
  <form action="login" method="post">
    <div class="box">
      <h1>Login</h1>
      <input type="email" name = "userid" placeholder="E-mail"/>
      <input type="password" name="password" placeholder="Password"/>
      <button type="submit" formmethod="POST">Login</button>
   </div>
  </form>   
  <a href="signup"><p><span>Sign Up</span></p></a> <!-- 링크 수정 -->

<c:if test = "${loginResult !=1 }">
			<script>
				alert("다시 로그인하세요.");
			</script>
</c:if>
  </div>
</div>
	
<!-- js -->
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>	
</body>
</html>