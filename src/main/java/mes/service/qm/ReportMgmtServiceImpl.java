package mes.service.qm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.qm.ReportMgmtVo;
import mes.persistence.qm.ReportMgmtDAO;

@Service
public class ReportMgmtServiceImpl implements ReportMgmtService {

	@Inject
	private ReportMgmtDAO dao;

	//성적서관리_Adm
	//성적서관리_Adm목로조회
	@Override
	public List<ReportMgmtVo> reportMgmtAdmList(ReportMgmtVo reportMgmtVo) throws Exception {
		return dao.reportMgmtAdmList(reportMgmtVo);
	}
	
	//성적서관리_Adm 상세 조회
	@Override
	public ReportMgmtVo reportMgmtAdmRead(ReportMgmtVo reportMgmtVo) throws Exception{
		return dao.reportMgmtAdmRead(reportMgmtVo);
	}
			
	//성적서관리_Adm 등록
	@Override
	public void reportMgmtAdmCreate(ReportMgmtVo reportMgmtVo) throws Exception{
		dao.reportMgmtAdmCreate(reportMgmtVo);
	}
	
	//성적서관리_Adm 수정
	@Override
	public void reportMgmtAdmUpdate(ReportMgmtVo reportMgmtVo) throws Exception{
		dao.reportMgmtAdmUpdate(reportMgmtVo);
	}
	
	//성적서관리_Adm 삭제
	public void reportMgmtAdmDelete(ReportMgmtVo reportMgmtVo) throws Exception{
		dao.reportMgmtAdmDelete(reportMgmtVo);
	}
	
	//성적서관리_Adm 인덱스 지정
	@Override
	public int reportMgmtAdmIdx(String tabGubunCd) throws Exception{
		return dao.reportMgmtAdmIdx(tabGubunCd);
	}
	
	//성적서관리_Dtl
	//성적서관리_Dtl목로조회
	@Override
	public List<ReportMgmtVo> reportMgmtDtlList(ReportMgmtVo reportMgmtVo) throws Exception {
		return dao.reportMgmtDtlList(reportMgmtVo);
	}
	
	//성적서관리_Dtl 등록
	@Override
	public void reportMgmtDtlCreate(ReportMgmtVo reportMgmtVo) throws Exception{
		dao.reportMgmtDtlCreate(reportMgmtVo);
	}
	
	//성적서관리_Dtl 수정
	@Override
	public void reportMgmtDtlUpdate(ReportMgmtVo reportMgmtVo) throws Exception{
		dao.reportMgmtDtlUpdate(reportMgmtVo);
	}
	
	//성적서관리_Dtl 삭제
	public void reportMgmtDtlDelete(ReportMgmtVo reportMgmtVo) throws Exception{
		dao.reportMgmtDtlDelete(reportMgmtVo);
	}
	
	//성적서관리_Dtl 시퀀스 지정
	@Override
	public int reportMgmtDtlSeq(String value) throws Exception{
		return dao.reportMgmtDtlSeq(value);
	}
	
}
