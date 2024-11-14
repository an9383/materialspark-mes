package mes.domain.mm;

import lombok.Data;

@Data
public class OutWhsAdmVo {

	private String poNo;
	private Integer poSeq;
	private String inSeq;
	private Integer outSeq;
	private String lotNo;
	private String barcodeNo;
	private String partCd;
	private String partNm;
	private String partRev;
	private String partGubun;
	private String partType;
	private String partSpec;
	private String partUnit;
	private String partUnitNm;
	private String itemCd;
	private String itemRev;
	private String itemNm;
	private String itemGubun;
	private String statusCd;
	private String workOrdNo;
	private String preOutWhsDate;
	private Float preOutQty;
	private String preWorkCharger;
	private String preWorkChargerNm;
	
	private String outWhsDate;
	private Float outQty;
	private String outWorkCharger;
	private String partReqNo;
	private String inWhsDesc;
	private String regId;
	private String regDate;
	private String updId;
	private String updDate;

	private String startDate;
	private String endDate;
	
	private String ordLotNo;
	private Float workOrdQty;
	
	private Integer remainQty;
	private String locationCd;		//창고코드
	private String locationNm;		//창고명
	private String areaCd;			//구역코드
	private String areaNm;			//구역명
	private String floorCd;			//위치코드
	private String floorNm;			//위치명
	private String locationNo;		//Location No
	
	private String workOrdSeq;
	private String minorPrcssCd;
	private String middlePrcssCd;
	
	private String value;
	
	private Float partConsumpt;
	private Float totalConsumpt;
	private Float tmQty;
	private String confirmYn;
	private String diffQty;
	private String realQtyOption;
	private String realQty;
	private String outCase;
	
}
