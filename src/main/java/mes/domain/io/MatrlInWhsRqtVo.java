package mes.domain.io;

import java.util.Date;
import lombok.Data;

@Data
public class MatrlInWhsRqtVo {

	private String menuAuth;              //메뉴권한	
	private String lotNo;
	private String srLot;
	private String inWhsGroupSeq;
	private String matrlCd;
	private String matrlNm;	
	private String preInWhsQty;
	private String inWhsQty;
	private String inspectQty;
	private String adjustQty;	
	private String diffQty;
	private String inWhsLength;
	private String spplyDealCorpCd;
	private String spplyDealCorpNm;	
	private String preInWhsDate;
	private String inWhsDate;
	private String inWhsDateFrom;
	private String inWhsDateTo;	
	private String inspctDate;
	private String barcodeNo;
	private String approvalCd;
	private String approvalNm;		
	private String statusCd;
	private String matrlChargr;
	private String matrlChargrNm;	
	private String preOutWhsDate;
	private String preOutEquipCd;
	private String preOutEquipNm;	
	private String outWhsDate;
	private String outEquipCd;
	private String outEquipNm;	
	private String locationCd;
	private String locationNm;	
	private String inWhsDesc;
	private String fifoCheck;
	private String remainQty; //잔량
	private String paidGubun; //유상, 무상 구분
	
	private String lifeTime;
	private String surfaceDate;
	private String data1;
	private String data2;
	private String motherRollLot;
	private String motherRollLotNo;
	private String standard;
	private String rollCount;
	
	private String regId;
	private Date regDate;
	private String updId;
	private Date updDate;
	private String url;
	
	private String gubunCd;
	private String gubunNm;
	private String chamferYnCd;
	private String chamferYnNm;
	private String surfaceTrtmtCd;
	private String surfaceTrtmtNm;
	
	private String rollCnt;
	private String weightUnit;
	private String inWhsTime;
	
}
