package questions;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class QuestionDAO {
	
	private Connection conn;
	
	public QuestionDAO() {
		try {
			String URL = "jdbc:oracle:thin:@192.168.0.21:1521:xe";
			String ID = "c##ora_user";
			String PW = "12345";
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(URL, ID, PW);
		} catch (Exception e ) {
			//e.printStackTrace();
		}
	}
	
	//question content 遺덈윭�삤湲� (�떆媛� �닚�쑝濡�)
			ArrayList<Question> getQuestionListByRecent(String qNo, String cCode) {
				ArrayList<Question> questionList = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;		
				
				String sql = "SELECT * FROM QUESTIONS WHERE CHAT_CODE = ? AND QUESTION_NO > ? ORDER BY Q_CREATE_TIME";
				if(qNo!=null && cCode !=null && cCode !="" && qNo !="") {
				try {
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, Integer.parseInt(cCode));
					pstmt.setInt(2, Integer.parseInt(qNo));
					rs = pstmt.executeQuery();
					
					questionList = new ArrayList<Question>();
					while(rs.next()) {
						int questionNo = rs.getInt("QUESTION_NO");
						int chatCode = rs.getInt("CHAT_CODE");
						String userId = rs.getString("USER_ID");
						// �듅�닔 湲고샇 泥섎━
						String questionContent = rs.getString("QUESTION_CONTENT").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>");
						String qCreateTime = rs.getString("Q_CREATE_TIME");
						int likeCount = rs.getInt("LIKE_COUNT");
						
						Question question = new Question(questionNo,chatCode, userId, questionContent, qCreateTime, likeCount);
						questionList.add(question);
						}
						
					} catch (Exception e) {
						//e.printStackTrace();
					} finally {
						try {
							if(rs != null) rs.close();
							if(pstmt != null) pstmt.close();
							if(conn != null) conn.close();
						} catch (Exception e) {
							//e.printStackTrace();
						}
					}
				}
				return questionList;
			}
			
			// 珥덇린 異쒕젰(理쒖떊�닚)
			ArrayList<Question> getQuestionListByRecent(int number, String cCode) {
				ArrayList<Question> questionList = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;		
				
				String sql = "SELECT * FROM QUESTIONS WHERE CHAT_CODE = ? AND QUESTION_NO > (SELECT MAX(QUESTION_NO) - ? FROM QUESTIONS) ORDER BY Q_CREATE_TIME";
				try {
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, Integer.parseInt(cCode));
					pstmt.setInt(2, number);
					rs = pstmt.executeQuery();
					
					questionList = new ArrayList<Question>();
					while(rs.next()) {
						int questionNo = rs.getInt("QUESTION_NO");
						int chatCode = rs.getInt("CHAT_CODE");
						String userId = rs.getString("USER_ID");
						// �듅�닔 湲고샇 泥섎━
						String questionContent = rs.getString("QUESTION_CONTENT").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>");
						String qCreateTime = rs.getString("Q_CREATE_TIME");
						int likeCount = rs.getInt("LIKE_COUNT");

						
						Question question = new Question(questionNo,chatCode, userId, questionContent, qCreateTime, likeCount);
						questionList.add(question);
						}
						
					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						try {
							if(rs != null) rs.close();
							if(pstmt != null) pstmt.close();
							if(conn != null) conn.close();
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				return questionList;
			}
		
		// 醫뗭븘�슂 update
		public int likeUpdate(String qNo) {
			PreparedStatement pstmt = null;
			ResultSet rs = null;		
			String sql = "UPDATE QUESTIONS SET LIKE_COUNT = LIKE_COUNT +1 WHERE QUESTION_NO = ?";
			
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(qNo));
				
				return pstmt.executeUpdate();
				
					
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					try {
						if(rs != null) rs.close();
						if(pstmt != null) pstmt.close();
						if(conn != null) conn.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			
			return -1;
		}
		
		// 醫뗭븘�슂 痍⑥냼 
		public int likeUpdateDelete(String qNo) {
			PreparedStatement pstmt = null;
			ResultSet rs = null;		
			String sql = "UPDATE QUESTIONS SET LIKE_COUNT = LIKE_COUNT -1 WHERE QUESTION_NO = ?";
			
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(qNo));	
				
				System.out.println("===========QDAO--likeUpdate=========-");
				return pstmt.executeUpdate();

					
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					try {
						if(rs != null) rs.close();
						if(pstmt != null) pstmt.close();
						if(conn != null) conn.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			
			return -1;
		}
		
		// 吏덈Ц �옉�꽦�븳 user_no 媛��졇�삤湲�
			public String getUserID(String qNo) {
				PreparedStatement pstmt = null;
				ResultSet rs = null;		
				String sql = "SELECT USER_NO FROM QUESTIONS WHERE QUESTION_NO = ?";
				
				try {
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, Integer.parseInt(qNo));
					rs = pstmt.executeQuery();
					if(rs.next()) {
						return rs.getString(1);
					}
						
				} catch (Exception e) {
						e.printStackTrace();
				} finally {
						try {
							if(rs != null) rs.close();
							if(pstmt != null) pstmt.close();
							if(conn != null) conn.close();
						} catch (Exception e) {
							e.printStackTrace();
						}
				}
				return null;
			}
			
		
		// like count 遺덈윭�삤湲�
		public String getLike(String qNo) {
			PreparedStatement pstmt = null;
			ResultSet rs = null;		
			String sql = "SELECT LIKE_COUNT FROM QUESTIONS WHERE QUESTION_NO = ?";
			
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(qNo));
				rs = pstmt.executeQuery();
				if(rs.next()) {
					return rs.getString(1);
				}
					
			} catch (Exception e) {
					e.printStackTrace();
			} finally {
					try {
						if(rs != null) rs.close();
						if(pstmt != null) pstmt.close();
						if(conn != null) conn.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
			}
			return null;
		}
		
		

		
		//吏덈Ц create
		public int submit(int chatCode,String userId, String questionContent) {
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "INSERT INTO QUESTIONS( QUESTION_NO, Q_CREATE_TIME, CHAT_CODE, USER_ID, QUESTION_CONTENT, LIKE_COUNT)"
					+ "VALUES(Q_NO_SEQ.NEXTVAL, SYSDATE, ?, ?, ?, 0)";
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, chatCode);
				pstmt.setString(2, userId);
				pstmt.setString(3, questionContent);
				return pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if(rs != null) rs.close();
					if(pstmt != null) pstmt.close();
					if(conn != null) conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			return -1;
		}
		
		
		//ip二쇱냼�씪硫� �떞�옄... Question�쓽 chatcode瑜� 以묐났�뾾�씠... 洹몃윭怨� �굹�꽌 chat code瑜� �씠�슜�빐 chat title�쓣 李얠븘�꽌 硫붿씤�솕硫댁뿉 肉뚮젮二쇱옄 
				public ArrayList<Integer> getAllChatCode(String ip) { 
					ArrayList<Integer> allChatCode = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;		
					String sql = "SELECT DISTINCT CHAT_CODE FROM QUESTIONS WHERE USER_ID LIKE ?||'%'";
					try {
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, ip);
						rs = pstmt.executeQuery();
						
						allChatCode = new ArrayList<Integer>();
						while(rs.next()) {
							int chatCode = rs.getInt("CHAT_CODE");
							allChatCode.add(chatCode);
							}
						} catch (Exception e) {
							e.printStackTrace();
						} finally {
							try {
								if(rs != null) rs.close();
								if(pstmt != null) pstmt.close();
								if(conn != null) conn.close();
							} catch (Exception e) {
								e.printStackTrace();
							}
						}

					return allChatCode;
				}
}