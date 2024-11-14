package mes.domain.bm;

import java.util.Date;
import lombok.Data;

@Data
public class EquipCodeAdmVo {		//설비 코드관리 Table
	
	private String menuAuth;        //메뉴권한
	private String equipCd;			//설비코드
	private String equipNm;         //설비명
	private String equipGroup;      //설비그룹
	private String equipGroupNm;    //설비그룹명
	private String equipCtrgy;      //설비분류
	private String equipCtrgyNm;    //설비분류명
	private String modelNm;         //모델명
	private String mfcDealCorpCd;   //제조업체
	private String mfcDealCorpNm;   //제조업체명
	private String buyDealCorpCd;   //구입업체코드	
	private String buyDealCorpNm;   //구입업체명
	private String buyDate;         //구매일
	private String voltage;         //전압
	private String pressure;        //공압
	private String telNo;           //전화번호
	private String faxNo;           //팩스번호
	private String installLocation; //설치장소
	private String installLocationNm; //설치장소명	
	private String capa;            //Capa(용량)
	private String etc1;            //체크1
	private String etc2;            //체크2
	private String manufactrCd;     //제품공장	
	private String manufactrNm;     //제품공장명
	private String equipLineCd;		//설비라인 코드
	private String equipLineNm;		//설비라인 명
	private String useYnCd;         //사용여부
	private String virtualEquip;    //가상 호기
	private String dealCorpDesc;    //비고
	private String equipCheck;    	//설비체크	
	private String selectYn;        //기본조회여부
	
	private String fakeEquipNm;		//가짜설비코드
	private String fakeDateCd;      //가짜날짜대체코드
	
	private String regId;           //등록자
	private Date regDate;           //등록일
	private String updId;           //수정자
	private Date updDate;           //수정일
	
	private String modify;			//수정시 equipNm 변경 감지
	private String workOrdNo;           //작지번호
	private String workerId;
	private String equipCapa;           //열개수
	private String equipTacTime;		// 설비별 텍타임
	private String equipGubun;		//설비구분자

}
