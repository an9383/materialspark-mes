package mes.domain.po;

import java.util.Date;

import lombok.Data;

@Data
public class WorkOrderVo {
	
	private String menuAuth;            		//메뉴권한
	private String workOrdNo;           		//작업지시번호
	private String connectWorkOrdNo;			//작업지시번호
	private String workOrdLotNo;				//생산LotNo
	private String ordLotNo;					//작업지시 Lot 번호
	private String equipCd;             		//설비코드
	private String equipNm;             		//설비명
	private String capa;						//설비당 목표 생산수량
	private String goodsCd;               		//제품코드
	private String goodsNm;               		//제품명
	private String ordGubun;              		//작업지시구분
	private String ordGubunNm;            		//작업지시구분명
	private String equipCondSeq;		 		//설비제조조건
	private String ordDate;               		//작업지시등록일
	private String ordDate1;               		
	private String ordDate2;   	
	
	
	private String subWorkStatusCd;       		//작업상태
	private String subWorkStatusNm;       		//작업상태명
	private String workStatusCd;          		//작업상태
	private String workStatusNm;          		//작업상태
	private String workInspectionStatusCd;		//검사상태	
	private String workInspectionStatusNm;		//검사상태	
	private String workTeamCd;            		//작업조
	private String workTeamNm;            		//작업조명
	private String mainWorkChargr;        		//주작업담당자
	private String mainWorkChargrNm;      		//주작업담당자명
	private String subWorkChargr;         		//서브작업담당자
	private String subWorkChargrNm;       		//서브작업담당자명	
	private String targetWeight;          		//투입중량
	private String outputWeight1;         		//생산중량1
	private String outputWeight2;         		//생산중량1
	private String outputWeight3;         		//생산중량3
	private String outputWeight4;         		//생산중량4
	
	private int outputCount1;					//생산중량1 변환
	private int outputCount2;					//생산중량2 변환
	private int outputCount3;					//생산중량3 변환
	private int outputCount4;					//생산중량4 변환
	
	private int targetCnt;                		//목표수량
	private int outputCnt;               		//생산수량
	private int userInputInspctCnt;				//실 검사수량
	
	private String customDealCorpCd;      		//출고처 거래처코드
	private String customDealCorpNm;    		//출고처 거래처명
	private String dealCorpCd;          	 	//거래처코드
	private String dealCorpNm;            		//거래처코드명
	private int edgeSampleCnt;       		    //엣지샘플수량
	private int edgeFaultyCnt;            		//엣지검사불량수량
	private int edgeOutputCnt;			  		//엣지양품수량
	
	private float edgeRollFaultySize;			//엣지롤 불량 치수
	private float edgeSymbolFaultySize;			//엣지기호 불량 치수
	private float edgeBurFaultySize;			//엣지Bur 불량 치수
	
	private int totalInspectCnt;			//엣지 불량수량 + 외관불량수량 + 외관양품수량
	private int totalFaultyCnt;				//엣지불량수량 + 외관불량수량 , 또는 불량합계
	private int userOutputCnt;				//사용자 양품수량 입력
	private int sumOutputCnt;				//설비별&주야간 생산수량
	
	private String edgeInspctCharger;     //엣지검사담당
	private String edgeInspctChargerNm;   //엣지검사담당명
	private String edgeInspctDate;        //엣지검사일
	private int appearAbrfCnt;            //외관검사해외1
	private int appearAbrsCnt;            //외관검사해외2
	private int appearDmsCnt;             //외관검사국내
	private int appearFaultyCnt;          //외관검사불량수량
	private int appearOutputCnt;		  //외관양품수량
	private String appearInspctCharger;   //외관검사담당
	private String appearInspctChargerNm; //외관검사담당명	
	private String appearInspctDate;      //외관검사일
	private String workStartTime;		  //작지시작시간
	private String workEndTime;			  //작지종료시간
	private String workTime;			  //작지시간
	private String packYn;			  	  //포장여부
	private String packDate;			  //포장일
	private int packCnt;			  	  //포장수
	
	private double sealing1;				//실링 검사값1
	private double sealing2;				//실링 검사값2
	private String filmFaultyCheck;			//외관 필름 이상
	private String sealingDate;				//실링검사일
	
	private String regId;                 //등록자
	private String regDate;                //등록일
	private String updId;                 //수정자
	private String updDate;               //수정일
	
	//detail
	private String alnicuMatrlCd;
	private String filmMatrlCd;
	private String filmMatrlNm;
	private String gravity;
	private String matrlCd;
	private String matrlNm;
	private String approvalCd;
	private String 	approvalNm;
	private String lotNo;                 //자재LOT_NO
	private String barcodeNo;             //바코드	
	private String model;                 //규격
	private String qutyCd;                //재질코드
	private String qutyNm;                //재질명
	private String surfaceTrtmtCd;        //표면처리코드
	private String surfaceTrtmtNm;        //표면처리명	
	private String inWhsQty;
	private String inspectQty;	
	private String fairQty;
	private String faultyQty;	
	private String workNo;
	private String userNm;                //사원명
	private String userNumber;            //사원코드
	private String userId;                //사원ID
	private float faultyPercent;		  //불량율
	private String statusCd;			  //상태값	
	private String mainWorkNm;		  	  //주작업자 이름
	private String subWorkNm;		  	  //서브작업자 이름
	private String chooseDate1;		  	  //날짜조건 1
	private String chooseDate2;		  	  //날짜조건 2
	
	private String targetAsum;
	private String targetBsum;
	private String targetCsum;
	private String outputAsum;
	private String outputBsum;
	private String outputCsum;
	private float percentA;
	private float percentB;
	private float percentC;
	private String totalTarget;
	private String totalOutput;
	private float totalPercent;
	
	private String equipGroup;
	private String equipGroupNm;
	
	private String achievePercent;
	private String filmNm;
	private String chamferYnNm;
	private String gubunCd;
	private String gubunNm;
	private String packUnitCd;	
	private String packUnitNm;
	private String remakeYn;
	
	private String matrlInital;		//주자재 이니셜
	
	private String chooseDateFrom;	//기간검색조건 1
	private String chooseDateTo;	//기간검색조건 2
	private String chooseDate;		//기간검색조건 3
	
	private String productionDate;	//생산일
	private String productionFrom;	//생산일
	private String productionTo;	//생산일
	
	
	//외관불량수량 Join시 사용
	private int metalMmb;
	private int metalMms;
	private int metalPms;
	private int metalFstab;
	private int metalPstab;
	private int metalAliensbst;
	private int metalBreak;
	private int metalPolutn;
	private int metalBrowning;
	private int metalPpolutn;
	private int metalGilt;
	private int metalThickness;
	private int metalEtc;
	private int filmPfs;
	private int filmBreak;
	private int filmTornout;
	private int filmSurfceBb;
	private int filmEdgeBb;
	private int filmTeflon;
	private int filmAliensbst;
	private int filmPolutn;
	private int filmAgglomt;
	private int filmOverlap;
	private int filmUnjinjeop;
	private int filmUnattch;
	private int filmMf;
	private int filmWing;
	private int filmEtc;
	private int etcSize;
	private int etcCutting;
	private int etcFilmPress;
	private int etcFilmDepth;
	private int etcLayer;
	private int etcEtc;
	private int etcWashboard;
	private int etcWhitetape;
	private int etcPattem;
	private int etcStabbed;
	private int etcHaze;
	private int etcSurface;
	private int etcSwelling;
	private int etcFeeding;
	private int etcFilm;
	private int etcSlash;
	private int etcJinjeop;
	private int etcCrack;
	private int etcCrease;
	
	private String changeLocation; // 자재투입내역 교체위치
	private String connectCd;		//연결여부코드
	private String connectNm;		//연결여부명
	
	private String workOrdSeq;
	private String outputWeight;	
	private String gubun;
	private String gubun1;
	private String gubun2;
	private String workOrdDate;
	
	private String workOrdSubOrdLotNo;	//작지 인쇄시 사용
	private String workOrdSubLotNo;		//작지 인쇄시 사용

	private String mainMatrlList;	//품질관리-최종검사현황에서 사용
	private String subMatrlList;	//품질관리-최종검사현황에서
	private String mainMatrl1;
	private String mainMatrl2;
	private String mainMatrl3;
	private String subFilm1;
	private String subFilm2;
	private String subFilm3;
	private String subFilm4;
	private String visionFaultySum;
	private String baseCdAbbr;		//주,부자재 구분
	private String baseNm;
	
	private String connectMatrlBarcode;
	
	private String workerId;
	private String workerIdNm;
	
	//외관검사 코드화
	private String majorCd;
	private String minorCd;
	private String faultyCnt;
	private String seq;
	private String inspctChargr;
	private String inspctChargrNm;
	private String dayNightCd;
	private String dayNightNm;
	private String codeList;
	private String codeList2;
	private String egCodeList;
	private int faultSum;               //총 불량수량
	private float faultPercent;         //총 불량률
	private String faultyStatus; 
	private String faultyStatusNm; 
	private String faultyCntSum;		//비전불량 총수량
	private int totalQuantity;
	private String wokrOrdLotNo;
	private String dealCorpInfo;
	

	private String faulty1;
	private String faulty2;
	private String faulty3;
	private String faulty4;
	private String faulty5;
	private String faulty6;
	private String faulty7;
	private String faulty8;
	private String faulty9;
	private String faulty10;
	private String faulty11;
	private String faulty12;
	private String faulty13;
	private String faulty14;
	private String faulty15;
	private String faulty16;
	private String faulty17;
	private String faulty18;
	private String faulty19;
	private String faulty20;
	private String faulty21;
	private String faulty22;
	private String faulty23;
	private String faulty24;
	private String faulty25;
	private String faulty26;
	private String faulty27;
	private String faulty28;
	private String faulty29;
	private String faulty30;
	private String faulty31;
	private String faulty32;
	private String faulty33;
	private String faulty34;
	private String faulty35;
	private String faulty36;
	private String faulty37;
	private String faulty38;
	private String faulty39;
	private String faulty40;
	private String faulty41;
	private String faulty42;
	private String faulty43;
	private String faulty44;
	private String faulty45;
	private String faulty46;
	private String faulty47;
	private String faulty48;
	private String faulty49;
	private String faulty50;
	private String faulty51;
	private String faulty52;
	private String faulty53;
	private String faulty54;
	private String faulty55;
	private String faulty56;
	private String faulty57;
	private String faulty58;
	private String faulty59;
	private String faulty60;
	private String faulty61;
	private String faulty62;
	private String faulty63;
	private String faulty64;
	private String faulty65;
	private String faulty66;
	private String faulty67;
	private String faulty68;
	private String faulty69;
	private String faulty70;
	private String faulty71;
	private String faulty72;
	private String faulty73;
	private String faulty74;
	private String faulty75;
	private String faulty76;
	private String faulty77;
	private String faulty78;
	private String faulty79;
	private String faulty80;
	private String faulty81;
	private String faulty82;
	private String faulty83;
	private String faulty84;
	private String faulty85;
	private String faulty86;
	private String faulty87;
	private String faulty88;
	private String faulty89;
	private String faulty90;
	private String faulty91;
	private String faulty92;
	private String faulty93;
	private String faulty94;
	private String faulty95;
	private String faulty96;
	private String faulty97;
	private String faulty98;
	private String faulty99;
	private String faulty100;
	private String faulty101;
	private String faulty102;
	private String faulty103;
	private String faulty104;
	private String faulty105;
	private String faulty106;
	private String faulty107;
	private String faulty108;
	private String faulty109;
	private String faulty110;
	private String faulty111;
	private String faulty112;
	private String faulty113;
	private String faulty114;
	private String faulty115;
	private String faulty116;
	private String faulty117;
	private String faulty118;
	private String faulty119;
	private String faulty120;
	private String faulty121;
	private String faulty122;
	private String faulty123;
	private String faulty124;
	private String faulty125;
	private String faulty126;
	private String faulty127;
	private String faulty128;
	private String faulty129;
	private String faulty130;
	private String faulty131;
	private String faulty132;
	private String faulty133;
	private String faulty134;
	private String faulty135;
	private String faulty136;
	private String faulty137;
	private String faulty138;
	private String faulty139;
	private String faulty140;
	
	//추가
	private String firstStepCheck;
	private String firstStepCheckNm;
	private String secondStepCheckNm;
	private String thirdStepCheckNm;
	private String workOrderGubun;
	private String factoryCode;
	
	//--------주자재 변경 관련 사항 --------//
	private String beforeLotNo;
	private String afterLotNo;
	private String outWhsDate;
	private String outEquipCd;
	private String outGoodsCd;
	private String outQty;
	private String metalChangeRemakeYn;
	private String updateGubun;
	
	private String exceptFaultyQty;
	
	private String excludingFilm;
	
	
	//종합 수량 엣지 추가
	private String egFaulty1;
	private String egFaulty2;
	private String egFaulty3;
	private String egFaulty4;
	private String egFaulty5;
	private String egFaulty6;
	private String egFaulty7;
	private String egFaulty8;
	private String egFaulty9;
	private String egFaulty10;
	private String egFaulty11;
	private String egFaulty12;
	private String egFaulty13;
	private String egFaulty14;
	private String egFaulty15;
	private String egFaulty16;
	private String egFaulty17;
	private String egFaulty18;
	private String egFaulty19;
	private String egFaulty20;
	private String egFaulty21;
	private String egFaulty22;
	private String egFaulty23;
	private String egFaulty24;
	private String egFaulty25;
	private String egFaulty26;
	private String egFaulty27;
	private String egFaulty28;
	private String egFaulty29;
	private String egFaulty30;
	private String egFaulty31;
	private String egFaulty32;
	private String egFaulty33;
	private String egFaulty34;
	private String egFaulty35;
	private String egFaulty36;
	private String egFaulty37;
	private String egFaulty38;
	private String egFaulty39;
	private String egFaulty40;
	private String egFaulty41;
	private String egFaulty42;
	private String egFaulty43;
	private String egFaulty44;
	private String egFaulty45;
	private String egFaulty46;
	private String egFaulty47;
	private String egFaulty48;
	private String egFaulty49;
	private String egFaulty50;
	private String egFaulty51;
	private String egFaulty52;
	private String egFaulty53;
	private String egFaulty54;
	private String egFaulty55;
	private String egFaulty56;
	private String egFaulty57;
	private String egFaulty58;
	private String egFaulty59;
	private String egFaulty60;
	private String egFaulty61;
	private String egFaulty62;
	private String egFaulty63;
	private String egFaulty64;
	private String egFaulty65;
	private String egFaulty66;
	private String egFaulty67;
	private String egFaulty68;
	private String egFaulty69;
	private String egFaulty70;
	private String egFaulty71;
	private String egFaulty72;
	private String egFaulty73;
	private String egFaulty74;
	private String egFaulty75;
	private String egFaulty76;
	private String egFaulty77;
	private String egFaulty78;
	private String egFaulty79;
	private String egFaulty80;
	

	private int idx;
	private String trayNo;
	private String trayNo1;
	private String trayNo2;
	private String matrlLotNo;
	private String lastMatrlLotNo;
	private String filmLotNo;
	private String inspStatus;
	private String inspStatusNm;
	private String reInspStatus;
	private String reInspStatusNm;
	
	private String disStatus;
	private String disStatusNm;
	private String inspDate;
	private String faultyTrayNo;
	private String majorNm;
	private String minorNm;
	private String faultyGubun;
	private String faultyGubunNm;

	//추가
	private String arrayData;
	private String remainQty;
	private int countWorkingWorkOrd;
	private String qutyEtcNm;
	private String Cnt;
	
	private int matrlFaultyCnt;	//총 메탈부불량수량
	private int filmFaultyCnt;  //총 필름부불량수량
	private String dateCheck;  //총 필름부불량수량
	private String reInspCnt;
	private String	matrlInitial;
	private String	workOrdDateYyyy;
	private String	dateDivision;
	
	private String	workOrdDateMm;
	private String	workOrdDateWw;
	private String	showType;
	private int countCommonCode;
	private String lastWorkOrdNo;
	private String inWhsTime;
	private String floorGubun;
	
	private String alphabetSeq;

}