package mes.domain.po;

import java.util.Date;
import lombok.Data;

@Data
public class FaultyQtyVo {
	
	private String menuAuth;		//메뉴권한
	private String equipCd;
	private String equipNm;
	private String ordDate;
	private String ordGubun;
	private String goodsCd;
	private String goodsNm;
	private String qutyCd;
	private String qutyNm;
	private float mainFaultyQty;
	private float subFaultyQty;
	private String workTeamCd;
	private String workTeamNm;
	private String mainWorkChargr;
	private String userNumber;	
	private String userNm;
	private String faultyDateTo;
	private String faultyDateFrom;
	private Date regDate;
	private String regId;
	private Date updDate;
	private String updId;
	private String factoryCode;
	
	
	
}