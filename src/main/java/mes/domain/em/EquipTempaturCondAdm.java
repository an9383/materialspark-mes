package mes.domain.em;

import java.util.Date;
import lombok.Data;

@Data
public class EquipTempaturCondAdm {

	//온도
	private String menuAuth;             		//메뉴권한	
	private String equipCondSeq;				//설비조건시퀀스
	private String goodsCd;
	private String goodsNm;
	private String lotNo;						//생산 주자재 LotNo
    private String warmupCond;                  //예열조건
    private String warmupAlwncePlus;            //예열공차최대값
    private String warmupAlwnceMinus;           //예열공차최저값
    private String fitup1UpCond;                //가접1 상 조건
    private String fitup1UpAlwncePlus;          //가접1 상 공차최대값
    private String fitup1UpAlwnceMinus;         //가접1 상 공차최저값
    private String fitup1DownCond;              //가접1 하 조건
    private String fitup1DownAlwncePlus;        //가접1 하 공차최대값
    private String fitup1DownAlwnceMinus;       //가접1 하 공차최저값
    
    private String push1UpCond;              	//푸셔1 상 조건
    private String push1UpAlwncePlus;        	//푸셔1 상 공차최대값
    private String push1UpAlwnceMinus;       	//푸셔1 상 공차최저값
    private String push1DownCond;              	//푸셔1 하 조건
    private String push1DownAlwncePlus;        	//푸셔1 하 공차최대값
    private String push1DownAlwnceMinus;       	//푸셔1 하 공차최저값
    
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
    private String regId;                       //등록자
    private Date regDate;                    	//등록일
    private String updId;                       //수정자
    private Date updDate;                     	//수정일
    
	private String workOrdNo;	//작지번호
	private String workOrdLotNo;//생산LotNo
	private String ordLotNo;	//생산전표번호
	private String stepCd;		//초중물 단계코드
	private String equipCd;		//설비코드
    
}   