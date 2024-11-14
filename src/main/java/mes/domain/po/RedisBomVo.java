package mes.domain.po;

import lombok.Data;

@Data
public class RedisBomVo {
	
	private String menuAuth;				//메뉴권한
	private String ordLotNo;				//LotNo
	private String workOrdNo;				//IF_Workorder_CD	- 작지번호
	private String ordGubun;
	private String goodsCd;					//IF_GOODS_CD 		- 제품코드
	private String goodsNm;					//IF_GOODS_NM		- 제품명
	private String equipCd;					//설비코드
	private String equipNm;					//IF_Equip_CD		- 설비명
	private String regDate;					//CreatedDateTime	- 등록일자? 시스템등록일자인지 측정일자인지??	--redis 0번 DB에서 사용
	private String ctime;					//CreatedDateTime	- 등록일자? 시스템등록일자인지 측정일자인지??	--redis 1번 DB에서 사용
	
	//운영서버 MES Redis의 DB_1번 불러올 때 사용(초,중물 등록)
	private double[] dataSetTempVal;		//온도 값
	private String[] dataSetTempNm;			//온도 변수명
	private String[] dataSetTempStatus;		//온도 ??
	private double[] dataSetTimeVal;		//시간 값
	private String[] dataSetTimeNm;			//시간 변수명
	private String[] dataSetTimeStatus;		//시간 ??
	private double[] dataSetPrssVal;		//압력 값
	private String[] dataSetPrssNm;			//압력 변수명
	private String[] dataSetPrssStatus;		//압력 ??
	private String[] dataSetVisionVal;		//치수 값
	private String[] dataSetVisionNm;		//치수 변수명
	private String[] dataSetVisionStatus;	//치수 ??
	
	
	//온도
	private double A_firstUpleftCond;		//IF_1stMetalUL 	- 1차메탈상좌
	private double A_firstUprightCond;		//IF_1stMetalUR 	- 1차메탈상우
	private double A_firstDownleftCond; 	//IF_1stMetalDL 	- 1차메탈하좌
	private double A_firstDownrightCond;	//IF_1stMetalDR 	- 1차메탈하우
	private double A_jinjeop1UpCond;		//IF_1stJinjubU 	- 진접1상
	private double A_jinjeop1DownCond;		//IF_1stJinjubD 	- 진접1하
	private double A_secondUpleftCond;		//IF_2ndMetalUL 	- 2차메탈상좌
	private double A_secondUprightCond;		//IF_2ndMetalUR 	- 2차메탈상우
	private double A_secondDownleftCond;	//IF_2ndMetalDL 	- 2차메탈하좌
	private double A_secondDownrightCond;	//IF_2ndMetalDR 	- 2차메탈하우
	private double A_push1UpCond;			//IF_1stMetalpushU	- 1차푸셔상
	private double A_push1DownCond;			//IF_1stMetalpushD	- 1차푸셔하
	private double A_thirdUpleftCond;		//IF_3rdMetalUL 	- 3차메탈상좌
	private double A_thirdUprightCond;		//IF_3rdMetalUR 	- 3차메탈상우
	private double A_thirdDownleftCond;		//IF_3rdMetalDL 	- 3차메탈하좌
	private double A_thirdDownrightCond;	//IF_3rdMetalDR 	- 3차메탈하우
	private double A_jinjeop2UpCond;		//IF_2ndJinjubU 	- 진접2상
	private double A_jinjeop2DownCond;		//IF_2ndJinjubD 	- 진접2하
		
	//시간
	private double IF_Ga_heat_Time;			//IF_Ga_heat_Time		- 가융착(열)	-> MES 등록 안함
	private double B_fitupCond;				//IF_Ga_press_Time		- 가웅착(압)	-> 가접1
	private double B_firstCond;				//IF_1stMT_heat_Time	- 1차메탈
	private double B_push1Cond;				//IF_1stMT_push_Time	- 1차푸셔
	private double B_jinjeopCond;			//IF_Jin_Time			- 진접1
	private double B_secondCond;			//IF_2ndMT_heat_Time	- 2차메탈
	private double IF_2ndMT_push_Time;		//IF_2ndMT_push_Time	- 2차푸셔		-> 사용 안함
	private double B_coolCond;				//IF_cool_Time			- 냉각
	private double B_jinjeop2Cond;			//IF_reform_Time		- 진접2
	private double IF_Su_Time;				//IF_Su_Time			- 수평가대		-> MES 등록 안함
	private double IF_3rdMT_push_Time;		//IF_3rdMT_push_Time	- 3차푸셔		-> 사용 안함
	private double B_thirdCond;				//IF_3rdMT_heat_Time	- 3차메탈
	
	//압력
	private double C_push1Cond; 			//IF_Pressure_1ch - 1차푸셔 압력
	private double C_jinjeopCond;			//IF_Pressure_2ch - 1차진접 압력
	private double C_jinjeop2Cond;			//IF_Pressure_3ch - 2차진접 압력
	
	//치수
	private double D_wpLeftAlwnce;			//HeadLength_Left				- WP좌
	private double D_pitchLeftAlwnce;		//MetalLength_Left				- Pitch좌
	private double D_ppfWingLeftAlwnce;		//WingLength_Left				- PPF날개좌
	private double D_wpRightAlwnce;			//HeadLength_Right				- WP우
	private double D_ppfDepthRightAlwnce;	//FilmWidth_Right				- PPF우
	private double D_pitchRightAlwnce;		//MetalLength_Right				- Pitch우
	private double D_ppfWingRightAlwnce;	//WingLength_Right				- PPF날개우
	private double D_bulgeLeftupHeight;		//FilmDolgi_LeftUp_Height		- 돌기좌상높이
	private double D_bulgeLeftupWidth;		//FilmDolgi_LeftUp_Width		- 돌기좌상너비
	private double D_bulgeLeftdownHeight;	//FilmDolgi_LeftDown_Height		- 돌기좌하높이
	private double D_bulgeLeftdownWidth;	//FilmDolgi_LeftDown_Width		- 돌기좌하너비
	private double D_bulgeRightupHeight;	//FilmDolgi_RightUp_Height		- 돌기우상높이
	private double D_bulgeRightupWidth;		//FilmDolgi_RightUp_Width		- 돌기우상너비
	private double D_bulgeRightdownHeight;	//FilmDolgi_RightDown_Height	- 돌기우하높이
	private double D_bulgeRightdownWidth;	//FilmDolgi_RightDown_Width		- 돌기우하너비
	private double D_ppfDepthLeftAlwnce;	//FilmWidth_Left				- PPF좌
	private double D_filmUp;				//FilmTotalLength_Up			- 필름상 -> 필름폭 계산에 사용((필름상 + 필름하)/2 = 필름 폭)
	private double D_filmDown;				//FilmTotalLength_Down			- 필름하 -> 필름폭 계산에 사용((필름상 + 필름하)/2 = 필름 폭)
	private double D_metalDepthUp;			//MetalWidth_Up					- 메탈폭상 -> 메탈폭 계산에 사용((메탈폭상 + 메탈폭하)/2 = 메탈 폭)
	private double D_metalDepthDown;		//MetalWidth_Down				- 메탈폭하 -> 메탈폭 계산에 사용((메탈폭상 + 메탈폭하)/2 = 메탈 폭)

}