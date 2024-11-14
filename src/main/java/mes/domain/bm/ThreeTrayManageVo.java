package mes.domain.bm;

import java.util.Date;
import lombok.Data;

@Data
public class ThreeTrayManageVo {
	
	private String menuauth;			//메뉴권한
	private String idx;					//인덱스
	private String baseCd;				//기초코드
	private String trayWeightDate;		//날짜
	private String oldTrayWeightDate;	//날짜
	private String gijongCd;			//기종코드
	private String gijongNm;			//기종코드
	private String qutyCd;				//재질구분
	private String qutyNm;				//재질구분
	private String referenceValue;		//기준값
	private String referencePlus;		//기준(+)
	private String referenceMinus;		//기준(-)
	private String useYnCd;       		//사용여부
	private String useYnNm;       		//사용여부
	private String regId;				//등록자
	private Date regDate;				//등록일
	private String updId;				//수정자
	private Date updDate;				//수정일
	
	//추가
	private String maxTrayWeightDate;
	private String goodsCd;

}