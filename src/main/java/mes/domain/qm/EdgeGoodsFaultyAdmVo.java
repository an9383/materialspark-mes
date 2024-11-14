package mes.domain.qm;

import lombok.Data;

@Data
public class EdgeGoodsFaultyAdmVo {
	
	private String menuAuth;        //	메뉴권한
	private String equipCd;			//	설비코드
	private String equipNm;			//	설비명
	
	private String 	workOrdNo;		//	작업지시번호
	private String 	ordLotNo;		//  생산LotNo
	private String 	faultyRegDate;	//  불량등록일
	private String 	majorCd;		//  대분류 코드
	private String 	minorCd;		//  소분류 코드
	private String 	faultyCnt;		//  불량 개수
	private int totalEdgeFaultyCnt;	// 엣지 총 불량 수량
	private String 	seq;			//  시퀀스
	private String 	inspctCharger;	//  검사 담당자
	private String 	dayNightCd;		//  주야 구분
	private String 	workOrdDate;	//  생산 전표일자
	private String 	regId;			//  등록자
	private String 	regDate;		//  등록일
	private String 	updId;			//  수정자
	private String 	updDate;		//  수정일

	private String inspctChargerNm;
	


}