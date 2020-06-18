package like;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import ChatDB.Chat;
import ChatDB.ChatDAO;

public class LikeDAO {
	private static final String Driver = "oracle.jdbc.driver.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@192.168.0.21:1521:xe";
	private static final String ID = "c##ora_user";
	private static final String PW = "12345";
	
	private static LikeDAO instance = null; //singleton pattern
	
	private Connection conn;
	
	public LikeDAO() {
			try {
				Class.forName(Driver);
				try {
				Connection conn = DriverManager.getConnection(URL,ID,PW);
				}catch(SQLException e) {
					e.printStackTrace();
				}
			}catch(ClassNotFoundException e) {
				e.printStackTrace();
			}	
	}
	
	public static LikeDAO getInstance() {
		if(instance==null) {
		instance = new LikeDAO();}
		return instance;
	}
	
	public Connection getConnection() throws SQLException {
		return DriverManager.getConnection(URL,ID,PW);
	}
	
	public void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
        try {
            if (rs != null)
                rs.close();
            if (pstmt != null)
                pstmt.close();
            if (conn != null)
                conn.close();
        } catch (SQLException e) {
//            System.out.println("DB close");
            e.printStackTrace();
        }
	}
	
	public int likeInsert(String userId, String questionNo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String sql = "INSERT INTO Q_LIKE (LIKE_NO, USER_ID, QUESTION_NO) VALUES(LIKE_NO.NEXTVAL, ?, ?)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setInt(2, Integer.parseInt(questionNo));
			return pstmt.executeUpdate();
			//return 1
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.close(conn, pstmt, null);
		}
		return -1;
	}
	
	public int likeDelete(String userId, String questionNo) {
		
		System.out.println("=======likeDAO likedelete() 실행=======");
		
		Connection conn = null;
		PreparedStatement pstmt = null;

		String sql = "DELETE FROM Q_LIKE WHERE USER_ID=? AND QUESTION_NO =? ";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setInt(2, Integer.parseInt(questionNo));
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.close(conn, pstmt, null);
		}
		return -1;
	}
	
	// 무결성 확인용 getQuestionNo()
		public int getQuestion(String userId, String qNo) {
			
			System.out.println("=======likeDAO getQuestion() 실행=======");
			
			Connection conn = null;
			PreparedStatement pstmt = null;	
			ResultSet rs = null;
			
			String sql = "SELECT QUESTION_NO FROM Q_LIKE WHERE USER_ID = ? AND QUESTION_NO =?";
			
			int result;
			
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userId);
				pstmt.setInt(2, Integer.parseInt(qNo));
				rs = pstmt.executeQuery();
				if(rs.next()) {
					result = rs.getInt(1);
					System.out.println("getQuestion 성공: "+ result );
					return result;
				}
					
			} catch (Exception e) {
					e.printStackTrace();
			} finally {
				this.close(conn, pstmt, null);
			}
			result = 0;
			System.out.println("getQuestion 실패: "+ result );
			return result;
		}

}
