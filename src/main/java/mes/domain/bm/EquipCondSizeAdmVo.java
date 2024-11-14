package mes.domain.bm;

import java.util.Date;
import lombok.Data;

@Data
public class EquipCondSizeAdmVo {		//설비조건치수관리 Table
	
	private String sizeCondCd;	                  //치수조건코드
	private String sizeCondNm;	                  //치수조건명
	private String wpLeftCond;	                  //Welding Park (좌) 조건
	private String wpLeftAlwncePlus;	          //Welding Park (좌) 공차최대값
	private String wpLeftAlwnceMinus;	          //Welding Park (좌) 공차최저값
	private String wpRightCond;	                  //Welding Park (우) 조건
	private String wpRightAlwncePlus;	          //Welding Park (우) 공차최대값
	private String wpRightAlwnceMinus;	          //Welding Park (우) 공차최저값
	private String pitchLeftCond;	              //Pitch (좌) 조건
	private String pitchLeftAlwncePlus;	          //Pitch (좌) 공차최대값
	private String pitchLeftAlwnceMinus;	      //Pitch (좌) 공차최저값
	private String pitchRightCond;	              //Pitch (우) 조건
	private String pitchRightAlwncePlus;	      //Pitch (우) 공차최대값
	private String pitchRightAlwnceMinus;	      //Pitch (우)공차최저값
	private String ppfWingLeftCond;	              //P.P Film  날개 (좌) 조건
	private String ppfWingLeftAlwncePlus;	      //P.P Film  날개 (좌) 공차최대값
	private String ppfWingLeftAlwnceMinus;	      //P.P Film  날개 (좌) 공차최저값
	private String ppfWingRightCond;	          //P.P Film  날개 (우) 조건
	private String ppfWingRightAlwncePlus;	      //P.P Film  날개 (우) 공차최대값
	private String ppfWingRightAlwnceMinus;	      //P.P Film  날개 (우) 공차최저값
	private String ppfDepthLeftCond;	          //P.P Film  폭 (좌) 조건
	private String ppfDepthLeftAlwncePlus;	      //P.P Film  폭 (좌) 공차최대값
	private String ppfDepthLeftAlwnceMinus;	      //P.P Film  폭 (좌) 공차최저값
	private String ppfDepthRightCond;	          //P.P Film  폭 (우) 조건
	private String ppfDepthRightAlwncePlus;	      //P.P Film  폭 (우) 공차최대값
	private String ppfDepthRightAlwnceMinus;	  //P.P Film  폭 (우) 공차최저값
	private String filmCond;	                  //필름 조건
	private String filmAlwncePlus;	              //필름 공차최대값
	private String filmAlwnceMinus;	              //필름 공차최저값
	private String metalDepthCond;	              //Metal(폭) 조건
	private String metalDepthAlwncePlus;	      //Metal(폭) 공차최대값
	private String metalDepthAlwnceMinus;	      //Metal(폭) 공차최저값
	private String metalThicknessCond;	          //Metal(두께) 조건
	private String metalThicknessAlwncePlus;	  //Metal(두께) 공차최대값
	private String metalThicknessAlwnceMinus;	  //Metal(두께) 공차최저값
	private String thCenterCond;	              //총두께(Center) 조건
	private String thCenterAlwncePlus;	          //총두께(Center) 공차최대값
	private String thCenterAlwnceMinus;	          //총두께(Center) 공차최저값
	private String thEdgeCond;	                  //총두께(Edge) 조건
	private String thEdgeAlwncePlus;	          //총두께(Edge) 공차최대값
	private String thEdgeAlwnceMinus;	          //총두께(Edge) 공차최저값
	private String burrCond;	                  //BURR 조건
	private String burrAlwncePlus;	              //BURR 공차최대값
	private String burrAlwnceMinus;	              //BURR 공차최저값
	private String gapOfLayerCond;					  //레이어 간격 조건
	private String gapOfLayerPlus;	              //레이어 간격 최저값
	private String gapOfLayerMinus;	              //레이어 간격 최저값	
	
	private String wpCenterCond;                 //Welding Park (중) 조건
	private String wpCenterAlwncePlus;           //Welding Park (중) 공차최대값
	private String wpCenterAlwnceMinus;          //Welding Park (중) 공차최저값
	private String ppfDepthCenterCond;           //P.P Film  폭 (중) 조건               
	private String ppfDepthCenterAlwncePlus;     //P.P Film  폭 (중) 공차최대값               
	private String ppfDepthCenterAlwnceMinus;    //P.P Film  폭 (중) 공차최저값               
	private String wpDeviationCond;              //Welding Park 좌우편차 조건               
	private String wpDeviationAlwncePlus;        //Welding Park 좌우편차 공차최대값               
	private String wpDeviationAlwnceMinus;       //Welding Park 좌우편차 공차최저값               
	private String x1X2Cond;                     //대각선 길이 편차               
	private String x1X2AlwncePlus;               //대각선 길이 공차최대값               
	private String x1X2AlwnceMinus;              //대각선 길이 공차최저값               
	private String thEdgeRightCond;              //총두께(Edge) 우 조건               
	private String thEdgeRightAlwncePlus;        //총두께(Edge) 우 공차최대값               
	private String thEdgeRightAlwnceMinus;       //총두께(Edge) 우 공차최저값               
	private String bendingCond;                  //밴딩 조건               
	private String bendingAlwncePlus;            //밴딩 공차최대값               
	private String bendingAlwnceMinus;           //밴딩 공차최저값               
	//여기까지 개수 고정 후 사용(65개) 추가되면 Vo 추가 후 Controller도 추가된 만큼 늘려주기(bmsc3050 경로 메인 부분)

	private String menuAuth;              		  //메뉴권한 (기초제조조건관리: bmsc3050, 제조조건관리: emsc3030)
	private String useYnCd;	                      //사용여부
	private String regId;	                      //등록자
	private Date regDate;	                      //등록일
	private String updId;	                      //수정자
	private Date updDate;	                      //수정일
	
	//제조조건관리에서 필요한 컬럼
	private String equipCondSeq;		//설비코드 Seq
	private String goodsCd;				
	private String goodsNm;
	private String pageGubun;			//페이지 구분자  (기초제조조건관리: bmsc3050, 제조조건관리: emsc3030)
	
}