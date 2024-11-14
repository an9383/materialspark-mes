package mes.domain.po;

import lombok.Data;

@Data
public class RealTimeRedisBomVo {
	
	private String menuAuth;
	private String workOrdNo;
	private String ordLotNo;
	private String goodsCd;
	private String goodsNm;
	private String equipCd;
	private String equipNm;
	private String ordGubun;
	
	private String ctime;			//Resdis에서의 수집시간
	private String ctimeTemp;		//온도 실수집시간
	private String ctimeTime;		//시간 실수집시간
	private String ctimePrss;		//압력 실수집시간
	private String ctimeVision;		//치수 실수집시간
	private String workStatusCd;
	private String condStatus;		//??
	
	private String[] dataSetTempVal;		//온도값
	private String[] dataSetTempNm;			//온도명
	private String[] dataSetTempStatus;		//??
	private String[] dataSetTimeVal;		//시간값
	private String[] dataSetTimeNm;			//시간명
	private String[] dataSetTimeStatus;		//??
	private String[] dataSetPrssVal;		//압력값
	private String[] dataSetPrssNm;			//압력명
	private String[] dataSetPrssStatus;		//??
	
	//MTP 2동에서 사용
	private String[] dataSetVisionVal;		//치수값
	private String[] dataSetVisionNm;		//치수명
	private String[] dataSetVisionStatus;	//??
	
	//솔브레인SLD 에서 사용
	private String[] dataSetVisIpcVal;		//치수값
	private String[] dataSetVisIpcNm;		//치수명
	private String[] dataSetdataSetVisIpcStatus;	//??
	
}