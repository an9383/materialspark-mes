package mes.domain.bm;

import java.util.Date;
import lombok.Data;

@Data
public class GoodsCodeAdmVo {

	private String menuAuth;              //메뉴권한
	private String goodsSeq;	
	private String goodsCd;
	private String goodsNm;
	private String model;
	private String modelNo;
	private String alnicuMatrlCd;
	private String alnicuMatrlNm;	
	private String filmMatrlCd;
	private String filmMatrlNm;
	private String qutyCd;		
	private String qutyNm;	
	private String gubunNm;
	private String chamferYnNm;	
	private String gravity;
	private String dealCorpCd;
	private String dealCorpNm;	
	private String tmUnitCd;
	private String tmUnitNm;	
	private String packUnitCd;
	private String packUnitNm;	
	private String etc1;
	private String productQty;
	private String goodsDesc;
	private String useYnCd;
	private String useYnNm;	
	private String regId;
	private Date regDate;
	private String updId;
	private Date updDate;
	private String fpMainGubun;
	private String tecTime;
	private String factoryCode;
	private String goodsPitch;
	private String filmWeight;
	
	private String searchVal;
	private String modify;	//수정시 모델No 변경 감지
	private String gijongCd;
	private String gijongNm;
	private String equipCd;
	private String lgesCode;
	private String goodsSampleYn;
	private String vendorCode;
	
}