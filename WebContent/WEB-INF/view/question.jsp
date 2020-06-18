<%@page import="UserDB.User"%>
<%@page import="ChatDB.Chat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<!DOCTYPE html>
<html>
<head>
  <!-- 메인에서가는거다 -->
   <meta http-equiv="Content-type" content="text/html; charset=UTF-8">
   <meta name = "viewport" content="width=dvice-width, initial-scale=1">
 	 <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon">
  <link rel="icon" href="img/favicon.ico" type="image/x-icon">
   <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">

	<link rel="shortcut icon" type="image/x-icon" href="https://notion-emojis.s3-us-west-2.amazonaws.com/v0/svg-twitter/1f64b.svg">
	<title>Any Questions?유저</title>

	<!-- font -->
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
	
	<!-- icon -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	
	<!-- custom css -->
   <link href="css/question.css" rel="stylesheet">
   <link rel="stylesheet" media="screen and (max-width: 768px)" href="css/question_mobile.css" />


	
   <% 
      String userId = "anonymous";
      String chatCode = "1111";
      if(session!= null && session.getAttribute("user") != null) {
           User user = (User)(session.getAttribute("user"));
           userId = user.getUser_id();
      }else{ //접속안했을때.... 
         String ip = (String)request.getAttribute("anonymous_name");
         userId = ip;
      }
      Chat chat = new Chat();
      chat = (Chat)(request.getAttribute("chat"));
      if(chat != null){
         chatCode = Integer.toString(chat.getChat_code());
      }
   %>

   <script type="text/javascript">
   /* 마지막 qNo */
   var lastNo = 0;
   
   /* submit */
   function submitFunction() {
      var userId = '<%= userId %>';
      var chatCode = '<%= chatCode %>';
      var questionContent = $('#questionContent').val();
      $.ajax({
         type: "POST",
         url: "./questionSubmit",
         data: {
            userId: encodeURIComponent(userId),
            chatCode: encodeURIComponent(chatCode),
            questionContent: encodeURIComponent(questionContent)
         },
      success: function(result){
         if(result == 1) {
            alert("질문이 성공적으로 등록 되었습니다!");
         } else if(result == 0){
            alert("입력값을 다시 확인해주세요");
         } else {
            alert("데이터베이스error");
         }
      }
      });
      
      // 값 비우기 
      $('#questionContent').val('');
   }

   function likeFunction(qNo) {
		var userId = '<%= userId %>';
		
		$.ajax({
			type: "post",
			url: "./likeAction",
			async:false,
			data: {
				userId: encodeURIComponent(userId),
				questionNo: qNo
			},
			success: function(result){
				if(result == 11) {
					alert("좋아요!");
					likeCountUpdateFunction(qNo);
				} else if(result < 0) {
					alert("데이터베이error"); 
				} else {
					alert("좋아요취소!");
					likeCountUpdateFunction(qNo);
				}
			}
		});
	} 
	
	/* 좋아요count update */
	function likeCountUpdateFunction(qNo) {
		var userId = '<%= userId %>';
		 var questionNo = qNo;
		$.ajax({
			type: "post",
			url: "./likeUpdateServlet",
			async:false,
			data: {
				userId: encodeURIComponent(userId),
				questionNo: qNo
			},
			success: function(data){
				if(data == "") return;
				var parsed = JSON.parse(data);
				var result = parsed.result;
				$("#like_count"+questionNo).html(result[0][0].value);
				}
			});
		}

   /* 질문 불러오기 */
      function questionListFunction(type) {
       var chatCode = '<%= chatCode %>';
       
      $.ajax({
         type: "POST",
         url: "./questions",
         data: {
            listType: type,
            chatCode: encodeURIComponent(chatCode)
         },
      success: function(data){
         if(data == "") return;
         var parsed = JSON.parse(data);
         var result = parsed.result;
         for(var i = 0; i < result.length; i++) {
            addChat(result[i][0].value, result[i][1].value, result[i][2].value);
         }
         lastNo = Number(parsed.last);
      }
      });
   }
      
      /* content만 출력
      ++ 좋아요 갯수 추가 해야함 */
      function addChat(chatContent,likeCount,qNo) {
          $('#chatList').append(
                  '<div id="chat_div'+ qNo +'" class="card card-block">' +
                  '<div class="row">' +
                  '<div class="col-md-11">' +
                  '<p class="card-text">' + chatContent + '</p>' +
                  '</div>' +
                  '<div class="col-md-1">' +
                  '<div class="card-body">'+
                  /*'<form>' +
                  '<input type="hidden" value="'+ qNo + '">'+ */
                  '<button id = "like_btn" class="btn active-like" style="padding: 0;" onclick="likeFunction('+ qNo +');">' +
                  '<i class="material-icons">thumb_up</i>' +
                  '</button>' +
                  '<p id="like_count'+ qNo +'" class="card-text" style="color: #6b6b6b">' +likeCount +'</p>'+
                  /*'</form>' +*/
                  '</div>' +
                  '</div>' +
                  '</div>' +
                  '</div>');
          
          /* 자동 스코롤  */
          $('#chatList').scrollTop($('#chatList')[0].scrollHeight);
       }
         
      
      /* 1초에 한번씩 정보불러오기  */
      function getInfiniteChat() {
         setInterval(function() {
            questionListFunction(lastNo);
         }, 1000);
      }
   </script>
   
   
</head>

<body>

<!-- <div class = container> -->
      <div class="wrap">
        <div class="sidebar">
          <div class="side front">

            <div class="overlay"></div>

            <!-- 홈으로 가기 버튼 -->
            <div class="side-header">
              <a href="/index" style="color: #fff;"><span class="material-icons">home</span></a><!-- 링크 수정 -->
            </div>

              <div class="side-content">
              
              <!-- =========질문 방 이름 받아주세요!!! ===========-->
              
              <!-- 질문 방 이름 -->
              <h1>${chat.chat_title}</h1> 
              <hr>
              <!-- 입장 코드 -->
              <h2>입장코드</h2>
              <h1>#${chat.chat_code}</h1>
              <hr>
              
              <!-- 수업자료 다운로드 -->
              <h5>수업 자료 다운로드</h5>
              <span class="material-icons" >save_alt</span>
              <!-- 파일 명 -->
              <c:forTokens var="fileName" items="${chat.files}" delims="," varStatus="st">
					<a download href = "/upload/${fileName}" style="${style}">${fn:toUpperCase(fileName)}</a> 
					<c:if test="${!st.last}">
					/
					</c:if>
			  </c:forTokens> 
			  <hr>
                            
              <!-- 카카오톡 공유 -->
              <h5>공유하기</h5>
              <button type = "button" class="btn" onClick="shareKakaotalk();" style="padding: 0;">
                <img onclick="shareKakaotalk();" src="./img/kakaolink_btn_small.png" class="pointer"/>
             </button>
               
              
            </div>
          </div>
        </div>
      </div>   

      <main>
         <!-- 모바일 화면 헤더 -->
        <div id="mobile-header">
         <div class="header-overlay"></div>
         <div class="mobile-header-content">

          
          <!-- 질문 방 이름 -->
          <h3>${chat.chat_title}</h3> 
          <!-- 입장 코드 -->
          <span id="enter-code">입장코드</span>
          <span>#${chat.chat_code}</span>
         </div>
       </div>

        <div id="chatList" class="question-list">
        	<!-- 질문 리스트 -->
        </div>
        
        <div class="message_write">
           <textarea id="questionContent" class="form-control" placeholder="질문을 입력해주세요."></textarea>
            <div class="clearfix"></div>
            <button class="btn float-right" onclick="submitFunction();">Send</button>
            <div class="clearfix"></div>
        </div>
      </main>
      

   <!--  <div class="head"> -->
    
<script>
function shareKakaotalk(){
    var _title = "${chat.chat_title}"
    
    try{
       if(Kakao){
          Kakao.init("277d63deb226b1150f3a2ac34847f80f");
       };
    }catch(e){};
    
    Kakao.Link.sendDefault({
       objectType:"feed",
       content:{
          title:"${chat.chat_title}" + "질문방입니다.",
          description:"채팅번호" + "${chat.chat_code}",
          imageUrl:"/image/card_image.png",
          link:{
//             mobileWebUrl:"http://localhost:8080/question?chat_code="+ "${chat.chat_code}",
//              webUrl:"http://localhost:8080/question?chat_code="+ "${chat.chat_code}"
             mobileWebUrl:"http://devkhj.ml/question?chat_code="+ "${chat.chat_code}",
             webUrl:"http://devkhj.ml/question?chat_code="+ "${chat.chat_code}"
          }
       }
       ,buttons:[
          {
             title:"질문 보기"
             ,link :{
                mobileWebUrl:"http://devkhj.ml/question?chat_code="+ "${chat.chat_code}",
                webUrl:"http://devkhj.ml/question?chat_code="+ "${chat.chat_code}"
             }
          }
       ]
    });
 }
</script>

<%--     <h1 class="head_item"><a href="/index"><span>Do you Have Any Question?</span></a></h1>
      <!-- 로그인했을때 -->
      <c:if test = "${not empty user_name}">
      <div class="head_item" style="float:right;">
         <ul class = "js-login" style="float:right;">
             <li>${user_name}님 로그인 중입니다.</li>
             <li><a href="mypage">마이페이지</a></li>
             <li><a href="logout">로그아웃</a></li>
         </ul>
       </div>
      </c:if>
      <!-- 로그인안했을때 -->
      <c:if test = "${empty user_name}">
         <div class="head_item" style="float:right;">
             <ul>
                <li>IP주소 :${anonymous_name}</li>
                <li><a href="login">로그인</a></li>
                <li><a href="signup">회원가입</a></li>
             </ul>
          </div>
         </c:if> --%>
      
   
   <!-- js -->
   <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
   <script src="js/question.js"></script>
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
   <script type="text/javascript">
   $(document).ready(function() {
      questionListFunction('ten');
      getInfiniteChat();
   });
   </script>
   
   <script src="//ajax.googleapis.com/ajax/libs/webfont/1.4.7/webfont.js"></script>
<script>
  WebFont.load({
    google: {
      families: ['Noto Sans KR', 'Roboto Mono']
    }
  });
</script>          
</body>
</html>