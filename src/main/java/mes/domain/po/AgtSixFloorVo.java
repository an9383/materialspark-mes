package mes.domain.po;

import lombok.Data;

@Data
public class AgtSixFloorVo {
	
	//온도 수집 정보
	private String upTabHeat;
	private String downTabHeat;	
	private String upRollHeat;
	private String downRollHeat;	
	private String upFilmJoinTop;
	private String upFilmJoinBottom;	
	private String downFilmJoinTop;
	private String downFilmJoinBottom;	
	private String downTabHeatKeep;
	private String fup1stMTsid;	
	private String fup1stMTmid;
	private String fdown1stMTsid;	
	private String fdown1stMTmid;
	private String fup1stMTpush;	
	private String fdown1stMTpush;
	private String bup1stMTsid;	
	private String bup1stMTmid;
	private String bdown1stMTsid;	
	private String bdown1stMTmid;
	private String bup1stPush;	
	private String bdown1stPush;
	private String fupFilmFuse;	
	private String fdownFilmFuse;
	private String bupFilmFuse;	
	private String bdownFilmFuse;
	private String fup2ndMTsid;	
	private String fup2ndMTmid;
	private String fdown2ndMTsid;	
	private String fdown2ndMTmid;
	private String bup2ndMTsid;	
	private String bup2ndMTmid;
	private String bdown2ndMTsid;	
	private String bdown2ndMTmid;
	private String fup3rdMTsid;	
	private String fup3rdMTmid;
	private String fdown3rdMTsid;	
	private String fdown3rdMTmid;
	private String bup3rdMTsid;	
	private String bup3rdMTmid;
	private String bdown3rdMTsid;	
	private String bdown3rdMTmid;
	private String fupFilmRfmCool;	
	private String fdownFilmRfmCool;
	private String bupFilmRfmCool;	
	private String bdownFilmRfmCool;
	//온도 수집 정보

	// twoNdMTwaittime TwoNdMTwaittime TWO_ND_M_TWAITTIME
	// twoNdMTwaittime TwoNdMTwaittime TWO_ND_M_TWAITTIME
	
	
	// oneStMTpushtime OneStMTpushtime ONE_ST_M_TPUSHTIME
	// oneStMTpushheattime OneStMTpushheattime ONE_ST_M_TPUSHHEATTIME
	
	//시간 수집 정보
	private String oneStMTwaittime;
	private String oneStMTheattime;
	private String oneStMTpushwaittime;	
	private String oneStMTpushheattime;
	private String twoNdMTwaittime;	
	private String twoNdMTheattime;
	private String twoNdMTpushwaittime;	
	private String twoNdMTpushheattime;
	
	private String threeRdMTwaittime;	
	private String threeRdMTheattime;
	private String threeRdMTpushwaittime;	
	private String threeRdMTpushheattime;
	
	private String filmFSH1operwaittime;	
	private String filmFSH1operheattime;
	private String filmRSH1operwaittime;	
	private String filmRSH1operheattime;
	//시간 수집 정보

	//치수정보
	/*private String wpLeft;
	private String wpRight;	
	private String pitchLeft;
	private String pitchRight;	
	private String ppfWingLeft;
	private String ppfWingRight;	
	private String ppfDepthLeft;
	private String ppfDepthRight;	
	private String film;
	private String metalDepth;	
	private String metalThickness;
	private String thCenter;	
	private String thEdge;
	private String burr;	
	private String gapOfLayer;
	private String wpCenter;	
	private String ppfDepthCenter;
	private String wpDeviation;	
	private String x1X2;
	private String x1X2Plus;	
	private String x1X2Minus;
	private String thEdgeRight;	
	private String bending;*/
	
	private String wpLeftAlwnce;
	private String wpRightAlwnce;	
	private String pitchLeftAlwnce;
	private String pitchRightAlwnce;	
	private String ppfWingLeftAlwnce;
	private String ppfWingRightAlwnce;	
	private String ppfDepthLeftAlwnce;
	private String ppfDepthRightAlwnce;
	private String filmAlwnce;
	private String metalDepthAlwnce;
	private String metalThicknessAlwnce;
	private String thCenterAlwnce;
	private String thEdgeAlwncePlus;
	private String thStepInput;
	private String thEdgeCnt;
	private String thEdgeResult;
	private String bulgeLeftupHeight;
	private String bulgeLeftdownHeight;
	private String bulgeRightupHeight;
	private String bulgeRightdownHeight;
	private String bulgeLeftupWidth;
	private String bulgeLeftdownWidth;
	private String bulgeRightupWidth;
	private String bulgeRightdownWidth;
	private String burrMetalAlwnce;
	private String burrRcutAlwnce;
	private String burrRedgeAlwnce;
	private String gapOfLayer;
	private String ppfDepthCenterAlwnce;
	private String wpCenterAlwnce;
	private String wpDeviationAlwnce;
	private String x1X2Alwnce;
	private String thEdgeRightAlwnce;
	private String bendingAlwnce;
	//치수정보
	
	
	
	//부수적인 정보
	private String menuAuth;		//메뉴권한
	
	private String workOrdNo;		//작업지시
	private String ordLotNo;		//생산전표번호
	private String stepCd;			//초,중,종물 단계
	private String equipCd;			//설비코드
	private String lotNo;			//자재 LotNo
	
	private int countStep001;	//작지 종료시 초,중물 등록 확인에 사용
	private int countStep002;	//작지 종료시 초,중물 등록 확인에 사용
	
	private String regId;
	private String regDate;
	private String updId;
	private String updDate;
	private String dltId;
	private String dltDate;
	private String ipAddress;

}