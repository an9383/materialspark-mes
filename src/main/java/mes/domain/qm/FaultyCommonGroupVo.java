package mes.domain.qm;

import java.util.Date;
import lombok.Data;

@Data
public class FaultyCommonGroupVo {
	
	private String menuAuth;        //메뉴권한
	private String baseGroupCd;		//기초그룹코드
	private String baseGroupCdNm;	//기초그룹코드명
	private String baseGroupCdDesc;	//기초그룹코드상세
	private String useYnCd;			//사용여부    Y:사용, N:미사용
	private String useYnNm;			//사용여부명	
	private String regId;			//등록자
	private Date regDate;			//등록일
	private String updId;			//수정자
	private Date updDate;			//수정일

}