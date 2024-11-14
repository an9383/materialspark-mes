package mes.domain.bm;

import java.util.Date;
import lombok.Data;

@Data
public class EquipCondTimeAdmVo {
	
	private String menuAuth;             //메뉴권한
	private String timeCondCd;           //시간조건코드
	private String timeCondNm;           //시간조건명
	private String warmupCond;           //예열조건
	private String warmupAlwncePlus;     //예열공차최대값
	private String warmupAlwnceMinus;    //예열공차최저값
	private String fitupCond;            //가접조건
	private String fitupAlwncePlus;      //가접공차최대값
	private String fitupAlwnceMinus;     //가접공차최저값
	private String fitup2Cond;           //가접2조건		-	7.31 추가
	private String fitup2AlwncePlus;     //가접2공차최대값	-	7.31 추가
	private String fitup2AlwnceMinus;    //가접2공차최저값	- 	7.31추가	
	private String firstCond;            //1차조건
	private String firstAlwncePlus;      //1차공차최대값
	private String firstAlwnceMinus;     //1차공차최저값
	private String secondCond;           //2차조건
	private String secondAlwncePlus;     //2차공차최대값
	private String secondAlwnceMinus;    //2차공차최저값
	
	private String thirdCond;            //3차조건
	private String thirdAlwncePlus;      //3차공차최대값
	private String thirdAlwnceMinus;     //3차공차최저값
	
	private String jinjeopCond;          //진접조건
	private String jinjeopAlwncePlus;    //진접공차최대값
	private String jinjeopAlwnceMinus;   //진접공차최저값
	
	private String jinjeop2Cond;         //진접조건
	private String jinjeop2AlwncePlus;   //진접공차최대값
	private String jinjeop2AlwnceMinus;  //진접공차최저값
	private String push1Cond;            //1차푸셔조건
	private String push1AlwncePlus;      //1차푸셔공차최대값
	private String push1AlwnceMinus;     //1차푸셔공차최저값
	
	private String reformCond;           //리폼조건
	private String reformAlwncePlus;     //리폼공차최대값
	private String reformAlwnceMinus;    //리폼공차최저값
	
	private String coolCond;			//냉각조건			- 10.15 추가
	private String coolAlwncePlus;      //냉각공차최대값	- 10.15 추가
	private String coolAlwnceMinus;		//냉각공차최저값	- 10.15 추가
	
	private String useYnCd;              //사용여부
	private String regId;                //등록자
	private Date regDate;                //등록일
	private String updId;                //수정자
	private Date updDate;                //수정일

}