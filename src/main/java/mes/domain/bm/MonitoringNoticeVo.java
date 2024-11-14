package mes.domain.bm;

import lombok.Data;

@Data
public class MonitoringNoticeVo {

	private String menuAuth;              //메뉴권한	
	private int idx;
	private String content;
	private String userNm;
	private String regId;
	private String regDate;
	private String updId;
	private String updDate;
	
}