package mes.domain.wm;

import lombok.Data;

@Data
public class MonthProductionPlanVo {
	
	private String menuAuth;        //메뉴권한

	
	private String equipCd;           //설비코드
	private String equipNm;           //설비코드
	private String goodsCd;           //제품코드
	private String goodsNm;			//제품코드관리 - 제품명
	private String regId;             //등록자
	private String regDate;             //등록일
	private String updId;             //수정자
	private String updDate;             //수정일
	private String nugye;
	
	//join시 사용
	
	private String model;			//제품코드관리 규격
	private String modelNo;			//제품코드관리 모델No
	private String qutyCd;			//자재코드관리 - 자재코드(A, F, N)
	private String qutyNm;			//자재코드관리 - 자재코드명 (AL, DNP, Nicu)
	private String chamferYnNm;		//자재코드관리 - 면취(압연) 유무
	private String surfaceTrtmtCd;  //자재코드관리 - 표면처리코드
	private String surfaceTrtmtNm;  //자재코드관리 - 표면처리명
	
	private String cplGubun; //확정판&변경판 구분
	private String fpDate;   //년월일
	private String npTime;   //비가동시간
	private String npGubun;  //비가동 구분
	private String completeYn; //확정여부
	private String opTime; //가동시간
	private String tecTime; //텍타임
	private String planCnt; //계획수량
	private String planCnt2; //계획수량
	private String jobChangeDate; //잡체인지 적용일자
	private String jobChangeApply; //잡체인지 적용기간
	private String jobChangeStartDate; //잡체인지 적용기간
	private String jobChangeEndDate; //잡체인지 적용기간
	
	private String theoryCapa; //이론 케파
	private String theoryEquipCnt; //이론 설비수
	private String theoryPlanCnt; //이론 수량
	private String dualCapa; //목표 케파(수량)
	private String equipCnt; //목표 설비수
	private String yeild1; //가동률 목표
	private String yeild2; //검사수율 목표
	private String yeildTotal; // 총 수율	
	private String fpGubunja;
	private String outGubun;
	private String dealCorpCd;
	private String dealCorpNm;
	private String lastMonthStock;
	private String outputCnt;
	private String mainGubun;
	private String memo;
	private String planDate;
	private String serverDate;	
	private int seq;
	private String memoGubun;
	private String yesterDay; //어제 일자
	private String yesterDayF; //어제 일자 전체

	
	private String dayList;
	private String dayListNull;
	private String planDateList;
	
	private String planDate1;
	private String planDate2;
	private String planDate3;
	private String planDate4;
	private String planDate5;
	private String planDate6;
	private String planDate7;
	private String planDate8;
	private String planDate9;
	private String planDate10;
	private String planDate11;
	private String planDate12;
	private String planDate13;
	private String planDate14;
	private String planDate15;
	private String planDate16;
	private String planDate17;
	private String planDate18;
	private String planDate19;
	private String planDate20;
	private String planDate21;
	private String planDate22;
	private String planDate23;
	private String planDate24;
	private String planDate25;
	private String planDate26;
	private String planDate27;
	private String planDate28;
	private String planDate29;
	private String planDate30;
	private String planDate31;
	private String planDate32;
	private String planDate33;
	private String planDate34;
	private String planDate35;
	private String planDate36;
	private String planDate37;
	private String planDate38;
	private String planDate39;
	private String planDate40;
	
	private String gubun1;
	private String gubun2;
	private String gubun3;
	private String gubun4;
	private String gubun5;
	private String gubun6;
	private String gubun7;
	private String gubun8;
	private String gubun9;
	private String gubun10;
	private String gubun11;
	private String gubun12;
	private String gubun13;
	private String gubun14;
	private String gubun15;
	private String gubun16;
	private String gubun17;
	private String gubun18;
	private String gubun19;
	private String gubun20;
	private String gubun21;
	private String gubun22;
	private String gubun23;
	private String gubun24;
	private String gubun25;
	private String gubun26;
	private String gubun27;
	private String gubun28;
	private String gubun29;
	private String gubun30;
	private String gubun31;
	private String gubun32;
	private String gubun33;
	private String gubun34;
	private String gubun35;
	private String gubun36;
	private String gubun37;
	private String gubun38;
	private String gubun39;
	private String gubun40;

	private String gubun;
	private String gubunNm;
	private String dataSum;
	private String dataSumSub;
	
	private String fpDate1;
	private String fpDate2;
	private String fpDate3;
	private String fpDate4;
	private String fpDate5;
	private String fpDate6;
	private String fpDate7;
	private String fpDate8;
	private String fpDate9;
	private String fpDate10;
	private String fpDate11;
	private String fpDate12;
	private String fpDate13;
	private String fpDate14;
	private String fpDate15;
	private String fpDate16;
	private String fpDate17;
	private String fpDate18;
	private String fpDate19;
	private String fpDate20;
	private String fpDate21;
	private String fpDate22;
	private String fpDate23;
	private String fpDate24;
	private String fpDate25;
	private String fpDate26;
	private String fpDate27;
	private String fpDate28;
	private String fpDate29;
	private String fpDate30;
	private String fpDate31;

	
	private String chooseDateTo;
	private String chooseDateFrom;
	private String lastDate;
	
	
	private String dayNightGubun;	
	private String productGroup;
	private String productMan; 
	private String sumOutputCnt; 
	
	private String gijongCd; 
	private String gijongNm; 

	private String day_;
	private String gubunCnt;
	private String maxValue;
	private String poQty;
	private String nextMonth;
	private String cnt;
	
	

}