package mes.persistence.dc;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.dc.DocumentMngtVo;

@Repository
public class DocumentMngtDAOImple implements DocumentMngtDAO {
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.dc.documentMngtMapper";
	
	//문서관리 조회
	@Override
	public List<DocumentMngtVo> documentMngtList_F1F2F3(DocumentMngtVo documentMngtVo) throws Exception{
		return session.selectList(namespace + ".documentMngtList_F1F2F3", documentMngtVo);
	}
	
	//문서관리 날짜  조회
	@Override
	public List<DocumentMngtVo> documentMngtDateList_F1F2F3(DocumentMngtVo documentMngtVo) throws Exception{
		return session.selectList(namespace + ".documentMngtDateList_F1F2F3", documentMngtVo);
	}
	
	//문서관리 상세 조회
	@Override
	public DocumentMngtVo documentMngtRead_F1F2F3(DocumentMngtVo documentMngtVo) throws Exception{
		return session.selectOne(namespace + ".selectOne", documentMngtVo);
	}
			
	//문서관리 등록
	@Override
	public void documentMngtCreate_F1F2F3(DocumentMngtVo documentMngtVo) throws Exception{
		session.insert(namespace + ".documentMngtCreate_F1F2F3",documentMngtVo);
	}
	
	//문서관리 수정
	@Override
	public void documentMngtUpdate_F1F2F3(DocumentMngtVo documentMngtVo) throws Exception{
		session.update(namespace + ".documentMngtUpdate_F1F2F3",documentMngtVo);
	}
	
	//문서관리 삭제
	public void documentMngtDelete_F1F2F3(DocumentMngtVo documentMngtVo) throws Exception{
		session.delete(namespace +".documentMngtDelete_F1F2F3",documentMngtVo);
	}
	
	//문서관리 상세 조회
	@Override
	public int documentMngtOnlyMaxCodeRead_F1F2F3(DocumentMngtVo documentMngtVo) throws Exception{
		return session.selectOne(namespace + ".documentMngtOnlyMaxCodeRead_F1F2F3", documentMngtVo);
	}
}
