package mes.domain.wm;

import java.util.Date;
import lombok.Data;

@Data
public class EquipCondCommonAdmVo {
	
	private String menuAuth;        //메뉴권한
	private String equipCondSeq;	//설비코드
	private String equipCd;			//설비코드
	private String goodsCd;			//제품코드
	private String condRegDate;		//조건등록일
	private String useYnCd;			//사용여부
	private String regId;			//등록자
	private Date regDate;			//등록일
	private String updId;			//수정자
	private Date updDate;			//수정일

}