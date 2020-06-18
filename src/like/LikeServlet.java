package like;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import questions.QuestionDAO;

@WebServlet("/likeAction")
public class LikeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String userId = URLDecoder.decode(request.getParameter("userId"), "UTF-8");
		String questionNo = request.getParameter("questionNo");
		
		System.out.println("======like servelt=======");
		System.out.println(userId);
		System.out.println(questionNo);

		if(userId == null || userId.equals("") || questionNo == null || questionNo.equals("")) {
			System.out.println("========if문 실행=========");
			response.getWriter().write("0");
			
		} else if(new LikeDAO().getQuestion(userId, questionNo) > 0){
			// 값이 있으면 삭제
			
			response.getWriter().write(new LikeDAO().likeDelete(userId, questionNo)+"");
			response.getWriter().write(new QuestionDAO().likeUpdateDelete(questionNo)+"1");
			
			System.out.println("=======else if문/// 실행: 좋아 삭제=========");
			
			//return 111
			
		} else {
			// 값이 없으면 insert
			
			response.getWriter().write(new LikeDAO().likeInsert(userId, questionNo)+"");
			response.getWriter().write(new QuestionDAO().likeUpdate(questionNo)+"");

			System.out.println("=======else문/// 실행 : 좋아 삽입=========");
			// return 11
		}
	}
	
}
