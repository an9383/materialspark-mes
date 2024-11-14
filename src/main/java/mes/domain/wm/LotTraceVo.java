package mes.domain.wm;

import java.util.Date;
import lombok.Data;

@Data
public class LotTraceVo {
	
	private String menuAuth;              //메뉴권한
	private String workOrdNo;             //작업지시번호
	private String ordLotNo;			  //작업지시 Lot 번호
	private String equipCd;               //설비코드
	private String equipNm;               //설비명	
	private String goodsCd;               //제품코드
	private String goodsNm;               //제품명
	private String gubun;
	private String gubunNm;
	private String ordGubun;              //작업지시구분
	private String ordGubunNm;            //작업지시구분명
	private String ordDate;               //작업지시등록일
	private String workStatusCd;          //작업상태
	private String workStatusNm;          //작업상태명	
	private String workTeamCd;            //작업조
	private String workTeamNm;            //작업조명
	private String mainWorkChargr;        //주작업담당자
	private String mainWorkChargrNm;      //주작업담당자명
	private String subWorkChargr;         //서브작업담당자
	private String subWorkChargrNm;       //서브작업담당자명	
	private String targetWeight;          //투입중량
	private String outputWeight1;         //생산중량1
	private String outputWeight2;         //생산중량1
	private int targetCnt;                //목표수량
	private int outputCnt;                //생산수량
	private String dealCorpCd;            //거래처코드
	private String dealCorpNm;            //거래처코드명
	private int edgeSampleCnt;            //엣지샘플수량
	private int edgeFaultyCnt;            //엣지검사불량수량
	private int edgeOutputCnt;			  //엣지양품수량
	private String edgeInspctCharger;     //엣지검사담당
	private String edgeInspctChargerNm;   //엣지검사담당명
	private String edgeInspctDate;        //엣지검사일
	private int appearAbrfCnt;            //외관검사해외1
	private int appearAbrsCnt;            //외관검사해외2
	private int appearDmsCnt;             //외관검사국내
	private int appearFaultyCnt;          //외관검사불량수량
	private int appearOutputCnt;		  //외관양품수량
	private String appearInspctCharger;   //외관검사담당
	private String appearInspctChargerNm; //외관검사담당명	
	private String appearInspctDate;      //외관검사일
	private String workStartTime;		  //작지시작시간
	private String workEndTime;			  //작지종료시간
	private String workTime;			  //작지시간
	private String packYn;			  	  //포장여부
	private String packDate;			  //포장일
	private int packCnt;			  	  //포장수	
	private String regId;                 //등록자
	private Date regDate;                 //등록일
	private String updId;                 //수정자
	private Date updDate;                 //수정일
	
	//detail
	private String alnicuMatrlCd;
	private String filmMatrlCd;
	private String matrlCd;
	private String matrlNm;	
	private String lotNo;                 //자재LOT_NO
	private String srLot; 	
	private String barcodeNo;             //바코드	
	private String model;                 //규격
	private String qutyCd;                //재질코드
	private String qutyNm;                //재질명
	private String surfaceTrtmtCd;        //표면처리코드
	private String surfaceTrtmtNm;        //표면처리명	
	private String inWhsQty;
	private String inspectQty;	
	private String inWhsDate;		
	private String BoxNo;
	private String PrcssNm;
	private String lotDesc;	
	private int inPackCnt;		
	private int outPackCnt;	
	
	private String matrlBarcodeNo;
	private String remakeYn;
	
}