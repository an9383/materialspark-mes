package mes.domain.qm;

import java.util.Date;

import lombok.Data;

@Data
public class StateVo {
	
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
//	private String equipCondSeq;        //
	private String workStatusCd;        //
	private String appearInspctDate;    //
//	private String wpLeftAlwnceMinus;	//
//	private String wpLeftCond;			//
//	private String wpLeftAlwncePlus	;	//
	private String stepCd;        		//
	private String listGubun;
	private String ngGubun;
	private String equipNm;
	
	//치수
	private String equipCondSeq;				//설비코드 Seq
	private String wpLeftCond;                  //Welding Park (좌) 조건
	private String wpLeftAlwncePlus;            //Welding Park (좌) 공차최대값
	private String wpLeftAlwnceMinus;           //Welding Park (좌) 공차최저값
	private String wpRightCond;                 //Welding Park (우) 조건
	private String wpRightAlwncePlus;           //Welding Park (우) 공차최대값
	private String wpRightAlwnceMinus;          //Welding Park (우) 공차최저값
	private String pitchLeftCond;               //Pitch (좌) 조건
	private String pitchLeftAlwncePlus;         //Pitch (좌) 공차최대값
	private String pitchLeftAlwnceMinus;        //Pitch (좌) 공차최저값
	private String pitchRightCond;              //Pitch (우) 조건
	private String pitchRightAlwncePlus;        //Pitch (우) 공차최대값
	private String pitchRightAlwnceMinus;       //Pitch (우)공차최저값
	private String ppfWingLeftCond;             //P.P Film  날개 (좌) 조건
	private String ppfWingLeftAlwncePlus;       //P.P Film  날개 (좌) 공차최대값
	private String ppfWingLeftAlwnceMinus;      //P.P Film  날개 (좌) 공차최저값
	private String ppfWingRightCond;            //P.P Film  날개 (우) 조건
	private String ppfWingRightAlwncePlus;      //P.P Film  날개 (우) 공차최대값
	private String ppfWingRightAlwnceMinus;     //P.P Film  날개 (우) 공차최저값
	private String ppfDepthLeftCond;            //P.P Film  폭 (좌) 조건
	private String ppfDepthLeftAlwncePlus;      //P.P Film  폭 (좌) 공차최대값
	private String ppfDepthLeftAlwnceMinus;     //P.P Film  폭 (좌) 공차최저값
	private String ppfDepthRightCond;           //P.P Film  폭 (우) 조건
	private String ppfDepthRightAlwncePlus;     //P.P Film  폭 (우) 공차최대값
	private String ppfDepthRightAlwnceMinus;    //P.P Film  폭 (우) 공차최저값
	private String filmCond;                    //필름 조건
	private String filmAlwncePlus;              //필름 공차최대값
	private String filmAlwnceMinus;             //필름 공차최저값
	private String metalDepthCond;              //Metal(폭) 조건
	private String metalDepthAlwncePlus;        //Metal(폭) 공차최대값
	private String metalDepthAlwnceMinus;       //Metal(폭) 공차최저값
	private String metalThicknessCond;          //Metal(두께) 조건
	private String metalThicknessAlwncePlus;    //Metal(두께) 공차최대값
	private String metalThicknessAlwnceMinus;   //Metal(두께) 공차최저값
	private String thCenterCond;                //총두께(Center) 조건
	private String thCenterAlwncePlus;          //총두께(Center) 공차최대값
	private String thCenterAlwnceMinus;         //총두께(Center) 공차최저값
	private String thEdgeCond;                  //총두께(Edge) 조건
	private String thEdgeAlwncePlus;            //총두께(Edge) 공차최대값
	private String thEdgeAlwnceMinus;           //총두께(Edge) 공차최저값
	private String gapOfLayerCond;				  //레이어 간격 조건
	private String gapOfLayerPlus;                //레이어 간격 공차최대값
	private String gapOfLayerMinus;               //레이어 간격 공차최저값
	private String burrCond;                    //BURR 조건
	private String burrAlwncePlus;              //BURR 공차최대값
	private String burrAlwnceMinus;             //BURR 공차최저값
	
	private String regId;                		//등록자
	private Date regDate;                		//등록일
	private String updId;                		//수정자
	private Date updDate;               		//수정일
	private String chooseDateFrom;
	private String chooseDateTo;
	
	//
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
//	private String thEdgeAlwncePlus;
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
	
	public  String[] statusErrorYn;
	
	private String thStepInput;
	private String thEdgeCnt;
	private String thEdgeResult;
	public Object getGatOfLayer() {
		// TODO Auto-generated method stub
		return null;
	}
	
	private String lineGubun;	

}