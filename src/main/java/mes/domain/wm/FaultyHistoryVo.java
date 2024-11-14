package mes.domain.wm;

import lombok.Data;

@Data
public class FaultyHistoryVo {		//불량내역조회(전체) - wmsc0070
	
	private String menuAuth;
	private String equipCd;			//설비코드
	private String equipNm;         //설비명
	private String goodsCd;         //제품코드
	private String goodsNm;         //제품명
	
	private String gravity;
	private String model;
	private int sumTargetCnt;
	private int sumOutputCnt;
	private String qutyNm;
	
	private String ordGubun;        //주야
	private String dayNightCd;      //주야명
	private String dayNightNm;      //주야명
	private String qutyCd;          //제품코드 - 재질코드
	private String alnicuMatrlCd;   //제품명 - 재질코드
	private String alnicuMatrlNm;   //제품명 - 재질명
	private String ordDate;         //작업지시일
	private String prcsCnt;         //공정불량수
	private String prcsTotal;       //공정불량총량
	private String prcsEa;          //공정불량 개수
	private String matrlCnt;        //원자재불량수
	private String matrlTotal;      //원자재불량총량
	private String matrlEa;         //원자재불량 개수
	private String rpcCnt;          //교체불량수
	private String rpcTotal;        //교체불량총량
	private String rpcEa;           //교체불량 개수
	private String trbCnt;          //설비트러블불량수
	private String trbTotal;        //설비트러블불량총량
	private String trbEa;           //설비트러블불량 개수
	
	private String cnt5;
	private String total5;
	private String ea5;
	private String cnt6;
	private String total6;
	private String ea6;
	private String cnt7;
	private String total7;
	private String ea7;
	
	private String workOrdNo;
	
	private String workTeamCd;		//작업지시 작업조 코드
	private String workTeamNm;		//작업지시 작업조 명
	private String userNm;
	
	private String teamCd;			//사용자 정보에 있는 작업조코드
	private String teamNm;			//사용자 정보에 있는 작업조명
	
	private String mainWorkChargr;	//메인작업자
	private String subWorkChargr;	//서브작업자
	private String mainWorkChargrNm;//메인작업자
	private String subWorkChargrNm;	//서브작업자
	
	private String userNumber;		//직원 선택
	private String chooseDate1;		//선택날짜1
	private String chooseDate2;		//선택날짜2
	
	
	private String appearFaultyCnt;		// 외관검사 불량
	private String edgeFaultyCnt;		// 엣지검사 불량
	private String shipFaultyCnt;		// 출하검사 불량
	private String reShipFaultyCnt;		// 생산재검 불량
	private String outputFaultyCnt;		// 외관총 불량
	
	
	
	
	
	
	
	private String metalEa;
	private String filmEa;
	private String siliconEa;
	private String teflonEa;

}