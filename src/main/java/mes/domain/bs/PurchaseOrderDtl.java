package mes.domain.bs;

import lombok.Data;

@Data
public class PurchaseOrderDtl {
	
	private String poSeq;		//PO시퀀스
	private String poGroup;     //PO그룹
	private String boxNo;       //제품번호
	private String boxNoOld;
	private String poNoSeq;
	private int    packCnt;     //포장수량
	private int    outputCnt;  	//출고수량
	private String poDate;      //출고일자
	private String regId;       //등록자
	private String regDate;     //등록일
	private String updId;       //수정자
	private String updDate;     //수정일
	
	private String poNo;
	private String poQty;
	private String outputQty;
	private String remainQty;
	private String poGubunCd;
	private String poGubunNm;
	private String poCode;
	private String poAttn;
	private String moneyUnitCd;
	private String moneyUnitNm;
	private String costUnit;
	private String totalPrice;
	private String deliveryDate;
	private String dealCorpCd;
	private String dealCorpNm;
	private String poDesc;
	private String goodsCd;
	private String goodsNm;
	
	private String completeYn;
	
	private String customerLotNo;
	private String checkLikeCustomerLotNo;
	private String factoryCode;
	private String allCount;
	private String checkCount;
	private String locationInputDate;
	
	private String customerLotNo1;
	private String customerLotNo2;
	
}