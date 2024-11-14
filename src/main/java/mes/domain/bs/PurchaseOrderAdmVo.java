package mes.domain.bs;

import lombok.Data;

@Data
public class PurchaseOrderAdmVo {
	
	private String menuAuth;              //메뉴권한
	private String poSeq;
	private String poNoSeq;
	private String poGroup;
	private String poNo;
	private String goodsCd;
	private String goodsNm;
	private String modelNo;
	private String poDate;
	private String poDateFrom;
	private String poDateTo;
	private int    poQty;
	private int    preOutputQty;
	private int    outputQty;
	private int    remainQty;
	private int    outputCnt;
	private String poGubunCd;
	private String poGubunNm;
	private String poCode;
	private String poAttn;
	private String moneyUnitCd;
	private String moneyUnitNm;
	private String costUnit;
	private String totalPrice;
	private String totalPrice1;
	private String totalPrice2;
	private String totalPrice3;
	private String deliveryDate; //(기존 납기일) 현 마감일
	private String dealCorpCd;
	private String dealCorpNm;
	private String deliveryDealCorpCd;
	private String deliveryDealCorpNm;
	private String sampleYn;
	private String poDesc;
	private String regId;
	private String regDate;
	private String updId;
	private String updDate;
	private String qutyCd;
	private String qutyNm;
	private String thickness;
	private String depth;
	private String length;
	private String width;
	private String pitch;
	private String outputHistDate;	
	private String outputHistDateFrom;
	private String outputHistDateTo;	
	private String model;
	private String dateGubun;
	private double outputPrice;
	private String disposeGubun;
	private String disposeGubunNm;
	
	private String selBoxNo1;	
	private String selBoxNo2;
	private String matrlLotNo;
	
	private String outputGubun;
	
	private String approvalCd;		//승인구분
	private String approvalNm;		//승인명
	
	private String outputPri; // 출고금액
	private String notOutputPri; // 미출고금액
	
	private String customerLotNo;
	private String checkLikeCustomerLotNo;
	private String boxNo;
	private String packCnt;
	private String packDate;
	private String completeYn;
	private String goodsStatus;
	private String goodsStatusNm;
	private String faultyStatus;
	private String logicOrder;	//로직 순서(1: 미료&완공지정, 2:창고위치지정, 3: 제품출고)

	private String ordGubun;
	private String ordGubunNm;
	private String alnicuMatrlCd;
	private String filmLotNo;
	private String palletQty;
	private String workOrdLotNo;
	private String deadLine; //납기일
	private String isMulti; //다중추적 여부
	private String factoryCode;
	
	private String poGroupCount;
	private String customerPalletNo;
	private String palletMappingDataArray;
	private String factCheck;
	private String checkCount;
	private String inWhsDate;
	private String remainCnt;
	private String goodsSampleYn;
	private String goodsSampleYnNm;
	private String productGubun;
	private String inspDate;
	
	private String customerLotNo1;
	private String customerLotNo2;
	private String customerLotNo3;
}