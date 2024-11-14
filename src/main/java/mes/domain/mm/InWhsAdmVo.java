package mes.domain.mm;

import lombok.Data;

@Data
public class InWhsAdmVo {

	private String poNo;            //발주번호
	private Integer poSeq;          //발주시퀀스
	private String inSeq;          //가입고시퀀스
	private String lotNo;           //LOT번호
	private String barcodeNo;       //바코드번호
	private String partCd;          //부품코드
	private String partNm;          //
	private String partRev;         //부품리비전
	private String partSpec;        //
	private String partGubun;       //
	private String partUnit;        //
	private String partQty;         //
	private String preInWhsQty;     //가입고량
	private String inWhsQty;        //입고량
	private String remainQty;       //남은수량
	private String spplyCorpCd;     //공급업체
	private String spplyCorpNm;     //
	private String preInWhsDate;    //가입고일
	private String preInStatus;     //가입고상태
	private String inWhsDate;       //입고일
	private String inspectDate;     //수입검사일자
	private String approvalCd;      //승인여부
	private String approvalNm;      //
	private String partChargr;      //자재담당자
	private String locationCd;		//창고코드
	private String locationNm;		//
	private String areaCd;			//구역코드
	private String areaNm;			//
	private String floorCd;			//위치코드
	private String floorNm;			//
	private String locationNo;		//Location No
	private String inWhsDesc;       //비고
	private String regId;           //등록자
	private String regDate;         //등록일
	private String updId;           //수정자
	private String updDate;         //수정일
	
	private String startDate;
	private String endDate;
	private String barcodeYn;
	
	
	
	private String safyStockCnt;		//안전재고
	private String addQty;
	private String payYn;
	private String inspectYn;
	private String inspectQty;
	private String adjustQty;
	private String faultyQty;
	private String returnQty;
	private String exceptQty;
	private String diffQty;
	private String statusCd;
	private String preOutWhsDate;
	private String preOutEquipCd;
	private String preOutPartCd;
	private String preOutQty;
	private String preWorkCharger;
	private String preWorkChargerNm;
	private String outWhsDate;
	private String outEquipCd;
	private String outPartCd;
	private String outQty;
	private String outWorkCharger;
	private String manufactrCd;
	private String dealCorpCd;
	private String dealCorpNm;
	private String poDate;
	private String poDesc;
	private String dlvDate;
	private String receiptGubun;
	private String receiptGubunNm;
	private String pairCnt;
	private String faultyCnt;
	private String tmMon;
	private String status;
	private String contDtlNo;
	private String searchOption;
}
