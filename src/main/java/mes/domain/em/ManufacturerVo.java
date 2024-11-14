package mes.domain.em;

import lombok.Data;

@Data
public class ManufacturerVo {

	private String menuAuth;              //메뉴권한	
	private String goodsCd;
	private String goodsNm;
	private String alnicuMatrlCd;
	private String filmMatrlCd;	
	private String model;
	private String qutyCd;
	private String qutyNm;	
	private String alniQutyNm;
	private String alniThickness;
	private String alniWidth;
	private String alniLength;
	private String alniPitch;
	private String filmQutyNm;
	private String filmThickness;
	private String filmDepth;
	
	//join시 사용
	private String surfaceTrtmtCd;	//표면처리 코드
	private String surfaceTrtmtNm;	//표면처리 명
	
	private String equipCondSeq;
	private String condRegDate;
	private String alniDepth;
	private String filmMatrlDesc;
	private String equipCd;
	private String equipNm;
	private String fpUseYn;
	private String fpMainGubun;
	
	private String pageGubun;			//페이지 구분자  (기초제조조건관리: bmsc3050, 제조조건관리: emsc3030)
}