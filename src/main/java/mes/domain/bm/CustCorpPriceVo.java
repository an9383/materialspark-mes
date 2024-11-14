package mes.domain.bm;

import lombok.Data;

@Data
public class CustCorpPriceVo {
	
	private String goodsCd;
	private String goodsSeq;
	private String dealCorpCd;
	private String unitRegDate;
	private String moneyUnitCd;
	private String moneyUnitNm;
	private Double unitCost;
	private String unitDesc;
	private String regId;
	private String regDate;
	private String updId;
	private String updDate;
	private String dealCorpNm;
	private String poSeq;
}