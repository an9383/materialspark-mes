package mes.domain.bm;

import java.util.Date;
import lombok.Data;

@Data
public class MatrlCodeAdmVo {

	private String menuAuth;              //메뉴권한
	private String matrlSeq;	
	private String matrlCd;
	private String matrlNm;
	private String matrlInitial;
	private String matrlGubunCd;
	private String matrlGubunNm;
	private String qutyCd;
	private String qutyNm;
	private String thickness;
	private String depth;
	private String length;
	private String width;
	private String pitch;
	private String gubunCd;
	private String gubunNm;
	private String chamferYnCd;
	private String chamferYnNm;
	private String surfaceTrtmtCd;
	private String surfaceTrtmtNm;	
	private String productUnitCd;
	private String productUnitNm;
	private String tmUnitCd;
	private String tmUnitNm;
	private String dealCorpCd;
	private String dealCorpNm;
	private String lifeCycle;
	private String etc1;
	private String etc2;
	private String useYnCd;
	private String useYnNm;
	private String matrlDesc;
	private String optimumStock; //적정재고
	private String matrlSampleYn;
	private String matrlSelectYn; //기본조회여부(자재)
	private String regId;
	private Date regDate;
	private String updId;
	private Date updDate;
	private String defectCd; //결함구분
	private String defectNm; //결함구분이름
	
	private String model;		//작지 인쇄(다운)시 사용 - Metal규격
	private String chamferY;	//작지 인쇄(다운)시 사용 - 면취 유
	private String chamferN;	//작지 인쇄(다운)시 사용 - 면취 무
	
	private String selectUseYn;
	private String rollGubun; //원롤 구분
	private String rollGubunNm;
	private String approvalCd;
	private String statusCd;
	
	private int dupliCheck;
	
	private String matrlFifoCheck;

}
