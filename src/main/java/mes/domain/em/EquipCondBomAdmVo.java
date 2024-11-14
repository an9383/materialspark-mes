package mes.domain.em;

import java.util.Date;
import lombok.Data;

@Data
public class EquipCondBomAdmVo {

	private String menuAuth;             //메뉴권한	
	//온도, 압력
	private String equipCondSeq;         //설비코드 Seq
	private String goodsCd;				
	private String goodsNm;				
	private String warmupCond;           //예열조건
	private String warmupAlwncePlus;     //예열공차최대값
	private String warmupAlwnceMinus;    //예열공차최저값
	private String fitupCond;            //가접조건
	private String fitupAlwncePlus;      //가접공차최대값
	private String fitupAlwnceMinus;     //가접공차최저값
	private String fitup2Cond;           //가접조건		- 7.31 추가
	private String fitup2AlwncePlus;     //가접공차최대값	- 7.31 추가
	private String fitup2AlwnceMinus;    //가접공차최저값	- 7.31 추가
	private String firstCond;            //1차조건
	private String firstAlwncePlus;      //1차공차최대값
	private String firstAlwnceMinus;     //1차공차최저값
	private String secondCond;           //2차조건
	private String secondAlwncePlus;     //2차공차최대값
	private String secondAlwnceMinus;    //2차공차최저값
	private String thirdCond;            //3차조건		- 2020. 9. 11 추가
	private String thirdAlwncePlus;      //3차공차최대값	- 2020. 9. 11 추가
	private String thirdAlwnceMinus;     //3차공차최저값	- 2020. 9. 11 추가
	private String jinjeopCond;          //진접조건
	private String jinjeopAlwncePlus;    //진접공차최대값
	private String jinjeopAlwnceMinus;   //진접공차최저값
	
	private String push1Cond;            //1차조건   
	private String push1AlwncePlus;      //1차공차최대값
	private String push1AlwnceMinus;     //1차공차최저값
	
	private String jinjeop2Cond;         //진접2조건		- 2020. 9. 11 추가
	private String jinjeop2AlwncePlus;   //진접2공차최대값	- 2020. 9. 11 추가
	private String jinjeop2AlwnceMinus;  //진접2공차최저값	- 2020. 9. 11 추가
	private String rollheatCond;         //롤히트조건		- 2020. 9. 11 추가
	private String rollheatAlwncePlus;   //롤히트공차최대값	- 2020. 9. 11 추가
	private String rollheatAlwnceMinus;  //롤히트공차최저값	- 2020. 9. 11 추가
	private String reformCond;           //리폼조건
	private String reformAlwncePlus;     //리폼공차최대값
	private String reformAlwnceMinus;    //리폼공차최저값
	private String coolCond;			 //리폼조건   		- 7.31 추가
	private String coolAlwncePlus;		 //리폼공차최대값	- 7.31 추가
	private String coolAlwnceMinus;		 //리폼공차최저값	- 7.31 추가
	
	//치수
	private String wpLeftCond;                    //Welding Park (좌) 조건
	private String wpLeftAlwncePlus;              //Welding Park (좌) 공차최대값
	private String wpLeftAlwnceMinus;             //Welding Park (좌) 공차최저값
	private String wpRightCond;                   //Welding Park (우) 조건
	private String wpRightAlwncePlus;             //Welding Park (우) 공차최대값
	private String wpRightAlwnceMinus;            //Welding Park (우) 공차최저값
	private String pitchLeftCond;                 //Pitch (좌) 조건
	private String pitchLeftAlwncePlus;           //Pitch (좌) 공차최대값
	private String pitchLeftAlwnceMinus;          //Pitch (좌) 공차최저값
	private String pitchRightCond;                //Pitch (우) 조건
	private String pitchRightAlwncePlus;          //Pitch (우) 공차최대값
	private String pitchRightAlwnceMinus;         //Pitch (우)공차최저값
	private String ppfWingLeftCond;               //P.P Film  날개 (좌) 조건
	private String ppfWingLeftAlwncePlus;         //P.P Film  날개 (좌) 공차최대값
	private String ppfWingLeftAlwnceMinus;        //P.P Film  날개 (좌) 공차최저값
	private String ppfWingRightCond;              //P.P Film  날개 (우) 조건
	private String ppfWingRightAlwncePlus;        //P.P Film  날개 (우) 공차최대값
	private String ppfWingRightAlwnceMinus;       //P.P Film  날개 (우) 공차최저값
	private String ppfDepthLeftCond;              //P.P Film  폭 (좌) 조건
	private String ppfDepthLeftAlwncePlus;        //P.P Film  폭 (좌) 공차최대값
	private String ppfDepthLeftAlwnceMinus;       //P.P Film  폭 (좌) 공차최저값
	private String ppfDepthRightCond;             //P.P Film  폭 (우) 조건
	private String ppfDepthRightAlwncePlus;       //P.P Film  폭 (우) 공차최대값
	private String ppfDepthRightAlwnceMinus;      //P.P Film  폭 (우) 공차최저값
	private String filmCond;                      //필름 조건
	private String filmAlwncePlus;                //필름 공차최대값
	private String filmAlwnceMinus;               //필름 공차최저값
	private String metalDepthCond;                //Metal(폭) 조건
	private String metalDepthAlwncePlus;          //Metal(폭) 공차최대값
	private String metalDepthAlwnceMinus;         //Metal(폭) 공차최저값
	private String metalThicknessCond;            //Metal(두께) 조건
	private String metalThicknessAlwncePlus;      //Metal(두께) 공차최대값
	private String metalThicknessAlwnceMinus;     //Metal(두께) 공차최저값
	private String thCenterCond;                  //총두께(Center) 조건
	private String thCenterAlwncePlus;            //총두께(Center) 공차최대값
	private String thCenterAlwnceMinus;           //총두께(Center) 공차최저값
	private String thEdgeCond;                    //총두께(Edge) 조건
	private String thEdgeAlwncePlus;              //총두께(Edge) 공차최대값
	private String thEdgeAlwnceMinus;             //총두께(Edge) 공차최저값
	
	private String gapOfLayerCond;				  //레이어 간격 조건
	private String gapOfLayerPlus;                //레이어 간격 공차최대값
	private String gapOfLayerMinus;               //레이어 간격 공차최저값
	
	private String burrCond;                      //BURR 조건
	private String burrAlwncePlus;                //BURR 공차최대값
	private String burrAlwnceMinus;               //BURR 공차최저값

	private String regId;                //등록자
	private Date regDate;                //등록일
	private String updId;                //수정자
	private Date updDate;                //수정일
	
	private String workOrdNo;	//작지번호
	private String workOrdLotNo;//생산LotNo
	private String ordLotNo;	//생산전표번호
	private String lotNo;		//생산 주자재 LotNo
	private String stepCd;		//초중물 단계코드
	private String equipCd;		//설비코드
	
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
	
	

}