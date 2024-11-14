package mes.domain.io;

import lombok.Data;

@Data
public class StockPaymentAdmVo {

	private String menuAuth;              //메뉴권한
	private long spSeq;
	private String spCd;
	private String spNm;
	private String lotNo;
	private String spType;
	private String spTypeNm;
	private String spGubun;
	private String spGubunNm;
	private String spDate;
	private float spQty;
	private int spCount;
	private String locationCd;
	private String locationNm;
	private String factoryCd;
	private String factoryNm;
	private String spDesc;
	private String regId;
	private String regDate;
	private String updId;
	private String updDate;

}