package mes.domain.bm;

import java.util.Date;
import lombok.Data;

@Data
public class GoodsMatrlDtlVo {

	private String menuAuth;              //메뉴권한
	private String goodsCd;
	private String matrlCd;
	private String goodsMatrlDesc;
	private String regId;
	private Date regDate;
	private String updId;
	private Date updDate;
	
	private String matrlNm;
	private String matrlInitial;
	private String gubunCd;
	private String gubunNm;
	private String qutyCd;
	private String qutyNm;
	
}