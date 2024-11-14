package mes.domain.bm;

import lombok.Data;

@Data
public class AccidentFreeVo {

	private String menuAuth;              //메뉴권한	
	private String idx;
	private String startDate;
	private String regDate;
	private String regId;
	private String targetDate;
	private String posted;
	private String postTime;
	private String updId;
	private String updDate;
	private String userNm;
	private String postedNm;
	private String imgNm;
	private byte[] img;
	
	
}