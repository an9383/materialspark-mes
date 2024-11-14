package mes.domain.po;

import java.util.Date;

import lombok.Data;

@Data
public class AgtVo {
	
	private String menuAuth;		//메뉴권한
	private String workOrdNo;		//작업지시
	private String ordLotNo;		//생산전표번호
	private String stepCd;			//초,중,종물 단계
	private String equipCd;			//설비코드
	private String lotNo;			//자재 LotNo
	private int countStep001;	//작지 종료시 초,중물 등록 확인에 사용
	private int countStep002;	//작지 종료시 초,중물 등록 확인에 사용
	private Date regDate;
	private String warmupCond;
	private String fitup1UpCond;
	private String fitup1DownCond;
	private String fitup2UpleftCond;
	private String fitup2DownleftCond;
	private String fitup2UprightCond;
	private String fitup2DownrightCond;
	private String rollheatUpCond;
	private String rollheatDownCond;
	private String firstUpleftCond;
	private String firstDownleftCond;
	private String firstUprightCond;
	private String firstDownrightCond;
	private String push1UpCond;
	private String push1DownCond;
	private String secondUpleftCond;
	private String secondDownleftCond;
	private String secondUprightCond;
	private String secondDownrightCond;
	private String thirdUpleftCond;
	private String thirdDownleftCond;
	private String thirdUprightCond;
	private String thirdDownrightCond;
	private String jinjeop1UpCond;
	private String jinjeop1DownCond;
	private String jinjeop2UpCond;
	private String jinjeop2DownCond;
	private String fitupCond;
	private String fitup2Cond;
	private String firstCond;
	private String secondCond;
	private String thirdCond;
	private String jinjeopCond;
	private String jinjeop2Cond;
	private String push1Cond;
	private String reformCond;
	private String coolCond;
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
	private String gapOfLayer;				  //레이어 간격
	
	private String ppfDepthCenterAlwnce;
	private String wpCenterAlwnce;
	private String wpDeviationAlwnce;
	private String x1X2Alwnce;
	private String thEdgeRightAlwnce;
	private String bendingAlwnce;

	
	private String regId;
	private String updId;
	private String updDate;
	private String dltId;
	private String dltDate;
	private String ipAddress;

}