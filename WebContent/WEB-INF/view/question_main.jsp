<%@page import="UserDB.User"%>
<%@page import="ChatDB.Chat"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- 마이페이지다!! && 채팅만들었을때 -->
 <meta http-equiv="Content-type" content="text/html; charset=UTF-8">
 <meta name = "viewport" content="width=dvice-width, initial-scale=1">
  <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon">
  <link rel="icon" href="img/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">

<link rel="shortcut icon" type="image/x-icon" href="https://notion-emojis.s3-us-west-2.amazonaws.com/v0/svg-twitter/1f64b.svg">
<title>Any Questions?관리자</title>

<!-- font -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">


<!-- icon -->
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

<!-- custom css -->
<link href="css/question_main.css" rel="stylesheet">
<!-- <link href="css/nav-styles.css" rel="stylesheet"> -->

	<% 
		String userId = "Anonymous";
		String chatCode = "1111";
	
		if(session!= null && session.getAttribute("user") != null) {
			  User user = (User)(session.getAttribute("user"));
			  userId = user.getUser_id();
		}else{ //접속안했을때.... 
			String ip = (String)request.getAttribute("anonymous_name");
			userId = ip;
		}
		 chatCode = request.getParameter("chat_code");
		 System.out.println( "마이페이지에서 넘어온 chatCode(null이라면 생성하기에서 바로온거)" + chatCode);
		 
		 Chat chat = (Chat)request.getAttribute("chat");
	%>
	<script type="text/javascript">
	var lastNo = 0;

	 
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
 <!-- Createchat에서 넘어온경우 -->
 	<c:if test = "${not empty randCode}">
 		<script>
 			alert('팀원들에게 채팅코드 ${randCode}를 공유하세요!');
 		</script>
 	</c:if>
      <div class="wrap">
        <div class="sidebar">
          <div class="side front">

            <div class="overlay"></div>

            <!-- 홈으로 가기 버튼 -->
            <div class="side-header">
              <a href="/index" style="color: #fff;"><span class="material-icons">home</span></a><!-- 링크 수정 -->
            </div>
            
              <div class="side-content">
              <!-- 질문 방 이름 -->
              <h1> ${chat.chat_title}</h1> 
              <hr>
              <!-- 입장 코드 -->
              <h2>입장코드</h2>
              <h1> ${chat.chat_code}</h1>
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
        <div id="chatList" class="question-list">
        	<!-- 질문 리스트 -->
        </div>

  </main>

<script>
	function shareKakaotalk(){
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
					mobileWebUrl:"http://devkhj.ml/question_main?chat_code="+ "${chat.chat_code}",
					webUrl:"http://devkhj.ml/question_main?chat_code=" + "${chat.chat_code}"
				}
			}
			,buttons:[
				{
					title:"질문 보기"
					,link :{
						mobileWebUrl:"http://devkhj.ml/question_main?chat_code="+ "${chat.chat_code}",
						webUrl: "http://devkhj.ml:8080/question_main?chat_code=" + "${chat.chat_code}"
					}
				}
			]
		});
	}
</script>

	
<!-- js -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>	        
<script type="text/javascript">
	$(document).ready(function() {
		questionListFunction("ten");
		getInfiniteChat();
	});
</script>  
</body>
</html>