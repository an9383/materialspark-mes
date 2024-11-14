package mes.domain.sm;

import java.util.Date;
import lombok.Data;

@Data
public class MenuAuthVo {
	
	private String menuAuth;
	private String menuId;
	private String departmentCd; 
	private String departmentNm; //부서이름
	private String userNumber;
	private String gradeCd;
	private String gradeNm;
	private String useYnCd;
	private String useYnNm;
	private String regId;
	private String regDate;
	private String updId;
	private String updDate;
	private int cnt;
	
	private String baseCd;
	private String baseCdNm;
	private String baseGroupCd;
	private String etc1;
	private String userAuthCode;
	private String userAuthCodeName;
	
	private String userName; //성명
	private String spot; //직위

	//권한사용이력 
	private String lotNo;
	private String loginUserId;//로그인된 유저번호
	private String useAuthCode;
	private String useUserId;//사용되는 유저번호 , 그외 regDate 사용
	
}