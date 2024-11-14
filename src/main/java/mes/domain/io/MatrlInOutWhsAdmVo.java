package mes.domain.io;

import lombok.Data;

@Data
public class MatrlInOutWhsAdmVo {

	private String menuAuth;              //메뉴권한	
	private String lotNo;
	private String lotNoCheck;
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
	private String inWhsDays;
	private String inWhsDateFrom;
	private String inWhsDateTo;
	private String disposeGubun;
	private String disposeGubunNm;
	
	private String factoryCode;
	private String newPoGroup;
	
	private String inWhsDateFrom_F3;
	private String inWhsDateTo_F3;
	
	private String inspctDate;
	private String barcodeNo;
	private String approvalCd;
	private String inApprovalCd;
	private String approvalNm;		
	private String statusCd;
	private String statusNm;
	private String matrlChargr;
	private String matrlChargrNm;
	private String frrrdDate;			//불량&반품&실반품&자체폐기 일
	private String frrrdType;   		//불량&반품&실반품&자체폐기 사유
	private String frrrdDesc;   		//불량&반품&실반품&자체폐기 비고
	private String filmType;
	private String retestDate;
	private String preOutWhsDate;
	private String preOutEquipCd;
	private String preOutEquipNm;
	private String preOutGoodsCd;
	private String preOutGoodsNm;	
	private String preOutQty;
	private String preWorkCharger;
	private String preWorkChargerNm;
	private String outEquipCd;
	private String outEquipNm;	
	private String outGoodsCd;	
	private String outGoodsNm;
	private String outQty;	
	private String outWorkCharger;
	private String outWorkChargerNm;	
	private String outWhsDate;
	private String locationCd;
	private String locationNm;	
	private String inWhsDesc;
	private String regId;
	private String regDate;
	private String updId;
	private String updDate;
	private String histId;
	private String histDate;
	private String qutyCd;
	private String qutyNm;
	private String surfaceTrtmtCd;
	private String surfaceTrtmtNm;		
	private String thickness;
	private String depth;
	private String length;
	private String width;
	private String pitch;
	private String model;
	private String lifeCycle;
	private String endLifeCycle;
	private String preOutWhsDateFrom;
	private String preOutWhsDateTo;
	private String faultyStatus; // 제품상태
	
	private String preInDiff;	//가입고량 - 입고량 차이
	private String outputHistDate; //출고이력일
	private String poGubunCd; // 오더구분
	private String poGubunNm; // 오더구분 이름
	private String poAttn; //담당자
	private String poNo; 
	private String poNoSeq; 
	private String boxCount; //박스수량
	private String outputQty; //출고수량
	private String deliveryDate; //납기일
	private String deliveryDealCorpCd; //출고처 코드
	private String deliveryDealCorpNm; //출고처 이름
	private String dealCorpCd;
	private String dealCorpNm;
	private String goodsCd;
	private String goodsNm;
	private String poSeq;
	private String poGroup;
	private String packCnt;
	private String goodsInDate;
	private String remainCnt;
	private String remainQty; //잔량
	private String boxNo;
	private String packDate;
	
	private String equipGroup;	// 설비 그룹
	private String matrlGubunCd;
	
	private String etc1;
	private String etc2;
	
	private String approvalCd001;	//수입검사관리 목록출력시 상태개수
	private String approvalCd002;
	private String approvalCd003;
	private String approvalCd004;
	private String approvalCd005;
	private String approvalCd006;
	private String approvalCd007;
	private String approvalCd008;
	private String approvalCd009;
	
	private String matrlInitial;	// 자재 이니셜 품질검사 바코드 인쇄시 사용
	
	private String optimumStock; //적정재고
	
	private String fifoCheck;	//선입선출 구분
	
	private String ipAddress;	//삭제자 IP
	private String dltId;		//삭제자
	private String dltDate;		//삭제일
	
	private String baseCdAbbr;	//세부코드 약칭(Al, Ni, F 구분)
	private String outputCnt;
	private String ordGubun;
	private String ordGubunNm;
	
	private String goodsRemainSum;	//제품통계 제품별 재고 합계
	private String diffQtyGubun;	//적정재고관리 적정여부 정상, 부족 선택 selectBox
	
	private String gubunCd;
	private String gubunNm;
	private String chamferYnCd;
	private String chamferYnNm;
	
	private String chooseDateFrom;		//사용자 선택 날짜1
	private String chooseDateTo;		//사용자 선택 날짜2
	private String excludeStatusO;		//입출고관리-가출고현황 제외
	private String excludeStatusP;		//입출고관리-생산투입 제외
	
	private String excelTitle;			//제품재고 엑셀 다운시 타이틀
	private String tapTemp;				//입출고관리-부적합 자재현황 탭 판별
	private String manufactrCd;
	
	private String workOrdNo;
	private String fairQty;
	private String faultyQty;
	private String remakeYn;
	private String changeLocation;
	private String connectCd;
	private String connectNm;
	
	private String goodsStatus;
	private String goodsStatusNm;
	private String faultystatus;
	private String faultyStatusNm;
	private String goodsNmList;
	
	private String inspectCd;
	private String inspectNm;
	private String inspectWaitQty;
	
	private String fifoGubun;
	
	private String allLookup;
	
	private String exceptBarcodeNo;	//스캔한 포장번호(선입선출에서 추가로 제외시킬 항목);
	
	private String motherRollLot;
	private String rollCount;
	private String arrayData;

	private String startDate;
	private String endDate;
	
	private String customerLotNo;
	
	private String rollCnt;
	private String weightUnit;
	private String paidGubun;
	private String paidGubunNm;
	
	private String inCount;
	private String outCount;
	private String carryOverCount;
	private String printYn;
	private String completeYn;
	private String printWether;
	private String poDate;
	private String goodsOutDate;
	private String poCode;

	private String rqSaveCheck; //작업지시선택에서 수정하는지 체크하는 변수
	private String scanPalletNo;
	private String palletQty;
	private String rowId;
	private String fautlyByProductionTeam;
	private String goodsDesc;
	private String deadLine;
	private String originalEquipNm;
	private String equipCd;
	private String equipNm;
	private String locationInputDate;
	
	//출하검사성적서관련 컬럼 추가
	private String toDay;
	private String totalOutQty;
	private String excelFormGubun;
	private int excelOutputCnt;
	
	private String data;
	private String resvData;
	private float ppfDepthLeftAlwnce;
	private float metalDepthAlwnce;
	private float ppfWingLeftAlwnce;
	private float wpLeftAlwnce;
	private float wpDeviation;
	private float metalThicknessAlwnce;
	private float thCenterAlwnce;
	private float filmAlwnce;
	private float pitchLeftAlwnce;
	private float gapOfLayer;
	private String edgePress;
	private String foldingEndurance;
	private float thicknessQty;
	
	private String gubun;
	//출하검사성적서관련 컬럼 추가
	
	private String fileGroup;
	private String fileNm;
	private String customerPalletNo;
	private String factCheck;
	private String modelNo;
	private String inWhsTime;
	private String floorGubun;
	private String matrlFifoCheck;
	
}