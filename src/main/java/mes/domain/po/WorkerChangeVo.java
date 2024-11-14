package mes.domain.po;

import lombok.Data;

@Data
public class WorkerChangeVo {
	
	private String menuAuth;			//메뉴권한
	private String equipCd;				//설비코드
	private String workOrdNo;			//작업지시번호
	private String workChangSeq;		//작업자 변경 시퀀스
	private String ordDate;				//작지일
	private String dayNightCd;			//주야간구분
	private String dayNightNm;			//주야간구분_NM
	private String workTeamCd;			//작업조
	private String workTeamNm;			//작업조_NM
	private String workerId;			//작업자 아이디
	private String workerIdNm;			//작업자 아이디_NM
	private String workStatusCd;		//작업 상태	(작업진행(S)->작업완료(C)->종료(A))
	private String workStatusNm;		//작업 상태	_NM
	private String workerStatusCd;		//작업자 상태 (작업 진행(S) -> 작업자 변경(H) -> 작업완료(C) -> 종료(A))
	private String workerStatusNm;		//작업자 상태_NM
	private String regId;				//등록자
	private String regDate;				//등록일
	private String updId;				//수정자
	private String updDate;				//수정일
	
	//추가항목
	private String readCheckCode1;		//작업자 조회 시 필요한 코드

}