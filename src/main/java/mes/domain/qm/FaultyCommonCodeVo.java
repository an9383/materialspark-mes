package mes.domain.qm;

import java.util.Date;
import lombok.Data;

@Data
public class FaultyCommonCodeVo {
	
	private String menuAuth;        //메뉴권한
	private String baseCd;          //기초코드
	private String baseCdNm;        //기초코드명
	private String baseCdAbbr;      //기초코드약어명
	private String baseGroupCd;		//기초그룹코드
	private String baseCdDesc;      //기초코드상세
	private String etc1;            //기초코드기타1
	private String etc2;            //기초코드기타2
	private String etc3;            //기초코드기타3
	private String etc4;            //기초코드기타4
	private String etc5;            //기초코드기타5
	private String etc6;            //기초코드기타6
	private String etc7;            //기초코드기타7
	private String etc8;            //기초코드기타8
	private String etc9;            //기초코드기타9
	private String etc10;           //기초코드기타10
	private String useYnCd;         //사용여부
	private String useYnNm;         //사용여부명
	private String regId;           //등록자
	private Date regDate;           //등록일
	private String updId;           //수정자
	private Date updDate;           //수정일

}