package mes.domain.dc;

import lombok.Data;

@Data
public class DocumentMngtVo {

	private String mngtCode;		//관리 코드
	private String fileNm;			//파일명
	private String documentDesc;	//비고
	private String fileRegDate;		//파일 등록일
	private String fileRegYear;		//파일 등록 년
	private String fileRegDay;		//파일 등록 월
	private String regId;			//등록자
	private String regNm;			//등록자Nm
	private String regDate;			//등록일
	private String updId;			//수정자
	private String updDate;			//수정일
	
	//추가항목
	private String startDate;
	private String endDate;
	
}
