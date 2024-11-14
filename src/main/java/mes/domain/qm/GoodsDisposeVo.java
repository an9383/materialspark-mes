package mes.domain.qm;

import java.util.Date;

import lombok.Data;

@Data
public class GoodsDisposeVo {
	
	private String workOrdNo;    	    //
	private String lotNo;	     		//
	private String equipCd;     		//
	private String goodsCd;       	 	//
	private String goodsNm;       	 	//
	private String qutyNm;       	 	//
	private String ordDate;       	 	//

	private String trayNo;
	private String matrlLotNo;
	private String filmLotNo;
	private String inspStatus;
	private String inspStatusNm;
	private String reInspStatus;
	private String reInspStatusNm;		
	private String disStatus;
	private String disStatusNm;	
	private String inspDate;

	private String faultyGubun;
	private String faultyGubunNm;		
	private String regId;                		//등록자
	private String regDate;                		//등록일
	private String updId;                		//수정자
	private String updDate;               		//수정일
	private String chooseDateFrom;
	private String chooseDateTo;	
	
	private String menuAuth;				// 메뉴권한	
	private String matrlCd;					// 자재코드	
	private String qutyCd;
	private String dealCorpCd;
	private String dealCorpNm;
	private String alnicuMatrlCd;
	private String surfaceTrtmtCd;
	private String surfaceTrtmtNm;
	private String dateCheck;
	private String equipNm;
	private String disposeGubun;
	private String disposeGubunNm;
	private String appointDate;
	
	private String boxNo;
	private String abnormalPrcss;
	private String abnormalDate;
	private String abnormalNo;
	private String abnormalDesc;
	private String manager;
	private String managerNm;
	private String isolationYn;
	private String isolationYnNm;
	private String fileNm;
	private String disposeCnt;
	private String accCnt;
	private String workChargr;
	private String workChargrNm;
	private String inspctChargr;
	private String inspctChargrNm;
	private String inspctDate;
	private String productDate;
	private String abnormalCnt;
	private String departmentCd;
	private String departmentNm;
	private String faultyCnt;
	
	private String labelLotNoSeq;
	private String productQty;


}
