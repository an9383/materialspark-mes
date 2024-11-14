package mes.domain.qm;

import lombok.Data;

@Data
public class ShipInspectTempListVo {
	
	private String chooseDateFrom;
	private String chooseDateTo;
	private String dateCheck;
	private String equipCd;
	private String inspStatus;
	private String matrlLotNo;
	private String filmLotNo;
	private String labelLotNoSeq;
	private String faultyStatus;

	private String productDate;
	private String trayWorkerIdNm;
	private String inspChargrNm;
	private String equipNm;
	private String trayNo;
	private String goodsNm;
	private String qutyNm;
	private String reInspStatus;
	private String faultyStatusNm;
	private String workOrdNo;
	private String workOrdLotNo;
	private String factoryCode;
	private String updDate;

}