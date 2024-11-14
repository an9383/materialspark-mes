package mes.service.qm;

import java.util.List;

import mes.domain.qm.ReportMgmtVo;

public interface ReportMgmtService {
	
	//성적서관리_Adm
	//성적서관리_Adm목로조회
	public List<ReportMgmtVo> reportMgmtAdmList(ReportMgmtVo reportMgmtVo) throws Exception;
	
	//성적서관리_Adm 상세 조회
	public ReportMgmtVo reportMgmtAdmRead(ReportMgmtVo reportMgmtVo) throws Exception;
	
	//성적서관리_Adm 등록
	public void reportMgmtAdmCreate(ReportMgmtVo reportMgmtVo) throws Exception;
	
	//성적서관리_Adm 수정
	public void reportMgmtAdmUpdate(ReportMgmtVo reportMgmtVo) throws Exception;

	//성적서관리_Adm 삭제
	public void reportMgmtAdmDelete(ReportMgmtVo reportMgmtVo) throws Exception;
	
	//성적서관리_Adm 인덱스 지정
	public int reportMgmtAdmIdx(String tabGubunCd) throws Exception;
	
	
	//성적서관리_Dtl
	//성적서관리_Dtl목로조회
	public List<ReportMgmtVo> reportMgmtDtlList(ReportMgmtVo reportMgmtVo) throws Exception;
	
	//성적서관리_Dtl 등록
	public void reportMgmtDtlCreate(ReportMgmtVo reportMgmtVo) throws Exception;
	
	//성적서관리_Dtl 수정
	public void reportMgmtDtlUpdate(ReportMgmtVo reportMgmtVo) throws Exception;
	
	//성적서관리_Dtl 삭제
	public void reportMgmtDtlDelete(ReportMgmtVo reportMgmtVo) throws Exception;
	
	//성적서관리_Dtl 시퀀스 지정
	public int reportMgmtDtlSeq(String value) throws Exception;
}