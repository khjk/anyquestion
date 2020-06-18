<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon">
  <link rel="icon" href="img/favicon.ico" type="image/x-icon">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<!-- font -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">

<!-- icon -->
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

<!-- custom css -->
<link href="css/create-chat.css" rel="stylesheet">
<link href="css/nav-styles.css" rel="stylesheet">

<link rel="shortcut icon" type="image/x-icon" href="https://notion-emojis.s3-us-west-2.amazonaws.com/v0/svg-twitter/1f64b.svg">
<title>Any Questions?</title>
</head>
<body>

<!-- page-header -->
<div class="page-header" style="margin-top: 0px;">
    <div class="container">
        <div class="row">

            <div class="overlay"></div>

             <!-- 네브 바 -->
            <nav class="navbar navbar-expand-lg navbar-light fixed-top py-3" id="mainNav">
                <div class="container">
                    <a class="navbar-brand js-scroll-trigger" href="/index" style="font-size: 18px;">Any Questions?</a>  <!-- 링크 수정 -->
                        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                    <div class="collapse navbar-collapse" id="navbarResponsive">
                        <ul class="navbar-nav ml-auto my-2 my-lg-0">
                            <li class="nav-item"><a class="nav-link js-scroll-trigger" href="logout" onclick="return logout();" style="font-size: 15px;">로그아웃</a></li> <!-- 링크 수정 -->
                        </ul>
                    </div>
                </div>
            </nav>
	
 <c:if test = "${logout eq 'success'}">
		<script> alert ('로그아웃되었습니다.')</script>
 </c:if>
            <!-- 헤더 이미지& 텍스트 -->
            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                <div class="page-caption">
                    <h1 class="page-title">Create new Room</h1>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <div class="card-section">
        <div class="table-wrapper card-block col-sm-12">
            <form class="create-form" action="createchat" method="post" enctype="multipart/form-data">
                <!-- 채팅방 이름 -->
                <div class="form-group row">
                    <label for="chat-name" class="col-sm-3 col-form-label col-form-label-lg" >질문 채팅 방 이름</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control form-control-lg" name="eventname" id="chat-name">
                    </div>
                </div>

                <!-- 채팅코드 -->
                <div class="form-group row">
                    <label for="chatCode" class="col-sm-3 col-form-label col-form-label-lg">입장코드</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control form-control-lg" id="chatCode" placeholder="#????" readonly>
                        <small id="chatCode" class="form-text text-muted">
                            입장 코드는 랜덤으로 자동 생성됩니다.
                        </small>
                    </div>
                </div>

                <!-- 파일 업로드 -->
                <div class="form-group row">
                    <label for="fileUpload" class="col-sm-3 col-form-label col-form-label-lg">수업자료</label>
                    <div class="col-sm-9">
                        <input type="file" name = "file" class="form-control-file " id="fileUpload" placeholder="...." >
                        <small id="fileUpload" class="form-text text-muted">
                            수업자료를 업로드 할 수 있습니다.
                        </small>
                    </div>
                </div>
			  <script>
	          function makeChat(){
	        	  alert("채팅방이 생성되었습니다.");
	          }
	          </script>
                <!-- 버튼 -->
                <div class="form-group row">
                	<div class="clearfix"></div>
                    <div class="col-sm-12">
                    <button type="submit" onClick = "makeChat();" formmethod="POST" class="btn btn-lg pull-right">Submit</button>    
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>



<!-- js -->
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>