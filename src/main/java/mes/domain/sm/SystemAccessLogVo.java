package mes.domain.sm;

import lombok.Data;

@Data
public class SystemAccessLogVo {
	
	private String seq;
	private String userNumber;
	private String userId;
	private String userNm;
	private String departmentCd;
	private String menuId;
	private String menuNm;
	private String menuPath;
	private String accesDate;
	private String regId;
	private String regDate;
}

