package mes.domain.sm;

import java.util.Date;
import lombok.Data;

@Data
public class SystemLogAdmVo {
	
	private String loginNo;
	private String userId;
	private String logDate;
	private String gubun;
	private String ipAddress;
	private String etc;
	private String userNm;
	
	private String seq;
	private String userNumber;
	private String departmentCd;
	private String menuId;
	private String menuNm;
	private String menuPath;
	private String accessDate;
	private String regId;
	private String regDate;
	private String departmentCdNm;
	private String menuPathNm;

	//추가사항
	private String chooseDate1;
	private String chooseDate2;

}