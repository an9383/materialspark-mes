package mes.domain.po;

import lombok.Data;

@Data
public class AgtBomVo {
	
	private String menuAuth;		//메뉴권한
	
	private String id;
	private String ifWorkorderCd;
	private String ifLot;
	private String ifWorkStatusCd;
	private String ifGoodsCd;
	private String ifGoodsNm;
	private String ifEquipCd;
	private String ifEquipCondSeq;
	private String ifEqstatusCd;
	private String createdDateTime;
	private String ifGaHeatTime;
	private String ifGaPressTime;
	private String if1stmtHeatTime;
	private String if1stmtPushTime;
	private String ifJinTime;
	private String ifJin2Time;
	private String if2ndmtHeatTime;
	private String if2ndmtPushTime;
	private String ifCoolTime;
	private String ifReformTime;
	private String ifSuTime;
	private String if3rdmtPushTime;
	private String If3rdmtHeatTime;
	
	private String ifPressure1ch;	//1차푸셔압력
	private String ifPressure2ch;	//진접1압력
	private String ifPressure3ch;	//진접2압력
	
	private String if1stMetalUL;
	private String if1stMetalUR;
	private String if1stMetalDL;
	private String if1stMetalDR;
	private String if1stJinjubU;
	private String if1stJinjubD;
	private String if2ndMetalUL;
	private String if2ndMetalUR;
	private String if2ndMetalDL;
	private String if2ndMetalDR;
	private String if1stMetalpushU;
	private String if1stMetalpushD;
	private String if3rdMetalUL;
	private String if3rdMetalUR;
	private String if3rdMetalDL;
	private String if3rdMetalDR;
	private String if2ndJinjubU;
	private String if2ndJinjubD;
	
	private String headlengthLeft;
	private String metallengthLeft;
	private String metalwidthUp;
	private String winglengthLeft;
	private String headlengthRight;
	
	private String metallengthRight;
	private String metalwidthDown;
	private String filmtotallengthDown;
	private String winglengthRight;
	private String filmdolgiLeftupHeight;
	private String filmdolgiLeftupWidth;
	private String filmdolgiLeftdownHeight;
	private String filmdolgiLeftdownWidth;
	private String filmdolgiRightupHeight;
	private String filmdolgiRightupWidth;
	private String filmdolgiRightdownHeight;
	private String filmdolgiRightdownWidth;
	private String filmtotallengthUp;
	private String filmAlwnce;			//(필름상 + 필름하)/2 = 필름 폭
	private String metalDepthAlwnce;	//(메탈폭상 + 메탈폭하)/2 = 메탈 폭
	
	private String filmwidthLeft;		//P.P Film 폭
	private String filmwidthRight;		//P.P Film 폭
	private String filmwidthLeftInside;	//P.P Film 폭 내측
	private String filmwidthRightInside;//P.P Film 폭 내측
	
	private String chooseDate;
	private String equipNm;
	private String equipCondSeq;
	private String goodsNm;
	
	private int start;
	private int length;
	private int totalCount;	
	private String searchVal;
	private String ordDir;
	private String ordColumn;
	private String searchAll;
	private String excelDownAll;
	
	private String factoryCode;
	private String workOrdNo;
	private String ordLotNo;
	private String equipCd;
	//private String equipNm;
	private String goodsCd;
	//private String goodsNm;
	//private String equipCondSeq;
	private String daqDate;
	private String regDate;
	
	private String prssData1;
	private String prssData2;
	private String prssData3;
	private String prssData4;
	private String prssData5;
	private String prssData6;
	private String prssData7;
	private String prssData8;
	private String prssData9;
	private String prssData10;
	
	private String tempData1;
	private String tempData2;
	private String tempData3;
	private String tempData4;
	private String tempData5;
	private String tempData6;
	private String tempData7;
	private String tempData8;
	private String tempData9;
	private String tempData10;
	private String tempData11;
	private String tempData12;
	private String tempData13;
	private String tempData14;
	private String tempData15;
	private String tempData16;
	private String tempData17;
	private String tempData18;
	private String tempData19;
	private String tempData20;
	private String tempData21;
	private String tempData22;
	private String tempData23;
	private String tempData24;
	private String tempData25;
	private String tempData26;
	private String tempData27;
	private String tempData28;
	private String tempData29;
	private String tempData30;

	private String timeData1;
	private String timeData2;
	private String timeData3;
	private String timeData4;
	private String timeData5;
	private String timeData6;
	private String timeData7;
	private String timeData8;
	private String timeData9;
	private String timeData10;
	private String timeData11;
	private String timeData12;
	private String timeData13;
	private String timeData14;
	private String timeData15;
	private String timeData16;
	private String timeData17;
	private String timeData18;
	private String timeData19;
	private String timeData20;
	private String timeData21;
	private String timeData22;
	private String timeData23;
	private String timeData24;
	private String timeData25;
	private String timeData26;
	private String timeData27;
	private String timeData28;
	private String timeData29;
	private String timeData30;
	private String timeData31;
	private String timeData32;
	private String timeData33;
	private String timeData34;
	private String timeData35;
	private String timeData36;
	private String timeData37;
	private String timeData38;
	private String timeData39;
	private String timeData40;
	
	private String visionData1;
	private String visionData2;
	private String visionData3;
	private String visionData4;
	private String visionData5;
	private String visionData6;
	private String visionData7;
	private String visionData8;
	private String visionData9;
	private String visionData10;
	private String visionData11;
	private String visionData12;
	private String visionData13;
	private String visionData14;
	private String visionData15;
	private String visionData16;
	private String visionData17;
	private String visionData18;
	private String visionData19;
	private String visionData20;
	private String visionData21;
	private String visionData22;
	private String visionData23;
	private String visionData24;
	private String visionData25;
	private String visionData26;
	private String visionData27;
	private String visionData28;
	private String visionData29;
	private String visionData30;
	private String visionData31;
	private String visionData32;
	private String visionData33;
	private String visionData34;
	private String visionData35;
	private String visionData36;
	private String visionData37;
	private String visionData38;
	private String visionData39;
	private String visionData40;
	private String visionData41;
	private String visionData42;
	private String visionData43;
	private String visionData44;
	private String visionData45;
	private String visionData46;
	private String visionData47;
	private String visionData48;
	private String visionData49;
	private String visionData50;
	private String visionData51;
	private String visionData52;
	private String visionData53;
	private String visionData54;
	private String visionData55;
	private String visionData56;
	private String visionData57;
	private String visionData58;
	private String visionData59;
	private String visionData60;
	//private String visionData61;
	//private String visionData62;
	//private String visionData63;
	//private String visionData64;
	//private String visionData65;
	//private String visionData66;
	//private String visionData67;
	//private String visionData68;
	//private String visionData69;
	//private String visionData70;
	//private String visionData71;
	//private String visionData72;
	//private String visionData73;
	//private String visionData74;
	//private String visionData75;
	//private String visionData76;
	//private String visionData77;
	//private String visionData78;
	//private String visionData79;
	//private String visionData80;
	//private String visionData81;
	//private String visionData82;
	//private String visionData83;
	//private String visionData84;
	//private String visionData85;
	//private String visionData86;
	//private String visionData87;
	//private String visionData88;
	//private String visionData89;
	//private String visionData90;
	//private String visionData91;
	//private String visionData92;
	//private String visionData93;
	//private String visionData94;
	//private String visionData95;
	//private String visionData96;
	//private String visionData97;
	//private String visionData98;
	//private String visionData99;
	private String visionData100;


}