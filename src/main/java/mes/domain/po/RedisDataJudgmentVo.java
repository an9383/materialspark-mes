package mes.domain.po;

import lombok.Data;

@Data
public class RedisDataJudgmentVo {
	
	private String menuAuth;			//메뉴권한
	private String typeCd;				//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
	private String equipCd;
	private String equipNm;
	private String equipCondMinus;
	private String equipCond;
	private String equipCondPlus;
	private String agtData;
	private String message;
	
	private String goodsCd;
	private String goodsNm;
	private String ordLotNo;
	private String workOrdNo;
	private String ordGubun;
	private String statusCd;
	private String statusNm;
	private String mainWorkChargr;
	private String mainWorkChargrNm;
	
}