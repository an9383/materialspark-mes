package mes.domain.bm;

import lombok.Data;

@Data
public class LogionHistVo {

	private String menuAuth;              //메뉴권한	
	private String loginNo;
	private String userId;
	private String logDate;
	private String gubun;
	private String ipAddress;
	private String etc;
	
}