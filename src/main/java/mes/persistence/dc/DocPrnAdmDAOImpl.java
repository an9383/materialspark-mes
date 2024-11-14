package mes.persistence.dc;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.dc.DocPrnAdmVo;

@Repository
public class DocPrnAdmDAOImpl implements DocPrnAdmDAO {
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.dc.docPrnAdmMapper";
	
	//문서관리 조회
	@Override
	public List<DocPrnAdmVo> docPrnAdmList_F1F2F3(DocPrnAdmVo docPrnAdmVo) throws Exception{
		return session.selectList(namespace + ".docPrnAdmList_F1F2F3", docPrnAdmVo);
	}
	
	//문서관리 날짜  조회
	@Override
	public List<DocPrnAdmVo> docPrnAdmDateList_F1F2F3(DocPrnAdmVo docPrnAdmVo) throws Exception{
		return session.selectList(namespace + ".docPrnAdmDateList_F1F2F3", docPrnAdmVo);
	}
	
	//문서관리 상세 조회
	@Override
	public DocPrnAdmVo docPrnAdmRead_F1F2F3(DocPrnAdmVo docPrnAdmVo) throws Exception{
		return session.selectOne(namespace + ".selectOne", docPrnAdmVo);
	}
			
	//문서관리 등록
	@Override
	public void docPrnAdmCreate_F1F2F3(DocPrnAdmVo docPrnAdmVo) throws Exception{
		session.insert(namespace + ".docPrnAdmCreate_F1F2F3",docPrnAdmVo);
	}
	
	//문서관리 수정
	@Override
	public void docPrnAdmUpdate_F1F2F3(DocPrnAdmVo docPrnAdmVo) throws Exception{
		session.update(namespace + ".docPrnAdmUpdate_F1F2F3",docPrnAdmVo);
	}
	
	//문서관리 삭제
	public void docPrnAdmDelete_F1F2F3(DocPrnAdmVo docPrnAdmVo) throws Exception{
		session.delete(namespace +".docPrnAdmDelete_F1F2F3",docPrnAdmVo);
	}
	
	//문서관리 상세 조회
	@Override
	public int docPrnAdmOnlyMaxCodeRead_F1F2F3(DocPrnAdmVo docPrnAdmVo) throws Exception{
		return session.selectOne(namespace + ".docPrnAdmOnlyMaxCodeRead_F1F2F3", docPrnAdmVo);
	}
}
