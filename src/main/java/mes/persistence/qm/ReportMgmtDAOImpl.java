package mes.persistence.qm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.qm.ReportMgmtVo;

@Repository
public class ReportMgmtDAOImpl implements ReportMgmtDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.qm.reportMgmtMapper";
	
	//성적서관리_Adm
	//성적서관리_Adm목로조회
	@Override
	public List<ReportMgmtVo> reportMgmtAdmList(ReportMgmtVo reportMgmtVo) throws Exception{
		return session.selectList(namespace+".reportMgmtAdmList", reportMgmtVo);
	}
	
	//성적서관리_Adm 상세 조회
	@Override
	public ReportMgmtVo reportMgmtAdmRead(ReportMgmtVo reportMgmtVo) throws Exception{
		return session.selectOne(namespace + ".reportMgmtAdmRead", reportMgmtVo);
	}
			
	//성적서관리_Adm 등록
	@Override
	public void reportMgmtAdmCreate(ReportMgmtVo reportMgmtVo) throws Exception{
		session.insert(namespace + ".reportMgmtAdmCreate",reportMgmtVo);
	}
	
	//성적서관리_Adm 수정
	@Override
	public void reportMgmtAdmUpdate(ReportMgmtVo reportMgmtVo) throws Exception{
		session.update(namespace + ".reportMgmtAdmUpdate",reportMgmtVo);
	}
	
	//성적서관리_Adm 삭제
	public void reportMgmtAdmDelete(ReportMgmtVo reportMgmtVo) throws Exception{
		session.delete(namespace +".reportMgmtAdmDelete",reportMgmtVo);
	}
	
	//성적서관리_Adm 인덱스 지정
	@Override
	public int reportMgmtAdmIdx(String tabGubunCd) throws Exception{
		return session.selectOne(namespace + ".reportMgmtAdmIdx", tabGubunCd);
	}
	
	//성적서관리_Dtl
	//성적서관리_Dtl목로조회
	@Override
	public List<ReportMgmtVo> reportMgmtDtlList(ReportMgmtVo reportMgmtVo) throws Exception{
		return session.selectList(namespace+".reportMgmtDtlList", reportMgmtVo);
	}
	
	//성적서관리_Dtl 등록
	@Override
	public void reportMgmtDtlCreate(ReportMgmtVo reportMgmtVo) throws Exception{
		session.insert(namespace + ".reportMgmtDtlCreate",reportMgmtVo);
	}
	
	//성적서관리_Dtl 수정
	@Override
	public void reportMgmtDtlUpdate(ReportMgmtVo reportMgmtVo) throws Exception{
		session.update(namespace + ".reportMgmtDtlUpdate",reportMgmtVo);
	}
	
	//성적서관리_Dtl 삭제
	public void reportMgmtDtlDelete(ReportMgmtVo reportMgmtVo) throws Exception{
		session.delete(namespace +".reportMgmtDtlDelete",reportMgmtVo);
	}
	
	//성적서관리_Dtl 시퀀스 지정
	@Override
	public int reportMgmtDtlSeq(String value) throws Exception{
		return session.selectOne(namespace + ".reportMgmtDtlSeq", value);
	}
}