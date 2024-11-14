package mes.domain.po;

import java.util.Date;
import lombok.Data;

@Data
public class EquipTroubleFaultyAdmVo {
	
	private String menuAuth;
	private String equipCd;             //설비코드
	private String faultyRegDate;       //불량등록일
	private String dayNightCd;          //주야간구분
	private int trbCnt;				 	//설비트러블불량수
	private float trbTotal;				//설비트러블불량총량
	private float trbServo1;            //서보1차
	private float trbServo2;            //서보2차
	private String trbServoContent;     //서보내용
	private float trbFuse1;             //융착부1
	private float trbFuse2;             //융착부2
	private String trbFuseContent;      //융착부내용
	private float trbGearmotor1;        //기어모터1
	private float trbGearmotor2;        //기어모터2
	private String trbGearmotorContent; //기어모터내용
	private float trbTempatur1;         //온도1
	private float trbTempatur2;         //온도2
	private String trbTempaturContent;  //온도내용
	private float trbPnumt1;            //공압1
	private float trbPnumt2;            //공압2
	private String trbPnumtContent;     //공압내용
	private float trbCutting1;          //커팅부1
	private float trbCutting2;          //커팅부2
	private String trbCuttingContent;   //커팅부내용
	private float trbSensor1;           //센서1
	private float trbSensor2;           //센서2
	private String trbSensorContent;    //센서내용
	private float trbCylinder1;         //실린더1
	private float trbCylinder2;         //실린더2
	private String trbCylinderContent;  //실린더내용
	private float trbVision1;           //비젼1
	private float trbVision2;           //비젼2
	private String trbVisionContent;    //비젼내용
	private float trbEtc1;              //기타1
	private float trbEtc2;              //기타2
	private String trbEtcContent;       //기타내용
	private String regId;               //등록자
	private Date regDate;               //등록일
	private String updId;               //수정자
	private Date updDate;               //수정일
	private String workOrdNo;
	private String systemCode;
	private String ordDate;
	
	//private String dayTotalTroubleCount;
	//private String nightTotalTroubleCount;
	//private String totalTroubleCount;
	//private String dayTotalTroubleSum;
	//private String nightTotalTroubleSum;
	//private String totalTroubleSum;
	
	private String faultyDateFrom;	//검색기간 1
	private String faultyDateTo;	//검색기간 2

	private String equipNm;			//설비명
	private String goodsCd;          //제품코드
	private String goodsNm;          //제품명
	private String qutyCd;           //재질코드
	private String alnicuMatrlNm;    //재질명
	private String ordGubun;         //주야
	private String dayNightNm;       //주야간구분
	private int servolCnt;
	private float servoSum;
	private int servolSumEa;
	private int fuseCnt;
	private float fuseSum;
	private int fuselSumEa;
	private int gearmotorCnt;
	private float gearmotorSum;
	private int gearmotorSumEa;
	private int tempaturCnt;
	private float tempaturSum;
	private int tempaturSumEa;
	private int pnumtCnt;
	private float pnumtSum;
	private int pnumtSumEa;
	private int cuttingCnt;
	private float cuttingSum;
	private int cuttingSumEa;
	private int sensorCnt;
	private float sensorSum;
	private int sensorSumEa;
	private int cyliderCnt;
	private float cyliderSum;
	private int cylinderSumEa;
	private int visionCnt;
	private float visionSum;
	private int visionSumEa;
	private int etcCnt;
	private float etcSum;
	private int etcSumEa;
	private String workTeamCd;       //작업조코드
	private String workTeamNm;       //작업조명
	private String mainWorkChargr;   //메인담당
	private String userNm;           //메인담당이름
	
	private String faulty;
	private String gravity;
	
}