package chatController;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import ChatDB.Chat;
import ChatDB.ChatDAO;
import UserDB.User;
//50M 파일하나의 최대크기, 여러개 파일첨부시 총 5개
@MultipartConfig(
	fileSizeThreshold=1024*1024 ,
	maxFileSize = 1024 * 1024 * 50 ,
	maxRequestSize = 1024 * 1024 * 50 * 5
)
@WebServlet("/createchat")
public class CreateChat extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		System.out.println("createchat의 get메소드호출");
		HttpSession session = request.getSession(true);
		
		if(session!= null && session.getAttribute("user") != null) {
			  User user = (User)(session.getAttribute("user"));
			  String user_name = user.getUser_name();
			  request.setAttribute("user_name", user_name);
		}
		
		request
		.getRequestDispatcher("/WEB-INF/view/createchat.jsp")
		.forward(request, response);
	}//doGet

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String event_name = request.getParameter("eventname");
		/*파일 업로드*/
		
		Collection<Part> parts = request.getParts();
		StringBuilder builder = new StringBuilder();
		String fileName = null;
		if(parts!=null ) {
			for(Part p : parts) {
				if(!p.getName().equals("file")) continue;
				Part filePart = p;
				fileName = filePart.getSubmittedFileName();
				InputStream fis = filePart.getInputStream();
				
				String realPath = request.getServletContext().getRealPath("/upload");
				System.out.println("파일업로드 물리경로: " + realPath);
				System.out.println("fileName은 뭐냐" + fileName);
				if(fileName != null && fileName != "") {
					String filePath = realPath + File.separator + fileName;
					builder.append(fileName);
					builder.append(",");
		            FileOutputStream fos = new FileOutputStream(filePath);
				    byte[] buf = new byte[1024];
					int size = 0;
					while((size=fis.read(buf)) != -1) {
						fos.write(buf,0,size);
					}
					fos.close();
					fis.close();	
				}
				}//for
		}
		if(fileName != null && fileName != "") {
			builder.delete(builder.length()-1, builder.length()); //이상미만
		}
		HttpSession session = request.getSession(true); //있으면 반환 없으면 null
		int sessionUserNum = 0;
		int randCode = 1000;
		if(session!= null && session.getAttribute("user") != null) {
			  User user = (User)(session.getAttribute("user"));
			  sessionUserNum = user.getUser_no();
			  System.out.println("CreateChat Post메소드 - 현재 세션 : "+ session.getAttribute("user") + "의 새로운 채팅 생성중");
			  try {
				  	Chat chat = new Chat();
				  	chat.setChat_title(event_name);
				  	chat.setUser_no(sessionUserNum); //현재세션의 유저넘버 저장
				  	chat.setFiles(builder.toString()); //파일명등록
				  	//채팅번호는 자동생성
					ChatDAO chatDao = ChatDAO.getInstance(); 
					randCode = chatDao.insertChat(chat); //DB삽입성공하면 만든 randCode반환
					request.setAttribute("chat_code", randCode);
					request.setAttribute("user_id", user.getUser_id());
					chat.setChat_code(randCode); 
					Chat temp = chatDao.getChat(Integer.toString(randCode));
					chat.setChat_date(temp.getChat_date());
					request.setAttribute("randCode",randCode);
					request.setAttribute("user_name", user.getUser_name());
					request.setAttribute("chat",chat);
			  } catch (Exception e) {
					e.printStackTrace();
			  }
		}//if 세션존재
		
		request.getRequestDispatcher("/WEB-INF/view/question_main.jsp") 
	  	   .forward(request, response);
	}//doPost
}
