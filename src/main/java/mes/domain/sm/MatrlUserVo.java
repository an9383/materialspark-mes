package mes.domain.sm;

import java.util.Date;
import lombok.Data;

@Data
public class MatrlUserVo {
	
	private String menuAuth;              //메뉴권한
	private String userNumber;
	private String userId;
	private String userNm;
	private String userPw;
	private String postCd;
	private String postNm;
	private String menuPopupYn;
	private String menuPopupYnNm;
	private String positionCd;
	private String positionNm;
	private String departmentCd;
	private String departmentNm;
	private String gradeCd;
	private String gradeNm;
	private String officeYnCd;
	private String officeYnNm;
	private String chargrDuty;
	private String chargrDutyNm;
	private String teamCd;
	private String teamNm;
	private String joinDate;
	private String resignDate;
	private String empYnCd;
	private String empYnNm;
	private String userDesc;
	private String useYnCd;
	private String userYnNm;	
	private String regId;
	private Date regDate;
	private String updId;
	private Date updDate;
	private String workplaceCd;
	private String workplaceNm;
	private String rememberMe;	//자동로그인
	private String equipGroupCd;	//설비조

	private String gubun; //권한관리로 삭제,수정 등등 할때 권한구분(작지삭제권한일경우 001 그뒤로 002,003....)
	
	private String factoryCode;
	private String teamPageMoveYn;
	
	private String chooseDateFrom;
	private String chooseDateTo;
}