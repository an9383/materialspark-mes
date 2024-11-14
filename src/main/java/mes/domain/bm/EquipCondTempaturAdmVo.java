package mes.domain.bm;

import java.util.Date;
import lombok.Data;

@Data
public class EquipCondTempaturAdmVo {

	private String menuAuth;             //메뉴권한
	private String tempaturCondCd;       //온도조건코드
	private String tempaturCondNm;       //온도조건명
	private String warmupCond;           //예열조건
	private String warmupAlwncePlus;     //예열공차최대값
	private String warmupAlwnceMinus;    //예열공차최저값
	
	//2020-09-28 수정
	private String fitup1UpCond;				//가접1 상 조건
	private String fitup1UpAlwncePlus;          //가접1 상 공차최대값
	private String fitup1UpAlwnceMinus;         //가접1 상 공차최저값
	private String fitup1DownCond;              //가접1 하 조건
	private String fitup1DownAlwncePlus;        //가접1 하 공차최대값
	private String fitup1DownAlwnceMinus;       //가접1 하 공차최저값
	private String fitup2UpleftCond;            //가접2 상좌 조건
	private String fitup2UpleftAlwncePlus;      //가접2 상좌 공차최대값
	private String fitup2UpleftAlwnceMinus;     //가접2 상좌 공차최저값
	private String fitup2DownleftCond;          //가접2 하좌 조건
	private String fitup2DownleftAlwncePlus;    //가접2 하좌 공차최대값
	private String fitup2DownleftAlwnceMinus;   //가접2 하좌 공차최저값
	private String fitup2UprightCond;           //가접2 상우 조건
	private String fitup2UprightAlwncePlus;     //가접2 상우 공차최대값
	private String fitup2UprightAlwnceMinus;    //가접2 상우 공차최저값
	private String fitup2DownrightCond;         //가접2 하우 조건
	private String fitup2DownrightAlwncePlus;   //가접2 하우 공차최대값
	private String fitup2DownrightAlwnceMinus;  //가접2 하우 공차최저값
	private String rollheatUpCond;              //롤히트 상 조건
	private String rollheatUpAlwncePlus;        //롤히트 상 공차최대값
	private String rollheatUpAlwnceMinus;       //롤히트 상 공차최저값
	private String rollheatDownCond;            //롤히트 하 조건
	private String rollheatDownAlwncePlus;      //롤히트 하 공차최대값
	private String rollheatDownAlwnceMinus;     //롤히트 하 공차최저값
	private String firstUpleftCond;             //1차 상좌 조건
	private String firstUpleftAlwncePlus;       //1차 상좌 공차최대값
	private String firstUpleftAlwnceMinus;      //1차 상좌 공차최저값
	private String firstDownleftCond;           //1차 하좌 조건
	private String firstDownleftAlwncePlus;     //1차 하좌 공차최대값
	private String firstDownleftAlwnceMinus;    //1차 하좌 공차최저값
	private String firstUprightCond;            //1차 상우 조건
	private String firstUprightAlwncePlus;      //1차 상우 공차최대값
	private String firstUprightAlwnceMinus;     //1차 상우 공차최저값
	private String firstDownrightCond;          //1차 하우 조건
	private String firstDownrightAlwncePlus;    //1차 하우 공차최대값
	private String firstDownrightAlwnceMinus;   //1차 하우 공차최저값
	
	private String push1UpCond;                 //1차 푸셔상 조건
	private String push1UpAlwncePlus;           //1차 푸셔상 공차최대값
	private String push1UpAlwnceMinus;          //1차 푸셔상 공차최저값
	private String push1DownCond;               //1차 푸셔하 조건
	private String push1DownAlwncePlus;         //1차 푸셔하 공차최대값
	private String push1DownAlwnceMinus;        //1차 푸셔하 공차최저값
	
	private String secondUpleftCond;            //2차 상좌 조건
	private String secondUpleftAlwncePlus;      //2차 상좌 공차최대값
	private String secondUpleftAlwnceMinus;     //2차 상좌 공차최저값
	private String secondDownleftCond;          //2차 하좌 조건
	private String secondDownleftAlwncePlus;    //2차 하좌 공차최대값
	private String secondDownleftAlwnceMinus;   //2차 하좌 공차최저값
	private String secondUprightCond;           //2차 상우 조건
	private String secondUprightAlwncePlus;     //2차 상우 공차최대값
	private String secondUprightAlwnceMinus;    //2차 상우 공차최저값
	private String secondDownrightCond;         //2차 하우 조건
	private String secondDownrightAlwncePlus;   //2차 하우 공차최대값
	private String secondDownrightAlwnceMinus;  //2차 하우 공차최저값
	private String thirdUpleftCond;             //3차 상좌 조건
	private String thirdUpleftAlwncePlus;       //3차 상좌 공차최대값
	private String thirdUpleftAlwnceMinus;      //3차 상좌 공차최저값
	private String thirdDownleftCond;           //3차 하좌 조건
	private String thirdDownleftAlwncePlus;     //3차 하좌 공차최대값
	private String thirdDownleftAlwnceMinus;    //3차 하좌 공차최저값
	private String thirdUprightCond;            //3차 상우 조건
	private String thirdUprightAlwncePlus;      //3차 상우 공차최대값
	private String thirdUprightAlwnceMinus;     //3차 상우 공차최저값
	private String thirdDownrightCond;          //3차 하우 조건
	private String thirdDownrightAlwncePlus;    //3차 하우 공차최대값
	private String thirdDownrightAlwnceMinus;   //3차 하우 공차최저값
	private String jinjeop1UpCond;              //진접1 상 조건
	private String jinjeop1UpAlwncePlus;        //진접1 상 공차최대값
	private String jinjeop1UpAlwnceMinus;       //진접1 상 공차최저값
	private String jinjeop1DownCond;            //진접1 하 조건
	private String jinjeop1DownAlwncePlus;      //진접1 하 공차최대값
	private String jinjeop1DownAlwnceMinus;     //진접1 하 공차최저값
	private String jinjeop2UpCond;              //진접2 상 조건
	private String jinjeop2UpAlwncePlus;        //진접2 상 공차최대값
	private String jinjeop2UpAlwnceMinus;       //진접2 상 공차최저값
	private String jinjeop2DownCond;            //진접2 하 조건
	private String jinjeop2DownAlwncePlus;      //진접2 하 공차최대값
	private String jinjeop2DownAlwnceMinus;     //진접2 하 공차최저값



	//private String fitupCond;            //가접조건
	//private String fitupAlwncePlus;      //가접공차최대값
	//private String fitupAlwnceMinus;     //가접공차최저값
	//private String fitup2Cond;           //가접2조건		- 2020. 7.31 추가
	//private String fitup2AlwncePlus;     //가접2공차최대값	- 2020. 7.31 추가
	//private String fitup2AlwnceMinus;    //가접2공차최저값	- 2020. 7.31추가
	//private String firstCond;            //1차조건
	//private String firstAlwncePlus;      //1차공차최대값
	//private String firstAlwnceMinus;     //1차공차최저값
	//private String secondCond;           //2차조건
	//private String secondAlwncePlus;     //2차공차최대값
	//private String secondAlwnceMinus;    //2차공차최저값
	//private String thirdCond;            //3차조건		- 2020. 9. 11 추가
	//private String thirdAlwncePlus;      //3차공차최대값	- 2020. 9. 11 추가
	//private String thirdAlwnceMinus;     //3차공차최저값	- 2020. 9. 11 추가
	//private String jinjeopCond;          //진접조건
	//private String jinjeopAlwncePlus;    //진접공차최대값
	//private String jinjeopAlwnceMinus;   //진접공차최저값
	//private String jinjeop2Cond;         //진접2조건		- 2020. 9. 11 추가
	//private String jinjeop2AlwncePlus;   //진접2공차최대값	- 2020. 9. 11 추가
	//private String jinjeop2AlwnceMinus;  //진접2공차최저값	- 2020. 9. 11 추가
	//private String rollheatCond;         //롤히트조건		- 2020. 9. 11 추가
	//private String rollheatAlwncePlus;   //롤히트공차최대값	- 2020. 9. 11 추가
	//private String rollheatAlwnceMinus;  //롤히트공차최저값	- 2020. 9. 11 추가
	//private String reformCond;           //리폼조건
	//private String reformAlwncePlus;     //리폼공차최대값
	//private String reformAlwnceMinus;    //리폼공차최저값
	private String useYnCd;              //사용여부
	private String regId;                //등록자
	private Date regDate;                //등록일
	private String updId;                //수정자
	private Date updDate;                //수정일

}