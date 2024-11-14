package mes.domain.po;

import java.util.Date;
import lombok.Data;

@Data
public class EquipCondCombineAdmVo {

	private String menuAuth;				//메뉴권한
	private String equipCondSeq;			//제조조건
	private String equipCd;
	private String equipNm;
	private String goodsCd;
	private String goodsNm;
	private String workOrdNo;
	private String ordLotNo;
	
	/*-- 온도조건 시작 -------------------------------------------------------------------------*/
	private String A_tempaturCondCd;       //온도조건코드
	private String A_tempaturCondNm;       //온도조건명
	private String A_warmupCond;           //예열조건
	private String A_warmupAlwncePlus;     //예열공차최대값
	private String A_warmupAlwnceMinus;    //예열공차최저값
	
	//2020-09-28 수정
	private String A_fitup1UpCond;				//가접1 상 조건
	private String A_fitup1UpAlwncePlus;          //가접1 상 공차최대값
	private String A_fitup1UpAlwnceMinus;         //가접1 상 공차최저값
	private String A_fitup1DownCond;              //가접1 하 조건
	private String A_fitup1DownAlwncePlus;        //가접1 하 공차최대값
	private String A_fitup1DownAlwnceMinus;       //가접1 하 공차최저값
	private String A_fitup2UpleftCond;            //가접2 상좌 조건
	private String A_fitup2UpleftAlwncePlus;      //가접2 상좌 공차최대값
	private String A_fitup2UpleftAlwnceMinus;     //가접2 상좌 공차최저값
	private String A_fitup2DownleftCond;          //가접2 하좌 조건
	private String A_fitup2DownleftAlwncePlus;    //가접2 하좌 공차최대값
	private String A_fitup2DownleftAlwnceMinus;   //가접2 하좌 공차최저값
	private String A_fitup2UprightCond;           //가접2 상우 조건
	private String A_fitup2UprightAlwncePlus;     //가접2 상우 공차최대값
	private String A_fitup2UprightAlwnceMinus;    //가접2 상우 공차최저값
	private String A_fitup2DownrightCond;         //가접2 하우 조건
	private String A_fitup2DownrightAlwncePlus;   //가접2 하우 공차최대값
	private String A_fitup2DownrightAlwnceMinus;  //가접2 하우 공차최저값
	private String A_rollheatUpCond;              //롤히트 상 조건
	private String A_rollheatUpAlwncePlus;        //롤히트 상 공차최대값
	private String A_rollheatUpAlwnceMinus;       //롤히트 상 공차최저값
	private String A_rollheatDownCond;            //롤히트 하 조건
	private String A_rollheatDownAlwncePlus;      //롤히트 하 공차최대값
	private String A_rollheatDownAlwnceMinus;     //롤히트 하 공차최저값
	private String A_firstUpleftCond;             //1차 상좌 조건
	private String A_firstUpleftAlwncePlus;       //1차 상좌 공차최대값
	private String A_firstUpleftAlwnceMinus;      //1차 상좌 공차최저값
	private String A_firstDownleftCond;           //1차 하좌 조건
	private String A_firstDownleftAlwncePlus;     //1차 하좌 공차최대값
	private String A_firstDownleftAlwnceMinus;    //1차 하좌 공차최저값
	private String A_firstUprightCond;            //1차 상우 조건
	private String A_firstUprightAlwncePlus;      //1차 상우 공차최대값
	private String A_firstUprightAlwnceMinus;     //1차 상우 공차최저값
	private String A_firstDownrightCond;          //1차 하우 조건
	private String A_firstDownrightAlwncePlus;    //1차 하우 공차최대값
	private String A_firstDownrightAlwnceMinus;   //1차 하우 공차최저값
	
	private String A_push1UpCond;                 //1차 푸셔상 조건
	private String A_push1UpAlwncePlus;           //1차 푸셔상 공차최대값
	private String A_push1UpAlwnceMinus;          //1차 푸셔상 공차최저값
	private String A_push1DownCond;               //1차 푸셔하 조건
	private String A_push1DownAlwncePlus;         //1차 푸셔하 공차최대값
	private String A_push1DownAlwnceMinus;        //1차 푸셔하 공차최저값
	
	private String A_secondUpleftCond;            //2차 상좌 조건
	private String A_secondUpleftAlwncePlus;      //2차 상좌 공차최대값
	private String A_secondUpleftAlwnceMinus;     //2차 상좌 공차최저값
	private String A_secondDownleftCond;          //2차 하좌 조건
	private String A_secondDownleftAlwncePlus;    //2차 하좌 공차최대값
	private String A_secondDownleftAlwnceMinus;   //2차 하좌 공차최저값
	private String A_secondUprightCond;           //2차 상우 조건
	private String A_secondUprightAlwncePlus;     //2차 상우 공차최대값
	private String A_secondUprightAlwnceMinus;    //2차 상우 공차최저값
	private String A_secondDownrightCond;         //2차 하우 조건
	private String A_secondDownrightAlwncePlus;   //2차 하우 공차최대값
	private String A_secondDownrightAlwnceMinus;  //2차 하우 공차최저값
	private String A_thirdUpleftCond;             //3차 상좌 조건
	private String A_thirdUpleftAlwncePlus;       //3차 상좌 공차최대값
	private String A_thirdUpleftAlwnceMinus;      //3차 상좌 공차최저값
	private String A_thirdDownleftCond;           //3차 하좌 조건
	private String A_thirdDownleftAlwncePlus;     //3차 하좌 공차최대값
	private String A_thirdDownleftAlwnceMinus;    //3차 하좌 공차최저값
	private String A_thirdUprightCond;            //3차 상우 조건
	private String A_thirdUprightAlwncePlus;      //3차 상우 공차최대값
	private String A_thirdUprightAlwnceMinus;     //3차 상우 공차최저값
	private String A_thirdDownrightCond;          //3차 하우 조건
	private String A_thirdDownrightAlwncePlus;    //3차 하우 공차최대값
	private String A_thirdDownrightAlwnceMinus;   //3차 하우 공차최저값
	private String A_jinjeop1UpCond;              //진접1 상 조건
	private String A_jinjeop1UpAlwncePlus;        //진접1 상 공차최대값
	private String A_jinjeop1UpAlwnceMinus;       //진접1 상 공차최저값
	private String A_jinjeop1DownCond;            //진접1 하 조건
	private String A_jinjeop1DownAlwncePlus;      //진접1 하 공차최대값
	private String A_jinjeop1DownAlwnceMinus;     //진접1 하 공차최저값
	private String A_jinjeop2UpCond;              //진접2 상 조건
	private String A_jinjeop2UpAlwncePlus;        //진접2 상 공차최대값
	private String A_jinjeop2UpAlwnceMinus;       //진접2 상 공차최저값
	private String A_jinjeop2DownCond;            //진접2 하 조건
	private String A_jinjeop2DownAlwncePlus;      //진접2 하 공차최대값
	private String A_jinjeop2DownAlwnceMinus;     //진접2 하 공차최저값



	//private String A_fitupCond;            //가접조건
	//private String A_fitupAlwncePlus;      //가접공차최대값
	//private String A_fitupAlwnceMinus;     //가접공차최저값
	//private String A_fitup2Cond;           //가접2조건		- 2020. 7.31 추가
	//private String A_fitup2AlwncePlus;     //가접2공차최대값	- 2020. 7.31 추가
	//private String A_fitup2AlwnceMinus;    //가접2공차최저값	- 2020. 7.31추가
	//private String A_firstCond;            //1차조건
	//private String A_firstAlwncePlus;      //1차공차최대값
	//private String A_firstAlwnceMinus;     //1차공차최저값
	//private String A_secondCond;           //2차조건
	//private String A_secondAlwncePlus;     //2차공차최대값
	//private String A_secondAlwnceMinus;    //2차공차최저값
	//private String A_thirdCond;            //3차조건		- 2020. 9. 11 추가
	//private String A_thirdAlwncePlus;      //3차공차최대값	- 2020. 9. 11 추가
	//private String A_thirdAlwnceMinus;     //3차공차최저값	- 2020. 9. 11 추가
	//private String A_jinjeopCond;          //진접조건
	//private String A_jinjeopAlwncePlus;    //진접공차최대값
	//private String A_jinjeopAlwnceMinus;   //진접공차최저값
	//private String A_jinjeop2Cond;         //진접2조건		- 2020. 9. 11 추가
	//private String A_jinjeop2AlwncePlus;   //진접2공차최대값	- 2020. 9. 11 추가
	//private String A_jinjeop2AlwnceMinus;  //진접2공차최저값	- 2020. 9. 11 추가
	//private String A_rollheatCond;         //롤히트조건		- 2020. 9. 11 추가
	//private String A_rollheatAlwncePlus;   //롤히트공차최대값	- 2020. 9. 11 추가
	//private String A_rollheatAlwnceMinus;  //롤히트공차최저값	- 2020. 9. 11 추가
	//private String A_reformCond;           //리폼조건
	//private String A_reformAlwncePlus;     //리폼공차최대값
	//private String A_reformAlwnceMinus;    //리폼공차최저값
	private String A_useYnCd;              //사용여부
	private String A_regId;                //등록자
	private Date A_regDate;                //등록일
	private String A_updId;                //수정자
	private Date A_updDate;                //수정일
	/*-- 온도조건 끝 -------------------------------------------------------------------------*/
	
	
	
	/*-- 시간조건 시작 -------------------------------------------------------------------------*/
	private String B_timeCondCd;           //시간조건코드
	private String B_timeCondNm;           //시간조건명
	private String B_warmupCond;           //예열조건
	private String B_warmupAlwncePlus;     //예열공차최대값
	private String B_warmupAlwnceMinus;    //예열공차최저값
	private String B_fitupCond;            //가접조건
	private String B_fitupAlwncePlus;      //가접공차최대값
	private String B_fitupAlwnceMinus;     //가접공차최저값
	private String B_fitup2Cond;           //가접2조건		-	7.31 추가
	private String B_fitup2AlwncePlus;     //가접2공차최대값	-	7.31 추가
	private String B_fitup2AlwnceMinus;    //가접2공차최저값	- 	7.31추가	
	private String B_firstCond;            //1차조건
	private String B_firstAlwncePlus;      //1차공차최대값
	private String B_firstAlwnceMinus;     //1차공차최저값
	private String B_secondCond;           //2차조건
	private String B_secondAlwncePlus;     //2차공차최대값
	private String B_secondAlwnceMinus;    //2차공차최저값
	
	private String B_thirdCond;            //3차조건
	private String B_thirdAlwncePlus;      //3차공차최대값
	private String B_thirdAlwnceMinus;     //3차공차최저값
	
	private String B_jinjeopCond;          //진접조건
	private String B_jinjeopAlwncePlus;    //진접공차최대값
	private String B_jinjeopAlwnceMinus;   //진접공차최저값
	
	private String B_jinjeop2Cond;         //진접조건
	private String B_jinjeop2AlwncePlus;   //진접공차최대값
	private String B_jinjeop2AlwnceMinus;  //진접공차최저값
	private String B_push1Cond;            //1차푸셔조건
	private String B_push1AlwncePlus;      //1차푸셔공차최대값
	private String B_push1AlwnceMinus;     //1차푸셔공차최저값
	
	private String B_reformCond;           //리폼조건
	private String B_reformAlwncePlus;     //리폼공차최대값
	private String B_reformAlwnceMinus;    //리폼공차최저값
	
	private String B_coolCond;			   //냉각조건			- 10.15 추가
	private String B_coolAlwncePlus;       //냉각공차최대값	- 10.15 추가
	private String B_coolAlwnceMinus;		//냉각공차최저값	- 10.15 추가
	
	private String B_useYnCd;              //사용여부
	private String B_regId;                //등록자
	private Date B_regDate;                //등록일
	private String B_updId;                //수정자
	private Date B_updDate;                //수정일
	/*-- 시간조건 끝 -------------------------------------------------------------------------*/
	
	
	
	/*-- 압력조건 끝 -------------------------------------------------------------------------*/
	private String C_pressureCondCd;      //압력조건코드
	private String C_pressureCondNm;      //압력조건명
	private String C_warmupCond;          //예열조건
	private String C_warmupAlwncePlus;    //예열공차최대값
	private String C_warmupAlwnceMinus;   //예열공차최저값
	private String C_fitupCond;           //가접조건
	private String C_fitupAlwncePlus;     //가접공차최대값
	private String C_fitupAlwnceMinus;    //가접공차최저값
	
	//private String C_firstCond;         //1차조건
	//private String C_firstAlwncePlus;   //1차공차최대값
	//private String C_firstAlwnceMinus;  //1차공차최저값
	private String C_push1Cond;           //푸셔1차조건
	private String C_push1AlwncePlus;     //푸셔1차공차최대값
	private String C_push1AlwnceMinus;    //푸셔1차공차최저값.
	
	private String C_secondCond;          //2차조건
	private String C_secondAlwncePlus;    //2차공차최대값
	private String C_secondAlwnceMinus;   //2차공차최저값
	private String C_jinjeopCond;         //진접조건
	private String C_jinjeopAlwncePlus;   //진접공차최대값
	private String C_jinjeopAlwnceMinus;  //진접공차최저값
	
	private String C_jinjeop2Cond;         //진접조건
	private String C_jinjeop2AlwncePlus;   //진접공차최대값
	private String C_jinjeop2AlwnceMinus;  //진접공차최저값
	
	private String C_reformCond;          //리폼조건
	private String C_reformAlwncePlus;    //리폼공차최대값
	private String C_reformAlwnceMinus;   //리폼공차최저값
	//private String C_coolCond;			//냉각 조건			-	7.31 추가		- 10. 15 삭제
	//private String C_coolAlwncePlus;	//냉각공차 최대값		-	7.31 추가		- 10. 15 삭제
	//private String C_coolAlwnceMinus;	//냉각공차 최저값		- 	7.31 추가		- 10. 15 삭제
	private String C_useYnCd;             //사용여부
	private String C_regId;               //등록자
	private Date C_regDate;               //등록일
	private String C_updId;               //수정자
	private Date C_updDate;               //수정일
	/*-- 압력조건 끝 -------------------------------------------------------------------------*/
	
	
	
	/*-- 치수조건 시작 -------------------------------------------------------------------------*/
	private String D_sizeCondCd;	              //치수조건코드
	private String D_sizeCondNm;	              //치수조건명
	private String D_wpLeftCond;	              //Welding Park (좌) 조건
	private String D_wpLeftAlwncePlus;	          //Welding Park (좌) 공차최대값
	private String D_wpLeftAlwnceMinus;	          //Welding Park (좌) 공차최저값
	private String D_wpRightCond;	              //Welding Park (우) 조건
	private String D_wpRightAlwncePlus;	          //Welding Park (우) 공차최대값
	private String D_wpRightAlwnceMinus;	      //Welding Park (우) 공차최저값
	private String D_pitchLeftCond;	              //Pitch (좌) 조건
	private String D_pitchLeftAlwncePlus;	      //Pitch (좌) 공차최대값
	private String D_pitchLeftAlwnceMinus;	      //Pitch (좌) 공차최저값
	private String D_pitchRightCond;	          //Pitch (우) 조건
	private String D_pitchRightAlwncePlus;	      //Pitch (우) 공차최대값
	private String D_pitchRightAlwnceMinus;	      //Pitch (우)공차최저값
	private String D_ppfWingLeftCond;	          //P.P Film  날개 (좌) 조건
	private String D_ppfWingLeftAlwncePlus;	      //P.P Film  날개 (좌) 공차최대값
	private String D_ppfWingLeftAlwnceMinus;	  //P.P Film  날개 (좌) 공차최저값
	private String D_ppfWingRightCond;	          //P.P Film  날개 (우) 조건
	private String D_ppfWingRightAlwncePlus;	  //P.P Film  날개 (우) 공차최대값
	private String D_ppfWingRightAlwnceMinus;	  //P.P Film  날개 (우) 공차최저값
	private String D_ppfDepthLeftCond;	          //P.P Film  폭 (좌) 조건
	private String D_ppfDepthLeftAlwncePlus;	  //P.P Film  폭 (좌) 공차최대값
	private String D_ppfDepthLeftAlwnceMinus;	  //P.P Film  폭 (좌) 공차최저값
	private String D_ppfDepthRightCond;	          //P.P Film  폭 (우) 조건
	private String D_ppfDepthRightAlwncePlus;	  //P.P Film  폭 (우) 공차최대값
	private String D_ppfDepthRightAlwnceMinus;	  //P.P Film  폭 (우) 공차최저값
	private String D_filmCond;	                  //필름 조건
	private String D_filmAlwncePlus;	          //필름 공차최대값
	private String D_filmAlwnceMinus;	          //필름 공차최저값
	private String D_metalDepthCond;	          //Metal(폭) 조건
	private String D_metalDepthAlwncePlus;	      //Metal(폭) 공차최대값
	private String D_metalDepthAlwnceMinus;	      //Metal(폭) 공차최저값
	private String D_metalThicknessCond;	      //Metal(두께) 조건
	private String D_metalThicknessAlwncePlus;	  //Metal(두께) 공차최대값
	private String D_metalThicknessAlwnceMinus;	  //Metal(두께) 공차최저값
	private String D_thCenterCond;	              //총두께(Center) 조건
	private String D_thCenterAlwncePlus;	      //총두께(Center) 공차최대값
	private String D_thCenterAlwnceMinus;	      //총두께(Center) 공차최저값
	private String D_thEdgeCond;	              //총두께(Edge) 조건
	private String D_thEdgeAlwncePlus;	          //총두께(Edge) 공차최대값
	private String D_thEdgeAlwnceMinus;	          //총두께(Edge) 공차최저값
	private String D_burrCond;	                  //BURR 조건
	private String D_burrAlwncePlus;	          //BURR 공차최대값
	private String D_burrAlwnceMinus;	          //BURR 공차최저값
	private String D_useYnCd;	                  //사용여부
	private String D_regId;	                      //등록자
	private Date D_regDate;	                      //등록일
	private String D_updId;	                      //수정자
	private Date D_updDate;	                      //수정일
	/*-- 치수조건 끝 -------------------------------------------------------------------------*/
	

}