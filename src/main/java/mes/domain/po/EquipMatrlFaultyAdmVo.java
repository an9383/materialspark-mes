package mes.domain.po;

import java.util.Date;
import lombok.Data;

@Data
public class EquipMatrlFaultyAdmVo {
	
	private String menuAuth;
	private String equipCd;          //설비코드
	private String faultyRegDate;    //불량등록일
	private String dayNightCd;       //주야간구분
	private int matrlCnt;			 //원자재불량수
	private float matrlTotal;		 //원자재불량총량
	private float matrlMmb;          //MMB
	private float matrlMms;          //MMS
	private float matrlMaliensbst;   //M이물
	private float matrlMflex;        //M휨
	private float matrlMpolutn;      //M오염
	private float matrlGilt;         //도금박리
	private float matrlMstab;        //찍힘
	private float matrlFagglomt;     //권취
	private float matrlSpot;         //얼룩
	private String regId;             //등록자
	private Date regDate;            //등록일
	private String updId;            //수정자
	private Date updDate;            //수정일
	private String workOrdNo;
	private String systemCode;
	private String ordDate;
	//private String dayTotalMatrlSum;
	//private String nightTotalMatrlSum;
	//private String totalMatrlSum;
	
	private String equipNm;
	private String dayNightNm;
	private String faultyDateFrom;	//검색기간 1
	private String faultyDateTo;	//검색기간 2
	
	private String goodsCd;          //제품코드
	private String goodsNm;          //제품명
	private String qutyCd;           //재질코드
	private String alnicuMatrlNm;    //재질명
	private String ordGubun;         //주야
	private int matrlMmbEa;          //수량(EA)
	private int matrlMmsEa;          //수량(EA)
	private int matrlMaliensbstEa;   //수량(EA)
	private int matrlMflexEa;        //수량(EA)
	private int matrlMpolutnEa;      //수량(EA)
	private int matrlGiltEa;         //수량(EA)
	private int matrlMstabEa;        //수량(EA)
	private int matrlFagglomtEa;     //수량(EA)
	private int matrlSpotEa;         //수량(EA)	
	private String workTeamCd;       //작업조코드
	private String workTeamNm;       //작업조명
	private String mainWorkChargr;   //메인담당
	private String userNm;            //메인담당이름
	
	private String faulty;
	private String gravity;
}