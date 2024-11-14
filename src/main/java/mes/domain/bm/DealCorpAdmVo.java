package mes.domain.bm;

import java.util.Date;
import lombok.Data;

@Data
public class DealCorpAdmVo {

	private String menuAuth;              //메뉴권한	
	private String dealCorpCd;
	private String dealCorpNm;
	private String initial;
	private String presidentNm;
	private String country;
	private String corpNo;
	private String registNo;
	private String bizCond;
	private String bizType;
	private String addrNo;
	private String addrBase;
	private String addrDtl;
	private String telNo;
	private String faxNo;
	private String emailAddr;
	private String tax;
	private String officeChrger;
	private String bizChrger;
	private String dealGubun;
	private String useYnCd;
	private String dealCorpDesc;
	private String dealCorpInfo;
	private String regId;
	private Date regDate;
	private String updId;
	private Date updDate;
	
	private String dealGubun1;		//매출
	private String dealGubun2;      //매입
	private String dealGubun3;      //입고
	private String dealGubun4;      //출고
	private String dealGubun5;      //자재
	private String dealGubun6;      //기타
	
}