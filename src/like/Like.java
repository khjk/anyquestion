package like;

public class Like {
	
	int LikeNo;
	String UserId;
	int QuestionNo;
	
	public Like(int likeNo, String userId, int questionNo) {
		super();
		LikeNo = likeNo;
		UserId = userId;
		QuestionNo = questionNo;
	}
	
	public Like() {
	}
	
	public int getLikeNo() {
		return LikeNo;
	}
	public void setLikeNo(int likeNo) {
		LikeNo = likeNo;
	}
	
	public String getUserId() {
		return UserId;
	}

	public void setUserId(String userId) {
		UserId = userId;
	}

	public int getQuestionNo() {
		return QuestionNo;
	}
	public void setQuestionNo(int questionNo) {
		QuestionNo = questionNo;
	}
}
