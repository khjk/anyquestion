<%@page import="ChatDB.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>
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

<link rel="shortcut icon" type="image/x-icon" href="https://notion-emojis.s3-us-west-2.amazonaws.com/v0/svg-twitter/1f64b.svg">
<title>Any Questions?</title>

<!-- font -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">

<!-- icon -->
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

<!-- custom css -->
<link href="css/mypage1.css" rel="stylesheet">
<link href="css/nav-styles.css" rel="stylesheet">

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
		      <a class="navbar-brand js-scroll-trigger" href="/index" style="font-size: 18px;" >Any Questions?</a>
		         <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
		      <div class="collapse navbar-collapse" id="navbarResponsive">
		          <ul class="navbar-nav ml-auto my-2 my-lg-0">
		             <li class="nav-item"><a class="nav-link js-scroll-trigger" style="font-size: 15px;" href="#" >${user_name}의 마이페이지</a></li> <!-- 링크 수정 -->
		             <li class="nav-item"><a class="nav-link js-scroll-trigger" style="font-size: 15px;" href="logout" onclick="return logout();">로그아웃</a></li> <!-- 링크 수정 -->
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
                    <h1 class="page-title">My page</h1>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <div class="card-section">
        <div class="table-wrapper card-block">
            <div class="table-title">
                <div class="row">
                    <!-- 리스트 상단 -->
                    <div class="col-sm-8"><h2><b>List</b></h2></div>
                    <div class="col-sm-4">
                    <button class="btn add-new" type="button"><a href="/createchat" style="text-decoration:none; color:#fff;">Create a new room</a></button>
                     <!-- <a class="nav-link js-scroll-trigger" href="/createchat">Create a new room</a> --> <!-- 링크 수정 -->
                    <!-- <button type="button" class="btn add-new"><i class="fa fa-plus"></i> Add New</button>  -->  
                    </div>
                </div>
            </div>
            <!-- 테이블 -->
            <table class="table .table-borderless" style="margin-top: 20px;">
                <thead>
                    <tr style="font-size: 15px;">
                        <th class="text-center">질문채팅방</th>
                        <th class="text-center">입장코드</th>
                        <th class="text-center">생성날짜</th>
                        <th class="text-center">입장</th>
                        <th class="text-center">삭제</th>
                    </tr>
                </thead>
                
                <tbody>
                <c:forEach var ="n" items="${chats}">
                    <tr>
                        <td class="text-center">${n.chat_title}</td>
                        <td class="text-center"><a href="question_main?chat_code=${n.chat_code}">${n.chat_code}</a></td>
                        <td class="text-center">${n.chat_date}</td>
                        <td class="text-center">
                            <!-- 입장 아이콘 버튼 -->
                            <a class="edit" title="Enter" data-toggle="tooltip" href="question_main?chat_code=${n.chat_code}"><i class="material-icons">forward</i></a>
                        </td>
                        <td class="text-center">
                            <!-- 삭제 아이콘 버튼 -->
                            <a class="delete" title="Delete" data-toggle="tooltip" href="deletechat?chat_code=${n.chat_code}"><i class="material-icons">delete</i></a> 
                        </td>
                    </tr>
                </c:forEach>   
                </tbody>
            </table>
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