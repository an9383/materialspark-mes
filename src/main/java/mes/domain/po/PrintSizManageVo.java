package mes.domain.po;

import lombok.Data;

@Data
public class PrintSizManageVo {
	
	private String menuAuth;		//메뉴권한
	private String idx;
	private String equipCd;
	private String factoryCode;
	private String paperGubun;
	private String xSize;
	private String ySize;
	private String regId;
	private String regDate;
	private String updId;
	private String updDate;
}