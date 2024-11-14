package mes.domain.qm;

import java.util.Date;

import lombok.Data;

@Data
public class ShipIspListVo {
	
	private String idx;
	private String trayNo;
	private String trayNo1;
	private String trayNo2;
	private String seq;
	private String workOrdNo;
	private String matrlLotNo;
	private String filmLotNo;
	private String inspStatus;
	private String reInspStatus;
	private String disStatus;
	private String inspDate;
	private String productDate;
	private String faultyCnt;
	private String faultyTrayNo;
	private String inspChargr;
	private String dayNightCd;
	private String faultyGubun;
	private String nextGubun;
	private String inspDesc;
	private String sampleCnt;
	private String inspGubun;
	private String regId;
	private String regDate;
	private String updId;
	private String updDate;

	//추가사항
	private String[] reInspStatusArr;
	private String dateCheck;
	private String chooseDateFrom;
	private String chooseDateTo;
	private String inspChargrNm;
	private String inspStatusNm;
	private String reInspStatusNm;
	private String dayNightCdNm;
	private String equipCd;
	
}