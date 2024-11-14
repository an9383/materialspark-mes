package mes.domain.bs;

import lombok.Data;

@Data
public class PurchaseOrderOutputHistVo {
	private String menuAuth;
	private String poSeq;
	private String poNo;
	private String poGroup;
	private int preOutputQty;
	private int poQty;
	private int outputQty;
	private int remainQty;
	private String outputHistDate;
	private String approvalCd;
	private String regId;
	private String regDate;
	private String updId;
	private String updDate;
	private String outputGubun; //수기출고 구분
	private int trayCnt;
	private int cancelOutputSum;	//출하 취소 합계
	
	//추가항목
	private String poGroupOrder;
	private String completeYn;
	private String goodsStatus;
	private String goodsStatusNm;
	private String exceptOutput;
	private String exceptPallet;
	private String factoryCode;
}