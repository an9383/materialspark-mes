package mes.domain.qm;

import java.util.Date;
import lombok.Data;

@Data
public class GoodsFaultyAdmVo {
	
	private String menuAuth;           //메뉴권한
	private String pIdx; 		       //외관 불량 PK
	private String workOrdNo;          //작업지시번호
	private String ordLotNo;			//생산LotNo
	private String equipCd;				//설비코드
	private String equipNm;				//설비명
	private int userInputInspctCnt;		//실검사수량
	private int metalMmb;              //MMB
	private int metalMms;              //MMS
	private int metalPms;              //PMS
	private int metalFstab;            //M찍힘
	private int metalPstab;            //P찍힘
	private int metalAliensbst;        //M이물
	private int metalBreak;            //M꺽임
	private int metalPolutn;           //M오염
	private int metalBrowning;         //M갈변
	private int metalPpolutn;			//P오염
	private int metalGilt;				//도금박리
	private int metalThickness;        //총두께
	private int metalEtc;				//메탈부 - 기타
	private int filmPfs;               //PFS
	private int filmBreak;             //F꺽임
	private int filmTornout;           //뜯김
	private int filmSurfceBb;          //표면기포
	private int filmEdgeBb;            //엣지기포
	private int filmTeflon;            //테프론
	private int filmAliensbst;         //P이물
	private int filmPolutn;            //P오염
	private int filmAgglomt;           //F뭉침
	private int filmOverlap;           //필름겹침
	private int filmJinjae;         	//진접
	private int filmUnjinjeop;         //미진접
	private int filmUnattch;           //미부착
	private int filmHalfAttch;           //반미부착(반미착)
	private int filmMf;           		//MF
	
	private int filMwingDroop;          //날개처짐
	
	private int filmWing;           	//날개꺽임
	private int filmEtc;           		//필름부 - 기타
	private int etcSize;               //치수
	private int etcCutting;            //컷팅
	private int etcFilmPress;          //필름눌림
	private int etcFilmDepth;          //필름폭
	private int etcLayer;              //레이어
	private int etcEtc;                //기타
	
	private int etcWashboard;			//빨래판
	private int etcWhitetape;           //백색테이프
	private int etcPattem;              //결무늬
	private int etcStabbed;             //F찍힘
	private int etcHaze;                //아지랑이
	private int etcSurface;             //표면처리
	private int etcSwelling;            //돌기
	private int etcFeeding;             //피딩
	private int etcFilm;                //필름농
	private int etcSlash;               //F사선
	private int etcJinjeop;             //진접터짐
	private int etcCrack;               //들뜸
	private int etcCrease;              //P.P주름
	
	private int metalOxidation;			//M산화
	
	private int visionMetalMms;			//비전메탈MMS
	private int visionMetalPms;			//비전메탈PMS
	private int visionMetalFstab;		//비전메탈M찍힘
	private int visionMetalPstab;		//비전메탈P찍힘
	                  
	private int visionMetalAliensbst;	//비전메탈이물
	private int visionMetalBreak;    	//비전메탈(M)꺾임
	private int visionMetalPolutn;   	//비전메탈오염
	private int visionMetalOxidation;	//비전메탈M산화
	private int visionMetalGilt;     	//비전메탈도금박리
	
	private int visionEtcFeeding;  		//비전피딩
	private int visionFilmPfs;          //비전PFS
	private int visionFilmBreak;        //비전F꺽임
	private int visionFilmTornout;      //비전뜯김
	private int visionFilmSurfceBb;     //비전표면
	private int visionFilmEdgeBb;       //비전엣지
	
	private int visionFilmTeflon;           //비전테프론
	private int visionFilmAliensbst;        //비전이물
//	private int visionF          			//비전오염
//	private int visionF            			//비전뭉침
	private int visionFilmOverlap;			//비전필름겹침
	private int visionFilmJinjae;			//비전진접
	
	private int visionFilmUnattch;			//비전미부착
	private int visionFilmHalfAttch;		//비전반미부착
	private int visionFilMwingDroop;		//비전날개처짐
	private int visionEtcSize;				//비전치수
//	private int visionF;					//비전눌림
	private int visionEtcLayer;				//비전레이어
	private int visionFilmEtc;				//비전기타
		
	private String inspctCharger;
	private String inspctChargerNm;
	private String faultyRegDate;      //불량등록일
	private String regId;              //등록자
	private Date regDate;            //등록일
	private String updId;              //수정자
	private Date updDate;            //수정일
	
	//qmsc0090 불량집계시 사용
	private String appearInspctDate;	//검사일
	private String goodsCd;				//제품코드
	private String goodsNm;				//제품명
	private int outputCnt;              //총 검사수량
	private int appearOutputCnt;        //총 양품수량
	private int faultSum;               //총 불량수량
	private float faultPercent;         //총 불량률
	private int edgeFaultyCnt;          //총 엣지불량수량
	private int totalAppearFaultyCnt;	//총 외관 불량수량
	private String chooseDateFrom;
	private String chooseDate;
	
	//qmsc 0090 유형별 불량집계
	private int totalOutputCnt;			//총 생산수량
	private int totalEdgeFaultyCnt;		//총 엣지 불량수량
	private float edgeFaultyPercent;		//엣지불량%
	private int sumSurfaceFaulty;		//총 외관불량수량
	private float surfaceFaultyPercent;	//외관불량수량%
	private int sumMetal;               //메탈불량총합
	private float metalPercent;           //메탈불량%
	private int sumFillm;               //필름불량총합
	private float filmPercent;            //필름불량%
	private int sumEtc;                 //기타불량총합
	private float etcPercent;             //기타불량%
	
	//코드화
	private String majorCd;
	private String minorCd;
	private String faultyCnt;
	private String seq;
	private String inspctChargr;
	private String inspctChargrNm;
	private String dayNightCd;
	private String dayNightNm;
	private String workOrdDate;
	private String codeList;
	private String processList;
	
	private double quarter1;
	private double quarter2;
	private double quarter3;
	private double month1;
	private double month2;
	private double month3;
	private double week1;
	private double week2;
	private double week3;
	private double day1;
	private double day2;
	private double day3;
	private double day4;
	private double day5;
	private double day6;
	private double day7;
	private double day8;
	private double day9;
	private double day10;
	private double day11;
	private double day12;
	private double day13;
	private double day14;
	
	private String headerGubun;
	private String headerType;
	private String headerDate;
	private String headerMonth;
	private String headerDay;
	private String headerIsoWeek;
	private String headerQuarter;
	
	private String model;
	private String qutyCd;
	private String qutyNm;
	private String itemNm;
	private int no;
	private String chooseDateTo;
	private String headerDayOfWeek;	
	
	private String filmSurfaceAgglomeration; // 필름 표면뭉침
	private String visionFilmSurfaceAgglomeration; // 비전 필름 표면뭉침
	private String filmPpollution; //필름 P오염
	private String visionFilmPpollution;  //비전필름 P오염
	private String filmWingAgglomeration; //필름 날개뭉침
	private String visionFilmWingAgglomeration; //비전필름 날개뭉침
	private String filmMFS;  //필름 MFS
	private String visionFilmMFS; //비전필름 MFS
	private String filmWingPressed; //필름 날개눌림
	private String visionFilmWingPressed;  // 비전필름 날개눌림
	private String filmSurfacePressed; // 필름 표면눌림
	private String visionFilmSurfacePressed;//비전필름 표면눌림
	private String filmEdgePressed; //필름엣지눌림
	private String visionFilmEdgePressed;//비전필름엣지눌림
	
	private int edgeFaultySum001;
	private int edgeFaultySum002;
	private int totalEdgeFaultySum;
	private int appearFaultySum001;
	private int appearFaultySum002;
	private int appearFaultySum003;
	private int appearFaultySum004;
	private int totalAppearSum1;
	private int totalAppearSum2;
	
	private String visionInspCnt;
	private String factoryCode;

	private int ordGubun; 		//주야구분
	private int matrlFaultyCnt;	//총 메탈부불량수량
	private int filmFaultyCnt;  //총 필름부불량수량
	private int	reInspCnt;		//총 재검불량수량
	
	private String note1;
	private String note2;
	
}