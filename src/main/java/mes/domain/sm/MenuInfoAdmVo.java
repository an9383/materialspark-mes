package mes.domain.sm;

import java.util.Date;
import lombok.Data;

@Data
public class MenuInfoAdmVo {
	
	private String menuAuth;              //메뉴권한
	private String idx;
	private String menuId;
	private String upperMenuId;
	private String menuNm;
	private String menuPath;
	private String regId;
	private Date regDate;
	private String updId;
	private Date updDate;
	private String depthFullPath;
	private String menuPopupYn;
	private String menuPopupYnNm;
	private String userNumber;
	
	// 추사 항목
	private String dataArray;

	private String baseCd;
	private String baseCdNm;
	private String baseGroupCd;
	private String etc1;
	private String userAuthCode;
	private String userAuthCodeName;
}