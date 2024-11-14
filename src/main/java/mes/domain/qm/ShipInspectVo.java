package mes.domain.qm;

import java.util.Date;

import lombok.Data;

@Data
public class ShipInspectVo {
	
	private String workOrdNo;    	    //
	private String ordLotNo;     		//
	private String lotNo;	     		//
	private String gubun;	     		//
	private String equipCd;     		//
	private String goodsCd;       	 	//
	private String goodsNm;       	 	//
	private String qutyNm;       	 	//
	private String ordGubun;        	//
	private String ordDate;       	 	//
	private int idx;
	private String trayNo;
	private String trayNo1;
	private String trayNo2;
	private String matrlLotNo;
	private String filmLotNo;
	private String inspStatus;
	private String inspStatusNm;
	private String reInspStatus;
	private String reInspStatusNm;
	
	private String disStatus;
	private String disStatusNm;
	private String inspDate;
	private String faultyCnt;
	private String faultyTrayNo;
	private String dayNightCd;
	private String dayNightNm;
	private String majorCd;
	private String majorNm;
	private String minorCd;
	private String minorNm;
	private String faultyGubun;
	private String faultyGubunNm;
		
	private String regId;                		//등록자
	private Date regDate;                		//등록일
	private String updId;                		//수정자
	private String updDate;               		//수정일
	private String chooseDateFrom;
	private String chooseDateTo;	
	
	private String menuAuth;				// 메뉴권한
	private String lastWorkOrdNo;			// 전작지번호
	private String productDate;				// 생산날짜
	private String changeTrayNo;			// 트레이번호(기존에 있던 트레이 번호 수정)
	private int workOrdSeq;					// 작지순서
	private String matrlCd;					// 자재코드	
	private String lastMatrlLotNo;			// 전자재로트
	private String labelLotNo;				// 라벨로트
	private String labelLotNoSeq;			// 라벨로트시퀀스
	private String productStatus;			// 생산상태	
	private int productQty;					// 생산수량
	private int productAllQty;				// 전체 생산 수량
	private int productPartQty;				// 부분 생산 수량
	private String incorporationGubun;		// 혼입구분
	private String incorporationVisonGubun;	// 혼입비전구분	
	private String trayWorkerId;			// 작업자 아이디
	private String trayWorkerIdNm;			// 작업자 아이디
	private int turnNumber;					// 순번	
	private String factoryCode;
	private String arrayData;
	private String mixGubun;
	private String deleteCheck;
	private String deleteGubun;
	private String matrlGubunNm;
	private String gijongCd;
	private String gijongNm;
	private int deleteGoodsProsuctCheck;	
	private String trayNo3;
	private String trayNo4;
	private String trayNo5;
	private String trayNo6;
	private String inspChargr;
	private String inspChargrNm;
	private String shipInspIdx;
	private String nextGubun;
	private String departmentCd;
	
	private String packUnitNm;
	private String seq;
	private String inspDesc;
	private String sampleCnt;
	private String searchGubun;
	private String inspGubun;
	
	private String qutyCd;
	private String dealCorpCd;
	private String dealCorpNm;
	private String alnicuMatrlCd;
	private String surfaceTrtmtCd;
	private String surfaceTrtmtNm;
	private String dateCheck;
	private String equipNm;
	
	private String codeList;
	private String codeList2;
	private String inspProductQty;
	
	private String trayCnt;
	private String checkTrayNo;
	private String checkTrayCnt;
	private String goodTrayNo;
	private String goodTrayCnt;
	private String badTrayNo;
	private String badTrayCnt;
	private String testCnt;
	
	private String reInspRange; //재검범위
	private String reInspSystem; //재검방법
	private String lastFaultyGubun; //전 불량유형
	
	private String checkQty;
	private String checkLot;
	private String successLot;
	private String successQty;
	private String successPercent;
	private String faultyLot;
	private String faultyQty;	
	private String syryo;
	private String syryoFaultyPercent;
	private String faultyStatus;
	private String faultyStatusNm;
	private String workOrdLotNo;
	private String threeTrayWeight;
	private String trayWeightDate;
	private String threeTrayWeightCheck;
	private String resultValue;
	
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
	
	private String faultySum;
	
	private String productDateYyyy;
	private String productDateMm;
	private String productDateWw;
	
	
	private String[] fixedHeader;
	private String[] fixedColumn;


	

}